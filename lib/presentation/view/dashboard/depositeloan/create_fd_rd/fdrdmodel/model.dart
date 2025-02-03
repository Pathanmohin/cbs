class FDOpening {
  String? mStateID;
  String? mStateName;
  String? branchname;
  String? mStateCode;
  String? ifsCode;
  String? payeeType;
  String? Kid;
  String? Name;
  String? Code;
  String? timeperoid;
  String? Defactkidfd;
  String? NomineeRelationship;
  String? DefActKidd;
  String? DefActKid;

  FDOpening(
      {
      this.mStateID,
      this.mStateName,
      this.branchname,
      this.mStateCode,
      this.ifsCode,
      this.payeeType,
      this.Kid,
      this.Name,
      this.Code,
      this.timeperoid,
      this.Defactkidfd,
      this.NomineeRelationship,
      this.DefActKidd,
      this.DefActKid});

  FDOpening.fromJson(Map<String, dynamic> json) {
    mStateID = json['mStateID'];
    mStateName = json['mStateName'];
    branchname = json['branchname'];
    mStateCode = json['mStateCode'];
    ifsCode = json['ifsCode'];
    payeeType = json['payeeType'];
    Kid = json['Kid'];
    Name = json['Name'];
    Code = json['Code'];
    timeperoid = json['timeperoid'];
    Defactkidfd = json['Defactkidfd'];
    NomineeRelationship = json['NomineeRelationship'];
    DefActKidd = json['DefActKidd'];
    DefActKid = json['DefActKid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mStateID'] = this.mStateID;
    data['mStateName'] = this.mStateName;
    data['branchname'] = this.branchname;
    data['mStateCode'] = this.mStateCode;
    data['ifsCode'] = this.ifsCode;
    data['payeeType'] = this.payeeType;
    data['Kid'] = this.Kid;
    data['Name'] = this.Name;
    data['Code'] = this.Code;
    data['timeperoid'] = this.timeperoid;
    data['Defactkidfd'] = this.Defactkidfd;
    data['NomineeRelationship'] = this.NomineeRelationship;
    data['DefActKidd'] = this.DefActKidd;
    data['DefActKid'] = this.DefActKid;
    return data;
  }
}


class NomineeListName{
  String? relmas_code;
  String? relmas_ename;
  int? relmas_kid;

  NomineeListName(
      {
      this.relmas_code,
      this.relmas_ename,
      this.relmas_kid,
      });

  NomineeListName.fromJson(Map<String, dynamic> json) {
    relmas_code = json['relmas_code'];
    relmas_ename = json['relmas_ename'];
    relmas_kid = json['relmas_kid'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['relmas_code'] = this.relmas_code;
    data['relmas_ename'] = this.relmas_ename;
    data['relmas_kid'] = this.relmas_kid;

    return data;
  }
}


class FDSGLCODE {

  String? sglcode;
  String? actname;

  FDSGLCODE({this.sglcode, this.actname});

  // Factory constructor to create an instance from a map
  factory FDSGLCODE.fromJson(Map<String, dynamic> json) {
    return FDSGLCODE(
      sglcode: json['SGLCODE'] as String,
      actname: json['Actname'] as String,
    );
  }

  // Convert the object to a JSON format
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SGLCODE'] = this.sglcode;
    data['Actname'] = this.actname;
    return data;
  }
}


class NomineeDetails {
  String? nomineeName;
  String? nomineeRelationship;
  String? nomineeAge;
  String? nomineeDob;
  String? nomineeMinor;
  String? nomineeAddress1;
  String? nomineeAddress2;
  String? nomineeCity;
  String? pincode;
  String? id;

  NomineeDetails({
    this.nomineeName,
    this.nomineeRelationship,
    this.nomineeAge,
    this.nomineeDob,
    this.nomineeMinor,
    this.nomineeAddress1,
    this.nomineeAddress2,
    this.nomineeCity,
    this.pincode,
    this.id,
  });

  // Factory constructor to create an instance from a JSON object
  factory NomineeDetails.fromJson(Map<String, dynamic> json) {
    return NomineeDetails(
      nomineeName: json['NomineeName'],
      nomineeRelationship: json['NomineeRelationship'],
      nomineeAge: json['NomineeAge'],
      nomineeDob: json['NomineeDob'],
      nomineeMinor: json['NomineeMinor'],
      nomineeAddress1: json['NomineeAddress1'],
      nomineeAddress2: json['NomineeAddress2'],
      nomineeCity: json['NomineeCity'],
      pincode: json['Pincode'],
      id: json['Id'],
    );
  }

