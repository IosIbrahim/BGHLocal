import 'package:dr_baksh_dashboard/feature/filter/data/model/main_data_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MainDataResponse.fromJson', () {
    test('parses branches and medical date flags from the loadMainData envelope',
        () {
      final body = {
        'Root': {
          'USER_BRANCHES': {
            'USER_BRANCHES_ROW': [
              {'ID': '1', 'NAME_AR': 'مستشفى خبير', 'NAME_EN': 'Khabeer Hospital'},
              {'ID': '3', 'NAME_AR': 'البحرين بنك', 'NAME_EN': 'Elbahrein bank'},
            ],
          },
          'DASHBOARD_MEDICAL_DATE_FLAG': {
            'DASHBOARD_MEDICAL_DATE_FLAG_ROW': [
              {'ID': '1', 'NAME_AR': 'اليوم', 'NAME_EN': 'Today'},
              {'ID': '9', 'NAME_AR': 'الفترة', 'NAME_EN': 'Period'},
            ],
          },
        },
      };

      final data = MainDataResponse.fromJson(body).data;

      expect(data.branches.length, 2);
      expect(data.branches.first.id, '1');
      expect(data.branches.first.name(isArabic: false), 'Khabeer Hospital');
      expect(data.branches.first.name(isArabic: true), 'مستشفى خبير');

      expect(data.periods.length, 2);
      expect(data.periods.last.id, '9');
      expect(data.periods.last.name(isArabic: false), 'Period');
    });

    test('strips the ".0" suffix from integral-double ids', () {
      final body = {
        'Root': {
          'USER_BRANCHES': {
            'USER_BRANCHES_ROW': {
              'ID': 2.0,
              'NAME_AR': 'فرع',
              'NAME_EN': 'Branch',
            },
          },
        },
      };

      final data = MainDataResponse.fromJson(body).data;
      // A single collapsed object becomes a one-element list.
      expect(data.branches.length, 1);
      expect(data.branches.single.id, '2');
      expect(data.periods, isEmpty);
    });

    test('tolerates a missing Root / empty body', () {
      final data = MainDataResponse.fromJson(<String, dynamic>{}).data;
      expect(data.branches, isEmpty);
      expect(data.periods, isEmpty);
    });
  });
}
