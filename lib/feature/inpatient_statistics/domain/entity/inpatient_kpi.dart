/// The KPIs shown in the Key Metrics row, each tied to its backend KPI code.
///
/// Centralizes the code↔tile mapping: the bloc keys each tile's [CardState] by
/// the enum value and fetches it via [code], and the widget selects its slice
/// by the same enum value — so the two stay in sync without hardcoded codes.
enum InpatientKpi {
  /// Average Length Of Stay.
  alos('221'),

  /// Bed Turnover.
  bedTurnover('830');

  const InpatientKpi(this.code);

  /// Backend `KPI_CODE` requested for this metric.
  final String code;
}
