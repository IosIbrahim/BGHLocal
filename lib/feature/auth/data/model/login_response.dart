import '../../../../core/core.dart';

class ModelLoginResponseRemote {
  String? empId;
  String? empArName;
  String? empEnName;
  String? exportReportsAuthority;
  String? disableReportsPrinting;
  String? unlimitedUser;
  String? resetPwAfterLogin;
  String? empInVacation;
  String? complexPassword;
  String? restrictedLink;
  String? defaultBranch;
  String? defaultLanguage;
  String? defaultGroup;
  String? defaultPage;
  String? cashier;
  String? hospArName;
  String? hospEnName;
  String? officerIntegration;
  String? officerHospitalCode;
  String? mainScreenView;
  String? empEmailAddress;
  String? customUsername;
  String? name;
  String? multiBranch;
  String? masterBranch;
  String? scanningFilingMethod;
  String? inboxCount;
  String? scanningStoragePath;
  String? modifyPatBloodGroup;
  String? scanTechId;
  String? hasBranchesOrGroups;
  String? doctorJobType;
  String? oracleDate;
  String? dispenceOnClosedOperation;
  String? dispenceDrugsOnClosedOper;
  String? levelNo;
  String? fontFamily;
  String? fontSize;
  String? empVacationReturnStatus;
  bool? success;
  String? token;
  String? code;
  String? nameAr;
  String? nameEn;

  ModelLoginResponseRemote({
    this.empId,
    this.empArName,
    this.empEnName,
    this.exportReportsAuthority,
    this.disableReportsPrinting,
    this.unlimitedUser,
    this.resetPwAfterLogin,
    this.empInVacation,
    this.complexPassword,
    this.restrictedLink,
    this.defaultBranch,
    this.defaultLanguage,
    this.defaultGroup,
    this.defaultPage,
    this.cashier,
    this.hospArName,
    this.hospEnName,
    this.officerIntegration,
    this.officerHospitalCode,
    this.mainScreenView,
    this.empEmailAddress,
    this.customUsername,
    this.name,
    this.multiBranch,
    this.masterBranch,
    this.scanningFilingMethod,
    this.inboxCount,
    this.scanningStoragePath,
    this.modifyPatBloodGroup,
    this.scanTechId,
    this.hasBranchesOrGroups,
    this.doctorJobType,
    this.oracleDate,
    this.dispenceOnClosedOperation,
    this.dispenceDrugsOnClosedOper,
    this.levelNo,
    this.fontFamily,
    this.fontSize,
    this.empVacationReturnStatus,
    this.success,
    this.token,
    this.code,
    this.nameAr,
    this.nameEn,
  });

