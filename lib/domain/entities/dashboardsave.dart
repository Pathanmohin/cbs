

// ignore_for_file: non_constant_identifier_names

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/models/loginmodel.dart';
import 'package:hpscb/data/models/rechargemodel.dart';

class AppInfoLogin {
  static String lastLogin = "";
  static String cusName = "";
  static String accountNo = "";
  static String BranchCode = "";
  static String authorise = "";
  static String userType = "";
  static String validUser = "";
  static String customerId = "";
  static String sessionId = "";
  static String mobileNo = "";
  static String custRoll = "";
  static String branchName = "";
  static String sibusrFor = "";
  static String ifsc = "";
  static String tokenNo = "";
  static String ibUsrKid = "";
  static String brnemail = "";
  static String custemail = "";
  static String errorMsg = "";
  static String Otp = "";
  static String responseCode = "";
  static String Userid = "";
  static String secondusermob = "";
  static String branchIFSC = "";
}

class AppListData {
  static List<AccountFetchModel> FromAccounts = <AccountFetchModel>[];
  static List<AccountFetchModel> ToAccounts = <AccountFetchModel>[];
  static List<AccountFetchModel> AllAccounts = <AccountFetchModel>[];
  static List<AccountFetchModel> Allacc = <AccountFetchModel>[];

  static List<AccountFetchModel> Accloan = <AccountFetchModel>[];
  static List<AccountFetchModel> Sav = <AccountFetchModel>[];

  static List<AccountFetchModel> fd = <AccountFetchModel>[];
  static List<AccountFetchModel> rd = <AccountFetchModel>[];
  static List<AccountFetchModel> SavCA = <AccountFetchModel>[];
  static List<AccountFetchModel> SACACC = <AccountFetchModel>[];
  static List<AccountFetchModel> FDR = <AccountFetchModel>[];
  static List<AccountFetchModel> fdclose = <AccountFetchModel>[];
  static List<AccountFetchModel> Fundtransfertransfer = <AccountFetchModel>[];
  static List<AccountFetchModel> fromAccountList = <AccountFetchModel>[];
  static List<AccountFetchModel> fromAccount = <AccountFetchModel>[];
  static List<AccountFetchModel> listevnert = <AccountFetchModel>[];
}

class MyAccountList {
  static List<ParentChildModel> childModelsSavingListData =
      <ParentChildModel>[];
  static List<ParentChildModel> childModelsCurrentList = <ParentChildModel>[];
  static List<ParentChildModel> childModelsCCODList = <ParentChildModel>[];
  static List<ParentChildModel> childModelsFDList = <ParentChildModel>[];
  static List<ParentChildModel> childModelsRDList = <ParentChildModel>[];
  static List<ParentChildModel> childModelsLoanList = <ParentChildModel>[];
}

class LISTEVENT {
  static List<EVENTLIST> childModel = <EVENTLIST>[];
}

class BenAdd {
  static List<Payee> BenAddList = <Payee>[];
}

class Realtionship {
  static List<Relationship> relationShip = <Relationship>[];
}

class Statename {
  static List<Statee> relationShipp = <Statee>[];
}


class BannerShowList{

static bool dashboardEvent = false;

static List<EVENTLIST> bannerList = <EVENTLIST>[];

static List<EVENTLIST> beforeList = [];

}

class Relationship {
  String? relmas_ename;

  Relationship({
    required this.relmas_ename,
  });

  factory Relationship.fromJson(Map<String, dynamic> json) {
    return Relationship(
      relmas_ename: json['relmas_ename'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'relmas_ename': relmas_ename,
    };
  }
}