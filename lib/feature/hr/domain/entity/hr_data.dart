/// The HR staff-count KPIs, each served by its own
/// `NewDashBoard/kpi_cover_*_no_graph` endpoint. [responseKey] is the single
/// field the endpoint returns (e.g. `{ "V_DOCTOR_NO": "86" }`).
enum HrKpi {
  totalStaff('V_EMPLOYEE_NO', 'Total Staff'),
  doctors('V_DOCTOR_NO', 'Doctors'),
  nurses('V_NURSE_NO', 'Nursing'),
  admins('V_ADMIN_NO', 'Admin'),
  techs('V_TECH_NO', 'Technicians');

  final String responseKey;
  final String label;
  const HrKpi(this.responseKey, this.label);

  /// The KPIs that make up the "Staff by Category" donut (everything except
  /// the total, which is their aggregate).
  static const categories = [doctors, nurses, admins, techs];
}