  factory ModelLoginResponseRemote.fromJson(Map<String, dynamic> json) {
    return ModelLoginResponseRemote(
      empId: json['EMPID']?.toString(),
      empArName: json['EMP_AR_NAME']?.toString(),
      empEnName: json['EMP_EN_NAME']?.toString(),
      exportReportsAuthority: json['EXPORT_REPORTS_AUTHORITY']?.toString(),
      disableReportsPrinting: json['DISABLE_REPORTS_PRINTING']?.toString(),
      unlimitedUser: json['UNLIMETEDUSER']?.toString(),
      resetPwAfterLogin: json['RESET_PW_AFTER_LOGIN']?.toString(),
      empInVacation: json['EMP_IN_VACATION']?.toString(),
      complexPassword: json['COMPLEX_PASSWORD']?.toString(),
      restrictedLink: json['RESTRICTED_LINK']?.toString(),
      defaultBranch: json['DEFAULTBRANCH']?.toString(),
      defaultLanguage: json['DEFAULTLANGUAGE']?.toString(),
      defaultGroup: json['DEFAULTGROUP']?.toString(),
      defaultPage: json['DEFAULTPAGE']?.toString(),
      cashier: json['CASHIER']?.toString(),
      hospArName: json['HOSP_AR_NAME']?.toString(),
      hospEnName: json['HOSP_EN_NAME']?.toString(),
      officerIntegration: json['OFFICER_INTEGRATION']?.toString(),
      officerHospitalCode: json['OFFICER_HOSPITAL_CODE']?.toString(),
      mainScreenView: json['MAIN_SCREEN_VIEW']?.toString(),
      empEmailAddress: json['EMP_EMAIL_ADDRESS']?.toString(),
      customUsername: json['CUSTOM_USERNAME']?.toString(),
      name: json['NAME']?.toString(),
      multiBranch: json['MULTIBRANCH']?.toString(),
      masterBranch: json['MASTER_BRANCH']?.toString(),
      scanningFilingMethod: json['SCANNING_FILING_METHOD']?.toString(),
      inboxCount: json['INBOX_COUNT']?.toString(),
      scanningStoragePath: json['SCANNING_STORAGE_PATH']?.toString(),
      modifyPatBloodGroup: json['MODIFY_PAT_BLOOD_GROUP']?.toString(),
      scanTechId: json['SCAN_TECH_ID']?.toString(),
      hasBranchesOrGroups: json['HAS_BRANCHES_OR_GROUPS']?.toString(),
      doctorJobType: json['DOCTOR_JOB_TYPE']?.toString(),
      oracleDate: json['ORACLEDATE']?.toString(),
      dispenceOnClosedOperation: json['DISPENCE_ON_CLOSED_OPERATION']?.toString(),
      dispenceDrugsOnClosedOper: json['DISPENCE_DRUGS_ON_CLOSED_OPER']?.toString(),
      levelNo: json['LEVEL_NO']?.toString(),
      fontFamily: json['FONT_FAMILY']?.toString(),
      fontSize: json['FONT_SIZE']?.toString(),
      empVacationReturnStatus: json['EMP_VACATION_RETURN_STATUS']?.toString(),
      success: json['Success'] as bool?,
      token: json['token']?.toString(),
      code: json['CODE']?.toString(),
      nameAr: json['NAME_AR']?.toString(),
      nameEn: json['NAME_EN']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'EMPID': empId,
      'EMP_AR_NAME': empArName,
      'EMP_EN_NAME': empEnName,
      'EXPORT_REPORTS_AUTHORITY': exportReportsAuthority,
      'DISABLE_REPORTS_PRINTING': disableReportsPrinting,
      'UNLIMETEDUSER': unlimitedUser,
      'RESET_PW_AFTER_LOGIN': resetPwAfterLogin,
      'EMP_IN_VACATION': empInVacation,
      'COMPLEX_PASSWORD': complexPassword,
      'RESTRICTED_LINK': restrictedLink,
      'DEFAULTBRANCH': defaultBranch,
      'DEFAULTLANGUAGE': defaultLanguage,
      'DEFAULTGROUP': defaultGroup,
      'DEFAULTPAGE': defaultPage,
      'CASHIER': cashier,
      'HOSP_AR_NAME': hospArName,
      'HOSP_EN_NAME': hospEnName,
      'OFFICER_INTEGRATION': officerIntegration,
      'OFFICER_HOSPITAL_CODE': officerHospitalCode,
      'MAIN_SCREEN_VIEW': mainScreenView,
      'EMP_EMAIL_ADDRESS': empEmailAddress,
      'CUSTOM_USERNAME': customUsername,
      'NAME': name,
      'MULTIBRANCH': multiBranch,
      'MASTER_BRANCH': masterBranch,
      'SCANNING_FILING_METHOD': scanningFilingMethod,
      'INBOX_COUNT': inboxCount,
      'SCANNING_STORAGE_PATH': scanningStoragePath,
      'MODIFY_PAT_BLOOD_GROUP': modifyPatBloodGroup,
      'SCAN_TECH_ID': scanTechId,
      'HAS_BRANCHES_OR_GROUPS': hasBranchesOrGroups,
      'DOCTOR_JOB_TYPE': doctorJobType,
      'ORACLEDATE': oracleDate,
      'DISPENCE_ON_CLOSED_OPERATION': dispenceOnClosedOperation,
      'DISPENCE_DRUGS_ON_CLOSED_OPER': dispenceDrugsOnClosedOper,
      'LEVEL_NO': levelNo,
      'FONT_FAMILY': fontFamily,
      'FONT_SIZE': fontSize,
      'EMP_VACATION_RETURN_STATUS': empVacationReturnStatus,
      'Success': success,
      'token': token,
      'CODE': code,
      'NAME_AR': nameAr,
      'NAME_EN': nameEn,
    };
  }

  UserSession toDomain() {
    return UserSession(
      empId: empId ?? '',
      userId: customUsername ?? '',
      empNameEn: empEnName ?? nameEn ?? '',
      empNameAr: empArName ?? nameAr ?? '',
      defaultGroup: defaultGroup ?? '',
      defaultBranch: defaultBranch ?? '',
      hospNameEn: hospEnName ?? '',
      hospNameAr: hospArName ?? '',
      isCashier: cashier == '1',
      isUnlimited: unlimitedUser == '1',
      inboxCount: inboxCount ?? '0',
      oracleDate: oracleDate ?? '',
    );
  }
}