  // Convert the object to a JSON format (map)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NomineeName'] = this.nomineeName;
    data['NomineeRelationship'] = this.nomineeRelationship;
    data['NomineeAge'] = this.nomineeAge;
    data['NomineeDob'] = this.nomineeDob;
    data['NomineeMinor'] = this.nomineeMinor;
    data['NomineeAddress1'] = this.nomineeAddress1;
    data['NomineeAddress2'] = this.nomineeAddress2;
    data['NomineeCity'] = this.nomineeCity;
    data['Pincode'] = this.pincode;
    data['Id'] = this.id;
    return data;
  }
}

class StateObjectList {
  String? mStateID;
  String? mStateName;
  String? mStateCode;
  String? ifsCode;
  String? payeeType;
  String? payeeName;
  String? accType;
  String? kid;
  String? branchname;
  String? pincode;
  String? city_kid;
  String? cityName; // Updated to camelCase convention
  String? cityKid; // Updated to camelCase convention
  String? eCityName;

  StateObjectList({
    this.mStateID,
    this.mStateName,
    this.mStateCode,
    this.ifsCode,
    this.payeeType,
    this.payeeName,
    this.accType,
    this.kid,
    this.branchname,
    this.pincode,
    this.city_kid,
    this.cityName,
    this.cityKid,
    this.eCityName
  });

  factory StateObjectList.fromJson(Map<String, dynamic> json) {
    return StateObjectList(
      mStateID: json['mStateID'],
      mStateName: json['mStateName'],
      mStateCode: json['mStateCode'],
      ifsCode: json['ifsCode'],
      payeeType: json['payeeType'],
      payeeName: json['payeeName'],
      accType: json['accType'],
      kid: json['kid'],
      branchname: json['branchname'],
      pincode: json['pincode'],
      city_kid: json['city_kid'],
      cityName: json['CityName'], // Updated to camelCase convention
      cityKid: json['Citykid'], // Updated to camelCase convention
      eCityName: json['eCityName']

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'mStateID': mStateID,
      'mStateName': mStateName,
      'mStateCode': mStateCode,
      'ifsCode': ifsCode,
      'payeeType': payeeType,
      'payeeName': payeeName,
      'accType': accType,
      'kid': kid,
      'branchname': branchname,
      'pincode': pincode,
      'city_kid': city_kid,
      'CityName': cityName, // Updated to camelCase convention
      'Citykid': cityKid, // Updated to camelCase convention
      'eCityName': eCityName
    };
    return data;
  }
}


class UserInput2 {
  String? sEName;
  String? sERelation;
  String? sSex;
  String? sMinor;
  String? sEDesc;
  String? sGuardian;
  String? sORelation;
  String? sOName;
  String? sODescription;
  String? sFlag;

  UserInput2({
    this.sEName,
    this.sERelation,
    this.sSex,
    this.sMinor,
    this.sEDesc,
    this.sGuardian,
    this.sORelation,
    this.sOName,
    this.sODescription,
    this.sFlag,
  });

  Map<String, dynamic> toJson() => {
    'sEName': sEName,
    'sERelation': sERelation,
    'sSex': sSex,
    'sMinor': sMinor,
    'sEDesc': sEDesc,
    'sGuardian': sGuardian,
    'sORelation': sORelation,
    'sOName': sOName,
    'sODescription': sODescription,
    'sFlag': sFlag,
  };
}

class UserInput3 {
  String? guardianname;
  String? guardianRel;
  String? dob;
  String? guardianperaddressline1;
  String? guardianperaddressline2;
  String? guardianstatename;
  String? guardianstatecode;
  String? guardiancityname;
  String? guardiancitycode;
  String? guardianpincode;

  UserInput3({
    this.guardianname,
    this.guardianRel,
    this.dob,
    this.guardianperaddressline1,
    this.guardianperaddressline2,
    this.guardianstatename,
    this.guardianstatecode,
    this.guardiancityname,
    this.guardiancitycode,
    this.guardianpincode,
  });

  Map<String, dynamic> toJson() => {
    'guardianname': guardianname,
    'guardianRel': guardianRel,
    'dob': dob,
    'guardianperaddressline1': guardianperaddressline1,
    'guardianperaddressline2': guardianperaddressline2,
    'guardianstatename': guardianstatename,
    'guardianstatecode': guardianstatecode,
    'guardiancityname': guardiancityname,
    'guardiancitycode': guardiancitycode,
    'guardianpincode': guardianpincode,
  };
}

