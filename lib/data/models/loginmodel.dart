import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final String? authorise;
  final String? userType;
  final String? validUser;
  final String? customerId;
  final String? sessionId;
  final String? custName;
  final String? lastlogin;
  final String? mobileNo;
  final String? accountNo;
  final String? custRoll;
  final String? ifsc;
  final String? branchCode;
  final String? branchName;
  final String? sibusrFor;
  final String? tokenNo;
  final String? ibUsrKid;
  final String? brnemail;
  final String? custemail;
  final String? errorMsg;
  final String? otp;
  final String? responseCode;
  final String? userid;
  final String? secondusermob;
  final String? branchIFSC;

  // Constructor with required parameters
  const Login({
    this.authorise,
    this.userType,
    this.validUser,
    this.customerId,
    this.sessionId,
    this.custName,
    this.lastlogin,
    this.mobileNo,
    this.accountNo,
    this.custRoll,
    this.ifsc,
    this.branchCode,
    this.branchName,
    this.sibusrFor,
    this.tokenNo,
    this.ibUsrKid,
    this.brnemail,
    this.custemail,
    this.errorMsg,
    this.otp,
    this.responseCode,
    this.userid,
    this.secondusermob,
    this.branchIFSC,
  });

  // Factory constructor for deserialization from JSON
  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      authorise: json['authorise'] as String?,
      userType: json['userType'] as String?,
      validUser: json['validUser'] as String?,
      customerId: json['customerId'] as String?,
      sessionId: json['sessionId'] as String?,
      custName: json['custName'] as String?,
      lastlogin: json['lastlogin'] as String?,
      mobileNo: json['mobileNo'] as String?,
      accountNo: json['accountNo'] as String?,
      custRoll: json['custRoll'] as String?,
      ifsc: json['ifsc'] as String?,
      branchCode: json['BranchCode'] as String?,
      branchName: json['branchName'] as String?,
      sibusrFor: json['sibusrFor'] as String?,
      tokenNo: json['tokenNo'] as String?,
      ibUsrKid: json['ibUsrKid'] as String?,
      brnemail: json['brnemail'] as String?,
      custemail: json['custemail'] as String?,
      errorMsg: json['errorMsg'] as String?,
      otp: json['Otp'] as String?,
      responseCode: json['responseCode'] as String?,
      userid: json['Userid'] as String?,
      secondusermob: json['secondusermob'] as String?,
      branchIFSC: json['branchIFSC'] as String?,
    );
  }

  // Method for serialization to JSON
  Map<String, dynamic> toJson() {
    return {
      'authorise': authorise,
      'userType': userType,
      'validUser': validUser,
      'customerId': customerId,
      'sessionId': sessionId,
      'custName': custName,
      'lastlogin': lastlogin,
      'mobileNo': mobileNo,
      'accountNo': accountNo,
      'custRoll': custRoll,
      'ifsc': ifsc,
      'BranchCode': branchCode,
      'branchName': branchName,
      'sibusrFor': sibusrFor,
      'tokenNo': tokenNo,
      'ibUsrKid': ibUsrKid,
      'brnemail': brnemail,
      'custemail': custemail,
      'errorMsg': errorMsg,
      'Otp': otp,
      'responseCode': responseCode,
      'Userid': userid,
      'secondusermob': secondusermob,
      'branchIFSC': branchIFSC,
    };
  }

  // Override props for value comparison
  @override
  List<Object?> get props => [
        authorise,
        userType,
        validUser,
        customerId,
        sessionId,
        custName,
        lastlogin,
        mobileNo,
        accountNo,
        custRoll,
        ifsc,
        branchCode,
        branchName,
        sibusrFor,
        tokenNo,
        ibUsrKid,
        brnemail,
        custemail,
        errorMsg,
        otp,
        responseCode,
        userid,
        secondusermob,
        branchIFSC,
      ];
}


class Payee {
  String? nickName;
  String? mobileNo;
  String? accNo;
  String? ifsCode;
  String? payeeType;
  String? payeeName;
  String? accType;
  String? kid;

  Payee({
    this.nickName,
    this.mobileNo,
    this.accNo,
    this.ifsCode,
    this.payeeType,
    this.payeeName,
    this.accType,
    this.kid,
  });

  factory Payee.fromJson(Map<String, dynamic> json) {
    return Payee(
      nickName: json['nickName'],
      mobileNo: json['mobileNo'],
      accNo: json['accNo'],
      ifsCode: json['ifsCode'],
      payeeType: json['payeeType'],
      payeeName: json['payeeName'],
      accType: json['accType'],
      kid: json['kid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nickName': nickName,
      'mobileNo': mobileNo,
      'accNo': accNo,
      'ifsCode': ifsCode,
      'payeeType': payeeType,
      'payeeName': payeeName,
      'accType': accType,
      'kid': kid,
    };
  }
}
