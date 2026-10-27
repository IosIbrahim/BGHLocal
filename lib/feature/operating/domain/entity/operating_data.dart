
class OperatingDeptEntry {
  final String name;
  final String deptCode;
  final String totalLabel;
  final int total;
  final int cash;
  final int credit;
  final int completed;
  final int pending;
  final int cancelled;

  const OperatingDeptEntry({
    required this.name,
    required this.deptCode,
    required this.totalLabel,
    required this.total,
    required this.cash,
    required this.credit,
    required this.completed,
    required this.pending,
    required this.cancelled,
  });
}