class UserInput1 {
  String customerId;
  String FdScheme;
  String fdCode;
  String month;
  String year;
  String day;
  String instPayable;
  String intrestRate;
  String Maturityamount;
  String Maturitydate;
  String sglcode;
  String accno;
  String amount;
  String Remark;
  String fdKid;
  String maturityInst;
  String brnCode;
  Map<String, dynamic> NominieeDetail;
  Map<String, dynamic> gardianDetails;

  UserInput1({
    required this.customerId,
    required this.FdScheme,
    required this.fdCode,
    required this.month,
    required this.year,
    required this.day,
    required this.instPayable,
    required this.intrestRate,
    required this.Maturityamount,
    required this.Maturitydate,
    required this.sglcode,
    required this.accno,
    required this.amount,
    required this.Remark,
    required this.fdKid,
    required this.maturityInst,
    required this.brnCode,
    required this.NominieeDetail,
    required this.gardianDetails,
  });

  Map<String, dynamic> toJson() => {
    'customerId': customerId,
    'FdScheme': FdScheme,
    'fdCode': fdCode,
    'month': month,
    'year': year,
    'day': day,
    'instPayable': instPayable,
    'intrestRate': intrestRate,
    'Maturityamount': Maturityamount,
    'Maturitydate': Maturitydate,
    'sglcode': sglcode,
    'accno': accno,
    'amount': amount,
    'Remark': Remark,
    'fdKid': fdKid,
    'maturityInst': maturityInst,
    'brnCode': brnCode,
    'NominieeDetail': NominieeDetail,
    'gardianDetails': gardianDetails,
  };
}


class InterestRate {
  String? fdprdLdaysss;
  String? fdprdUdaysss;
  String? fdintRoiii;

  InterestRate({
    this.fdprdLdaysss,
    this.fdprdUdaysss,
    this.fdintRoiii,
  });

  Map<String, dynamic> toJson() => {
    'fdprdLdaysss': fdprdLdaysss,
    'fdprdUdaysss': fdprdUdaysss,
    'fdintRoiii': fdintRoiii,
  };
}


class FatchfdrDetails {
  String? fdikid;
  String? fdistrsrno;
  String? fdinumber;
  String? fdidate;
  String? fdiamount;
  String? fdimdate;
  String? fdiint;
  String? status1;

  FatchfdrDetails({
    this.fdikid,
    this.fdistrsrno,
    this.fdinumber,
    this.fdidate,
    this.fdiamount,
    this.fdimdate,
    this.fdiint,
    this.status1,
  });

  // Factory constructor to create an instance from JSON
  factory FatchfdrDetails.fromJson(Map<String, dynamic> json) {
    return FatchfdrDetails(
      fdikid: json['fdikid'],
      fdistrsrno: json['fdistrsrno'],
      fdinumber: json['fdinumber'],
      fdidate: json['fdidate'],
      fdiamount: json['fdiamount'],
      fdimdate: json['fdimdate'],
      fdiint: json['fdiint'],
      status1: json['status1'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'fdikid': fdikid,
      'fdistrsrno': fdistrsrno,
      'fdinumber': fdinumber,
      'fdidate': fdidate,
      'fdiamount': fdiamount,
      'fdimdate': fdimdate,
      'fdiint': fdiint,
      'status1': status1,
    };
  }
}


class FatchOdDetails {
  String? maxamt;
  String? exdate;

  FatchOdDetails({
     this.maxamt,
     this.exdate,
  });

  // Factory constructor to create an instance from JSON
  factory FatchOdDetails.fromJson(Map<String, dynamic> json) {
    return FatchOdDetails(
      maxamt: json['Maxamt'],
      exdate: json['Exdate'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'Maxamt': maxamt,
      'Exdate': exdate,
    };
  }
}

class Nomineedetails {
  String? nomineeName;
  String? nomineeRelationship;
  String? nomineeAge;
  String? nomineeDob;
  String? nomineeMinor;
  String? nomineeAddress1;
  String? nomineeAddess2;
  String? nomieeCity;
  String? pincode;
  String? id;

  Nomineedetails({
    this.nomineeName,
    this.nomineeRelationship,
    this.nomineeAge,
    this.nomineeDob,
    this.nomineeMinor,
    this.nomineeAddress1,
    this.nomineeAddess2,
    this.nomieeCity,
    this.pincode,
    this.id,
  });

