class Ocp {
  String? ocpCode;
  String? ocpHname;
  String? ocpEname;
  String? ocpKid;
  String? ocpBehav;

  Ocp({
     this.ocpCode,
     this.ocpHname,
     this.ocpEname,
     this.ocpKid,
     this.ocpBehav,
  });

  // Factory method for creating an instance from a map (JSON)
  factory Ocp.fromJson(Map<String, dynamic> json) {
    return Ocp(
      ocpCode: json['ocp_code'],
      ocpHname: json['ocp_hname'],
      ocpEname: json['ocp_ename'],
      ocpKid: json['ocp_kid'],
      ocpBehav: json['ocp_behav'],
    );
  }

  // Method to convert an instance to a map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'ocp_code': ocpCode,
      'ocp_hname': ocpHname,
      'ocp_ename': ocpEname,
      'ocp_kid': ocpKid,
      'ocp_behav': ocpBehav,
    };
  }
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










class UserInfo {
  String? mobileno;
  String? Email;
  String? pan;
  String? aadhaar_number;


  UserInfo({
    this.mobileno,
    this.Email,
    this.pan,
    this.aadhaar_number,
  });

  Map<String, dynamic> toJson() => {
    'mobileno': mobileno,
    'Email': Email,
    'pan': pan,
    'aadhaar_number': aadhaar_number,
  };
}

class AadhaarDetail {
  String? full_name;
  String? dob;
  String? gender;
  String? care_of;
  String? zip;


  AadhaarDetail({
    this.full_name,
    this.dob,
    this.gender,
    this.care_of,
    this.zip,
  });

  Map<String, dynamic> toJson() => {
    'full_name': full_name,
    'dob': dob,
    'gender': gender,
    'care_of': care_of,
    'zip': zip,

  };
}


class AddressDetails {
  String? country;
  String? dist;
  String? state;
  String? po;
  String? loc;
  String? vtc;
  String? subdist;
  String? house;
  String? landmark;


  AddressDetails({
    this.country,
    this.dist,
    this.state,
    this.po,
    this.loc,
    this.vtc,
    this.subdist,
    this.house,
    this.landmark,
  });

  Map<String, dynamic> toJson() => {
    'country': country,
    'dist': dist,
    'state': state,
    'po':po,
    'loc': loc,
    'vtc': vtc,
    'subdist': subdist,
    'house': house,
    'landmark': landmark,

  };
}


class OccupationInfo {
  String? occupation;
  String? incom;
  String? MotherName;
  String? ocpbehave;


  OccupationInfo({
    this.occupation,
    this.incom,
    this.MotherName,
    this.ocpbehave,
  });

  Map<String, dynamic> toJson() => {
    'occupation': occupation,
    'incom': incom,
    'MotherName': MotherName,
    'ocpbehave': ocpbehave,
  };
}


class BranchInfo {
  String? district;
  String? branch;
  String? state;
  String? pincode;


  BranchInfo({
    this.district,
    this.branch,
    this.state,
    this.pincode,
  });

  Map<String, dynamic> toJson() => {
    'district': district,
    'branch': branch,
    'state': state,
    'pincode': pincode,
  };
}


class NomiInfo {
  String? NominiFlag;
  String? NominiName;
  String? NominiRelation;
  String? Nominigender;
    String? NominiDob;


  NomiInfo({
    this.NominiFlag,
    this.NominiName,
    this.NominiRelation,
    this.Nominigender,
    this.NominiDob,
  });

  Map<String, dynamic> toJson() => {
    'NominiFlag': NominiFlag,
    'NominiName': NominiName,
    'NominiRelation': NominiRelation,
    'Nominigender': Nominigender,
    'NominiDob': NominiDob,
  };
}




class AllDetails {
  
  String? actType;
  String? userselect;
  Map<String, dynamic> CCDetails;
  String? profile_image;
  Map<String, dynamic> userinfo;
  Map<String, dynamic> AadharDetails;
  Map<String, dynamic> address;  
  Map<String, dynamic> Occup;
  Map<String, dynamic> Branch;
  Map<String, dynamic> Nomini;


  AllDetails({
      
    required this.actType,
    required this.userselect,
    required this.CCDetails,
    required this.profile_image,
    required this.userinfo,
    required this.AadharDetails,
    required this.address,
    required this.Occup,
    required this.Branch,
    required this.Nomini,
  });

  Map<String, dynamic> toJson() => {

    'actType': actType,
    'userselect':userselect,
     'CCDetails': CCDetails,
    'profile_image': profile_image,
    'userinfo': userinfo,
    'AadharDetails': AadharDetails,
    'address': address,
    'Occup': Occup,
    'Branch': Branch,
    'Nomini': Nomini,
  };
}