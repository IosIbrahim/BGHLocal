import '../../../../core/utils/converters.dart';
import '../../domain/entity/emergency_data.dart';

/// `NewDashBoard/GetEROverviewData` — summary counters, status counts and
/// payment totals in one envelope:
/// `{ "Root": { "ER_COUNT": { "ER_COUNT_ROW": { ...fields } } } }`
class EmergencyOverviewResponse {
  final int totalEr;
  final int countLocal;
  final int countForeign;
  final int countCash;
  final int countCredit;
  final int triaged;
  final int checkIn;
  final int discharged;
  final int admitted;

  EmergencyOverviewResponse({
    required this.totalEr,
    required this.countLocal,
    required this.countForeign,
    required this.countCash,
    required this.countCredit,
    required this.triaged,
    required this.checkIn,
    required this.discharged,
    required this.admitted,
  });

  factory EmergencyOverviewResponse.fromJson(Map<String, dynamic> json) {
    final row = unwrapObject(json['Root']);
    return EmergencyOverviewResponse(
      totalEr: asInt(row['TOTAL_ER']),
      countLocal: asInt(row['COUNT_LOCAL']),
      countForeign: asInt(row['COUNT_FORGEIGN']),
      countCash: asInt(row['COUNT_CASH']),
      countCredit: asInt(row['COUNT_CREDIT']),
      triaged: asInt(row['TRIAGED']),
      checkIn: asInt(row['CHECKIN']),
      discharged: asInt(row['DISCHARGED']),
      admitted: asInt(row['ADMITTED']),
    );
  }

  EmergencyOverview toOverview() => EmergencyOverview(
        totalEr: totalEr,
        saudiCount: countLocal,
        nonSaudiCount: countForeign,
        statusBreakdown: [
          EmergencyStatusEntry(label: 'Triaged', count: triaged),
          EmergencyStatusEntry(label: 'In Treatment', count: checkIn),
          EmergencyStatusEntry(label: 'Discharged', count: discharged),
          EmergencyStatusEntry(label: 'Admitted', count: admitted),
        ],
      );

  EmergencyPayments toPayments() => EmergencyPayments(
        cashPayments: countCash,
        creditPayments: countCredit,
      );
}

/// One row of `NewDashBoard/GetPatientCensusEr` — a bare JSON array of
/// nationality entries (`ID` / `NAME_AR` / `NAME_EN` / `RESULT_VALUE`).
class PatientCensusErResponse {
  final String id;
  final String nameAr;
  final String nameEn;
  final int resultValue;

  PatientCensusErResponse({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.resultValue,
  });

  factory PatientCensusErResponse.fromJson(Map<String, dynamic> json) =>
      PatientCensusErResponse(
        id: asIdStr(json['ID']),
        nameAr: asStr(json['NAME_AR']),
        nameEn: asStr(json['NAME_EN']),
        resultValue: asInt(json['RESULT_VALUE']),
      );

  EmergencyNationalityEntry toDomain() => EmergencyNationalityEntry(
        nameAr: nameAr,
        nameEn: nameEn,
        count: resultValue,
      );
}