  // Factory constructor to create an instance from JSON
  factory Nomineedetails.fromJson(Map<String, dynamic> json) {
    return Nomineedetails(
      nomineeName: json['NomineeName'],
      nomineeRelationship: json['NomineeRelationship'],
      nomineeAge: json['NomineeAge'],
      nomineeDob: json['NomineeDob'],
      nomineeMinor: json['NomineeMinor'],
      nomineeAddress1: json['NomineeAddress1'],
      nomineeAddess2: json['NomineeAddess2'],
      nomieeCity: json['NomieeCity'],
      pincode: json['Pincode'],
      id: json['id'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'NomineeName': nomineeName,
      'NomineeRelationship': nomineeRelationship,
      'NomineeAge': nomineeAge,
      'NomineeDob': nomineeDob,
      'NomineeMinor': nomineeMinor,
      'NomineeAddress1': nomineeAddress1,
      'NomineeAddess2': nomineeAddess2,
      'NomieeCity': nomieeCity,
      'Pincode': pincode,
      'id': id,
    };
  }
}

class NomineedetailsRD {
  String? nomineeNamee;
  String? nomineeRelationshipp;
  String? nomineeAgee;
  String? nomineeDobb;
  String? nomineeMinorr;
  String? nomineeAddress11;
  String? nomineeAddess22;
  String? nomieeCityy;
  String? pincodee;
  String? idd;

  NomineedetailsRD({
    this.nomineeNamee,
    this.nomineeRelationshipp,
    this.nomineeAgee,
    this.nomineeDobb,
    this.nomineeMinorr,
    this.nomineeAddress11,
    this.nomineeAddess22,
    this.nomieeCityy,
    this.pincodee,
    this.idd,
  });

  // Factory constructor to create an instance from JSON
  factory NomineedetailsRD.fromJson(Map<String, dynamic> json) {
    return NomineedetailsRD(
      nomineeNamee: json['NomineeNamee'],
      nomineeRelationshipp: json['NomineeRelationshipp'],
      nomineeAgee: json['NomineeAgee'],
      nomineeDobb: json['NomineeDobb'],
      nomineeMinorr: json['NomineeMinorr'],
      nomineeAddress11: json['NomineeAddress11'],
      nomineeAddess22: json['NomineeAddess22'],
      nomieeCityy: json['NomieeCityy'],
      pincodee: json['Pincodee'],
      idd: json['idd'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'NomineeNamee': nomineeNamee,
      'NomineeRelationshipp': nomineeRelationshipp,
      'NomineeAgee': nomineeAgee,
      'NomineeDobb': nomineeDobb,
      'NomineeMinorr': nomineeMinorr,
      'NomineeAddress11': nomineeAddress11,
      'NomineeAddess22': nomineeAddess22,
      'NomieeCityy': nomieeCityy,
      'Pincodee': pincodee,
      'idd': idd,
    };
  }
}



class UserInputRDNom {
  dynamic sEName;
  dynamic sERelation;
  dynamic sSex;
  dynamic sMinor;
  dynamic sEDesc;
  dynamic sGuardian;
  dynamic sORelation;
  dynamic sOName;
  dynamic sODescription;
  dynamic sFlag;

  UserInputRDNom({
    this.sEName,
    this.sERelation,
    this.sSex,
    this.sMinor,
    this.sEDesc,
    this.sGuardian,
    this.sORelation,
    this.sOName,
    this.sODescription,
    this.sFlag,
  });

  factory UserInputRDNom.fromJson(Map<String, dynamic> json) {
    return UserInputRDNom(
      sEName: json['sEName'],
      sERelation: json['sERelation'],
      sSex: json['sSex'],
      sMinor: json['sMinor'],
      sEDesc: json['sEDesc'],
      sGuardian: json['sGuardian'],
      sORelation: json['sORelation'],
      sOName: json['sOName'],
      sODescription: json['sODescription'],
      sFlag: json['sFlag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sEName': sEName,
      'sERelation': sERelation,
      'sSex': sSex,
      'sMinor': sMinor,
      'sEDesc': sEDesc,
      'sGuardian': sGuardian,
      'sORelation': sORelation,
      'sOName': sOName,
      'sODescription': sODescription,
      'sFlag': sFlag,
    };
  }
}

class UserInput5 {

  String? guardianname;
  String? guardianRel;
  String? dob;
  String? guardianperaddressline1;
  String? guardianperaddressline2;
  String? guardianstate;
  String? guardiancity;
  String? guardianpincode;
  String? guardiancityname;
  String? guardianstatecode;
  String? guardiancitycode;
  String? guardianstatename;

