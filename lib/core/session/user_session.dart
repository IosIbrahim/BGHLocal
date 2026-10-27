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
  final String userId;

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
    this.userId = '',
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
        userId: json['userId'] ?? '',
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
        'userId': userId,
      };

  UserSession copyWith({
    String? empId,
    String? empNameEn,
    String? empNameAr,
    String? defaultGroup,
    String? defaultBranch,
    String? hospNameEn,
    String? hospNameAr,
    bool? isCashier,
    bool? isUnlimited,
    String? inboxCount,
    String? oracleDate,
    String? userId,
    String? hospId,
  }) =>
      UserSession(
        empId: empId ?? this.empId,
        empNameEn: empNameEn ?? this.empNameEn,
        empNameAr: empNameAr ?? this.empNameAr,
        defaultGroup: defaultGroup ?? this.defaultGroup,
        defaultBranch: defaultBranch ?? this.defaultBranch,
        hospNameEn: hospNameEn ?? this.hospNameEn,
        hospNameAr: hospNameAr ?? this.hospNameAr,
        isCashier: isCashier ?? this.isCashier,
        isUnlimited: isUnlimited ?? this.isUnlimited,
        inboxCount: inboxCount ?? this.inboxCount,
        oracleDate: oracleDate ?? this.oracleDate,
        userId: userId ?? this.userId,
      );
}
