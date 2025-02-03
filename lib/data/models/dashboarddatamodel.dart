import 'dart:convert';

import 'package:flutter/services.dart';

class AccountFetchModel {
  String? textValue;
  String? accountType;
  String? dataValue;
  String? customerName;
  String? actEname;
  String? availbalance;
  String? brancode;
  String? brnEname;
  String? headerTitle;
  String? actkid;

  List<AccountFetchModel>? childModelsList;

  AccountFetchModel({
    this.textValue,
    this.accountType,
    this.dataValue,
    this.customerName,
    this.actEname,
    this.availbalance,
    this.brancode,
    this.brnEname,
    this.headerTitle,
    this.actkid,
    this.childModelsList,
  });

  factory AccountFetchModel.fromJson(Map<String, dynamic> json) {
    return AccountFetchModel(
      textValue: json['textValue'],
      accountType: json['accountType'],
      dataValue: json['dataValue'],
      customerName: json['customerName'],
      actEname: json['actEname'],
      availbalance: json['availbalance'],
      brancode: json['brancode'],
      brnEname: json['brnEname'],
      headerTitle: json['headerTitle'],
      actkid: json['actkid'],
      childModelsList: json['childModelsList'] != null
          ? List<AccountFetchModel>.from(json['childModelsList']
              .map((item) => AccountFetchModel.fromJson(item)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'textValue': textValue,
      'accountType': accountType,
      'dataValue': dataValue,
      'customerName': customerName,
      'actEname': actEname,
      'availbalance': availbalance,
      'brancode': brancode,
      'brnEname': brnEname,
      'headerTitle': headerTitle,
      'actkid': actkid,
      'childModelsList': childModelsList != null
          ? List<dynamic>.from(childModelsList!.map((item) => item.toJson()))
          : null,
    };
  }
}


class EVENTLIST {
  String? textValue;
  String? accountType;

  EVENTLIST({
    this.textValue,
    this.accountType,
  });

  factory EVENTLIST.fromJson(Map<String, dynamic> json) {
    return EVENTLIST(
      textValue: json['title'],
      accountType: json['filedata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': textValue,
      'filedata': accountType,
    };
  }
}

class Simple {
  final String countryId;
  final String label;


  Simple({
    required this.countryId,
    required this.label,

  });
}

class AccountListData {
  static String accListData = "";
}

class ParentChildModel {
  String? accountNo;
  String? acckid;
  String? availbalance;
  String? brancode;
  String? limit;
  String? limittext;
  String? brnEname;
  String? headerTitle;
  String? tittle;
  String? txtroi;
  String? comment;
  String? customerName;
  String? loanslabName;
  String? loanin;
  String? loanslabtype;
  String? roidtfrom;
  String? loanintrestrate;
  String? loanintrestrate1;
  String? loanintrestrate2;
  String? interestRate;
  String? underClgBalance;
  String? clourcode;
  String? checkstateus;
  String? address;
  String? interesttext;
  String? image;

  ParentChildModel({
    this.accountNo,
    this.acckid,
    this.availbalance,
    this.brancode,
    this.limit,
    this.limittext,
    this.brnEname,
    this.headerTitle,
    this.tittle,
    this.txtroi,
    this.comment,
    this.customerName,
    this.loanslabName,
    this.loanin,
    this.loanslabtype,
    this.roidtfrom,
    this.loanintrestrate,
    this.loanintrestrate1,
    this.loanintrestrate2,
    this.interestRate,
    this.underClgBalance,
    this.clourcode,
    this.checkstateus,
    this.address,
    this.interesttext,
    this.image,
  });

  factory ParentChildModel.fromJson(Map<String, dynamic> json) {
    return ParentChildModel(
      accountNo: json['AccountNo'],
      acckid: json['acckid'],
      availbalance: json['availbalance'],
      brancode: json['brancode'],
      limit: json['Limit'],
      limittext: json['Limittext'],
      brnEname: json['brnEname'],
      headerTitle: json['HeaderTitle'],
      tittle: json['tittle'],
      txtroi: json['txtroi'],
      comment: json['Comment'],
      customerName: json['customerName'],
      loanslabName: json['loanslabName'],
      loanin: json['loanin'],
      loanslabtype: json['loanslabtype'],
      roidtfrom: json['roidtfrom'],
      loanintrestrate: json['loanintrestrate'],
      loanintrestrate1: json['loanintrestrate1'],
      loanintrestrate2: json['loanintrestrate2'],
      interestRate: json['InterestRate'],
      underClgBalance: json['underClgBalance'],
      clourcode: json['clourcode'],
      checkstateus: json['checkstateus'],
      address: json['address'],
      interesttext: json['interesttext'],
      image: json['Image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AccountNo': accountNo,
      'acckid': acckid,
      'availbalance': availbalance,
      'brancode': brancode,
      'Limit': limit,
      'Limittext': limittext,
      'brnEname': brnEname,
      'HeaderTitle': headerTitle,
      'tittle': tittle,
      'txtroi': txtroi,
      'Comment': comment,
      'customerName': customerName,
      'loanslabName': loanslabName,
      'loanin': loanin,
      'loanslabtype': loanslabtype,
      'roidtfrom': roidtfrom,
      'loanintrestrate': loanintrestrate,
      'loanintrestrate1': loanintrestrate1,
      'loanintrestrate2': loanintrestrate2,
      'InterestRate': interestRate,
      'underClgBalance': underClgBalance,
      'clourcode': clourcode,
      'checkstateus': checkstateus,
      'address': address,
      'interesttext': interesttext,
      'Image': image,
    };
  }
}


class BroadcastData {
  final String festivalName;
  final String endDate;
  final String lastDate;
  final String message;
  final Uint8List fileData; // Changed to Uint8List for byte data
  final String status;
  final String branchCode;
  final int userId;

  BroadcastData({
    required this.festivalName,
    required this.endDate,
    required this.lastDate,
    required this.message,
    required this.fileData,
    required this.status,
    required this.branchCode,
    required this.userId,
  });

  factory BroadcastData.fromJson(Map<String, dynamic> json) {
    return BroadcastData(
      festivalName: json['brdcst_festivalname'],
      endDate: json['brdcst_edate'],
      lastDate: json['brdcst_ldate'],
      message: json['brdcst_emessage'],
      fileData:
          base64Decode(json['brdcst_filedata']), // Decode Base64 to Uint8List
      status: json['brdcst_status'],
      branchCode: json['brdcst_brncode'],
      userId: json['brdcst_usrid'],
    );
  }
}

class BroadcastDataa {
  final String fileData; // Base64 encoded image data
  final String userId; // URL or identifier

  BroadcastDataa({required this.fileData, required this.userId});

  factory BroadcastDataa.fromJson(Map<String, dynamic> json) {
    return BroadcastDataa(
      fileData: json['filedata'] ?? '',
      userId: json['title'] ?? '',
    );
  }
}



class DashAPi {
  String? custID;
  String? userID;
  String? purpose;
  

  DashAPi({
    required this.custID,
    required this.userID,
    required this.purpose,

  });

  Map<String, dynamic> toJson() {
    return {
      'custID': custID,
      'userID': userID,
      'purpose': purpose,

    };
  }
}


class SelfFromAccountModel{
  String? custid;

  

  SelfFromAccountModel({
    required this.custid,
    
  });

  Map<String, dynamic> toJson() {
    return {
      'custid': custid,

    };
  }
}


class FromAccountRDDetails{
  String? Accno;

  

  FromAccountRDDetails({
    required this.Accno,
    
  });

  Map<String, dynamic> toJson() {
    return {
      'Accno': Accno,

    };
  }
}


class PaymentInfo {
  final String year;
  final String month;
  final String days;
  final String period;
  final String installmentAmount;

  PaymentInfo({
    required this.year,
    required this.month,
    required this.days,
    required this.period,
    required this.installmentAmount,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) {
    return PaymentInfo(
      year: json['year'],
      month: json['month'],
      days: json['days'],
      period: json['period'],
      installmentAmount: json['installmentAmmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'month': month,
      'days': days,
      'period': period,
      'installmentAmmount': installmentAmount,
    };
  }
}


class OtpAccount {
  final String beneficiaryAccNo;
  final String userID;
  final String purpose;
  final String mobile;
  final String sessionID;

  OtpAccount({
    required this.beneficiaryAccNo,
    required this.userID,
    required this.purpose,
    required this.mobile,
    required this.sessionID,
  });

  factory OtpAccount.fromJson(Map<String, dynamic> json) {
    return OtpAccount(
      beneficiaryAccNo: json['beneficiaryAccNo'],
      userID: json['userID'],
      purpose: json['purpose'],
      mobile: json['mobile'],
      sessionID: json['sessionID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'beneficiaryAccNo': beneficiaryAccNo,
      'userID': userID,
      'purpose': purpose,
      'mobile': mobile,
      'sessionID': sessionID,
    };
  }
}


class ProcessOTPSelf {
  final String beneficiaryAccNo;
  final String userID;
  final String accNo;
  final String transferAmt;
  final String OTP;
  final String Remark;
  final String sessionID;
  final String latitude; 
  final String longitude;
  final String address;


  ProcessOTPSelf({
    required this.beneficiaryAccNo,
    required this.userID,
    required this.accNo,
    required this.transferAmt,
    required this.OTP,
    required this.Remark,
    required this.sessionID,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory ProcessOTPSelf.fromJson(Map<String, dynamic> json) {
    return ProcessOTPSelf(
      beneficiaryAccNo: json['beneficiaryAccNo'],
      userID: json['userID'],
      accNo: json['accNo'],
      transferAmt: json['transferAmt'],
      OTP: json['OTP'],
      Remark: json['Remark'],
      sessionID: json['sessionID'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'beneficiaryAccNo': beneficiaryAccNo,
      'userID': userID,
      'accNo': accNo,
      'transferAmt': transferAmt,
      'OTP': OTP,
      'Remark': Remark,
      'sessionID': sessionID,
      'latitude': latitude,
      'longitude': longitude,
       'address': address
    };
  }
}

