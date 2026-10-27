import 'package:dr_baksh_dashboard/core/utils/converters.dart';
import 'package:dr_baksh_dashboard/feature/inpatient_statistics/data/model/bed_status_response.dart';
import 'package:dr_baksh_dashboard/feature/inpatient_statistics/data/model/ward_occupancy_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('unwrapObject', () {
    test('strips OUT_PARMS / OUT_PARMS_ROW down to the payload', () {
      final body = {
        'OUT_PARMS': {
          'OUT_PARMS_ROW': {
            'FLOOR_BED_NOT_AVAILABLE': '78',
            'FLOOR_BED_AVAILABLE': '8',
            'CARE_BED_NOT_AVAILABLE': '28',
            'CARE_BED_AVAILABLE': '4',
          },
        },
      };

      final res = BedStatusResponse.fromJson(body);
      expect(res.floorOccupied, 78);
      expect(res.floorAvailable, 8);
      expect(res.careOccupied, 28);
      expect(res.careAvailable, 4);
    });

    test('keeps a single-scalar-field payload intact', () {
      expect(unwrapObject({'X': {'X_ROW': {'TOTAL': '118'}}}),
          {'TOTAL': '118'});
    });

    test('takes the first element when payload is an array', () {
      final node = {
        'OUT_PARMS': {
          'OUT_PARMS_ROW': [
            {'A': '1'},
            {'A': '2'},
          ],
        },
      };
      expect(unwrapObject(node), {'A': '1'});
    });

    test('returns empty map on null / garbage', () {
      expect(unwrapObject(null), <String, dynamic>{});
      expect(unwrapObject({'OUT_PARMS': {'OUT_PARMS_ROW': ''}}),
          {'OUT_PARMS_ROW': ''}); // scalar guard stops descent
    });
  });

  group('unwrapList', () {
    test('wraps a collapsed single object into a one-element list', () {
      expect(
        unwrapList({'UNIT_ID': 3.0, 'BED_FULL': 29.0}),
        [
          {'UNIT_ID': 3.0, 'BED_FULL': 29.0}
        ],
      );
    });

    test('returns [] when empty / missing', () {
      expect(unwrapList(null), isEmpty);
      expect(unwrapList([]), isEmpty);
    });
  });

  group('UnitsOccupancyResponse (Root / WardsTd + IcusTd)', () {
    test('splits wards and ICUs and coerces numeric fields', () {
      final body = {
        'Root': {
          'WardsTd': [
            {
              'UNIT_ID': 3.0,
              'UNIT_NAME_AR': 'الدور الثالث',
              'UNIT_NAME_EN': 'Third Floor',
              'BED_FULL': 29.0,
              'BED_EMPTY': 0.0,
            },
            {
              'UNIT_ID': 2.0,
              'UNIT_NAME_AR': 'الدور الثانى',
              'UNIT_NAME_EN': 'Second Floor',
              'BED_FULL': 25.0,
              'BED_EMPTY': 3.0,
            },
          ],
          'IcusTd': [
            {
              'UNIT_ID': 185.0,
              'UNIT_NAME_AR': 'NICU',
              'UNIT_NAME_EN': 'NICU',
              'BED_FULL': 6.0,
              'BED_EMPTY': 0.0,
            },
          ],
        },
      };

      final res = UnitsOccupancyResponse.fromJson(body);

      expect(res.wards.length, 2);
      expect(res.icus.length, 1);
      expect(res.wards.first.unitId, '3'); // 3.0 -> "3", not "3.0"
      expect(res.wards.first.bedFull, 29); // 29.0 -> 29
      expect(res.wards[1].nameEn, 'Second Floor');
      expect(res.icus.single.nameEn, 'NICU');
    });

    test('tolerates a single ward collapsed to a bare object', () {
      final body = {
        'Root': {
          'WardsTd': {
            'UNIT_ID': 296.0,
            'UNIT_NAME_EN': 'Super Lux',
            'BED_FULL': 1.0,
            'BED_EMPTY': 1.0,
          },
        },
      };
      final res = UnitsOccupancyResponse.fromJson(body);
      expect(res.wards.single.unitId, '296');
      expect(res.wards.single.bedFull, 1);
      expect(res.wards.single.bedEmpty, 1);
      expect(res.icus, isEmpty);
    });

    test('returns empty lists when Root exists but WardsTd/IcusTd are absent', () {
      // Use <String, dynamic>{} — jsonDecode always produces Map<String, dynamic>,
      // so the typed literal is the faithful representation.
      final res = UnitsOccupancyResponse.fromJson({'Root': <String, dynamic>{}});
      expect(res.wards, isEmpty);
      expect(res.icus, isEmpty);
    });

    test('throws FormatException when Root key is missing entirely', () {
      expect(
        () => UnitsOccupancyResponse.fromJson({'error': 'unauthorized'}),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
