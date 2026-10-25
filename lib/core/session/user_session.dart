/// Clean domain session model — lives in core, has no feature dependencies.
/// Represents the logged-in user across the entire app.
class UserSession {
  final String empId;
  final String empNameEn;
  final String empNameAr;
  final String defaultGroup;
  final String defaultBranch;
  final String hospNameEn;
  final String hospNameAr;
  final bool isCashier;
  final bool isUnlimited;
  final String inboxCount;
  final String oracleDate;

  const UserSession({
    required this.empId,
    required this.empNameEn,
    required this.empNameAr,
    required this.defaultGroup,
    required this.defaultBranch,
    required this.hospNameEn,
    required this.hospNameAr,
    required this.isCashier,
    required this.isUnlimited,
    required this.inboxCount,
    required this.oracleDate,
  });

  factory UserSession.fromJson(Map<String, dynamic> json) => UserSession(
        empId: json['empId'] ?? '',
        empNameEn: json['empNameEn'] ?? '',
        empNameAr: json['empNameAr'] ?? '',
        defaultGroup: json['defaultGroup'] ?? '',
        defaultBranch: json['defaultBranch'] ?? '',
        hospNameEn: json['hospNameEn'] ?? '',
        hospNameAr: json['hospNameAr'] ?? '',
        isCashier: json['isCashier'] ?? false,
        isUnlimited: json['isUnlimited'] ?? false,
        inboxCount: json['inboxCount'] ?? '0',
        oracleDate: json['oracleDate'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'empId': empId,
        'empNameEn': empNameEn,
        'empNameAr': empNameAr,
        'defaultGroup': defaultGroup,
        'defaultBranch': defaultBranch,
        'hospNameEn': hospNameEn,
        'hospNameAr': hospNameAr,
        'isCashier': isCashier,
        'isUnlimited': isUnlimited,
        'inboxCount': inboxCount,
        'oracleDate': oracleDate,
      };
}