  UserInput5({
    this.guardianname,
    this.guardianRel,
    this.dob,
    this.guardianperaddressline1,
    this.guardianperaddressline2,
    this.guardianstate,
    this.guardiancity,
    this.guardianpincode,
    this.guardiancityname,
    this.guardianstatecode,
    this.guardiancitycode,
    this.guardianstatename,
  });

  factory UserInput5.fromJson(Map<String, dynamic> json) {
    return UserInput5(
      guardianname: json['guardianname'],
      guardianRel: json['guardianRel'],
      dob: json['dob'],
      guardianperaddressline1: json['guardianperaddressline1'],
      guardianperaddressline2: json['guardianperaddressline2'],
      guardianstate: json['guardianstate'],
      guardiancity: json['guardiancity'],
      guardianpincode: json['guardianpincode'],
      guardiancityname: json['guardiancityname'],
      guardianstatecode: json['guardianstatecode'],
      guardiancitycode: json['guardiancitycode'],
      guardianstatename: json['guardianstatename'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'guardianname': guardianname,
      'guardianRel': guardianRel,
      'dob': dob,
      'guardianperaddressline1': guardianperaddressline1,
      'guardianperaddressline2': guardianperaddressline2,
      'guardianstate': guardianstate,
      'guardiancity': guardiancity,
      'guardianpincode': guardianpincode,
      'guardiancityname': guardiancityname,
      'guardianstatecode': guardianstatecode,
      'guardiancitycode': guardiancitycode,
      'guardianstatename': guardianstatename,
    };
  }
}

class UserInputRD {
  String? customerId;
  dynamic customerid;
  String? RDScheme;
  String? fdCode;
  String? RDCode;
  String? day;
  String? installmentDay;
  String? intrestRate;
  String? timeperiod;
  String? Maturityamount;
  String? Maturitydate;
  String? sglcode;
  String? Accno;
  String? accno;
  String? amaount;
  String? Remark;
  String? RDKid;
  String? Month;
  String? month;
  String? Year;
  String? year;
  dynamic NominieeDetail;
  dynamic gardianDetails;
  dynamic maturityInst;
  dynamic brnCode;
  String? amount;

  UserInputRD({
    this.customerId,
    this.customerid,
    this.RDScheme,
    this.fdCode,
    this.RDCode,
    this.day,
    this.installmentDay,
    this.intrestRate,
    this.timeperiod,
    this.Maturityamount,
    this.Maturitydate,
    this.sglcode,
    this.Accno,
    this.accno,
    this.amaount,
    this.Remark,
    this.RDKid,
    this.Month,
    this.month,
    this.Year,
    this.year,
    this.NominieeDetail,
    this.gardianDetails,
    this.maturityInst,
    this.brnCode,
    this.amount,
  });

  factory UserInputRD.fromJson(Map<String, dynamic> json) {
    return UserInputRD(
      customerId: json['customerId'],
      customerid: json['customerid'],
      RDScheme: json['RDScheme'],
      fdCode: json['fdCode'],
      RDCode: json['RDCode'],
      day: json['day'],
      installmentDay: json['installmentDay'],
      intrestRate: json['intrestRate'],
      timeperiod: json['timeperiod'],
      Maturityamount: json['Maturityamount'],
      Maturitydate: json['Maturitydate'],
      sglcode: json['sglcode'],
      Accno: json['Accno'],
      accno: json['accno'],
      amaount: json['amaount'],
      Remark: json['Remark'],
      RDKid: json['RDKid'],
      Month: json['Month'],
      month: json['month'],
      Year: json['Year'],
      year: json['year'],
      NominieeDetail: json['NominieeDetail'],
      gardianDetails: json['gardianDetails'],
      maturityInst: json['maturityInst'],
      brnCode: json['brnCode'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'customerid': customerid,
      'RDScheme': RDScheme,
      'fdCode': fdCode,
      'RDCode': RDCode,
      'day': day,
      'installmentDay': installmentDay,
      'intrestRate': intrestRate,
      'timeperiod': timeperiod,
      'Maturityamount': Maturityamount,
      'Maturitydate': Maturitydate,
      'sglcode': sglcode,
      'Accno': Accno,
      'accno': accno,
      'amaount': amaount,
      'Remark': Remark,
      'RDKid': RDKid,
      'Month': Month,
      'month': month,
      'Year': Year,
      'year': year,
      'NominieeDetail': NominieeDetail,
      'gardianDetails': gardianDetails,
      'maturityInst': maturityInst,
      'brnCode': brnCode,
      'amount': amount,
    };
  }
}

