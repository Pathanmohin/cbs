import 'dart:convert';

class SaveVerifyData {
  static String verifyOTP = "";

// Aadhaar Id
  static String aadharNumberVerify = "";
  static String reqIDGen = "";
  static String otp = "";

//First Page

  static String fName = "";
  static String mName = "";
  static String lName = "";
  static String phone = "";
  static String idUn = "";
  static String dobb = "";

  //---------------------------Vikas Data Loan-------------------------------------//
  static String reuireAmmt = "";
  static String tenureee = "";
  static String midlname = "";
  static String emptypee = "";
  static String incomeee = "";
  static String emailiddd = "";
}

class Data {
  final String requestId;
  final bool otpSentStatus;
  final bool ifNumber;
  final bool isValidAadhaar;
  final String status;

  Data({
    required this.requestId,
    required this.otpSentStatus,
    required this.ifNumber,
    required this.isValidAadhaar,
    required this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      requestId: json['requestId'],
      otpSentStatus: json['otpSentStatus'],
      ifNumber: json['if_number'],
      isValidAadhaar: json['isValidAadhaar'],
      status: json['status'],
    );
  }
}

//---------------------------------------------------------------------------------------------------------

class TitleId {
  static String title = "";
}

class AccOpenStart {
  // First Page
  static String phoneNumber = "";
  static String email = "";
  static String pan = "";
  static String aadhaar = "";
}

class AadhaarcardVerifyuser {
// Aadhaar Card Details

  static String aadharNumber = "";
  static String reqID = "";

  static String client_id = ""; //"aadhaar_v1_Tk33p2LmWQBKKLbZumVJ",
  static String full_name = ""; //"Mohit Sahu",
  static String aadhaar_number = ""; //"953527038357"
  static String dob = ""; // "2000-05-12", 2000/05/12
  static String gender = ""; //"M",

  //Address List
  static String country = ""; //"India",
  static String dist = ""; // "Jaipur",
  static String state = ""; // "Rajasthan",
  static String po = ""; // "Jaipur City",
  static String loc = ""; // "ghatgate",
  static String vtc = ""; //"Jaipur",
  static String subdist = ""; // "",
  static String street = ""; // "",
  static String house = ""; //  "",
  static String landmark = ""; // "4744/22,dadiya house purani kotwali ka rasta"

  static bool face_status = false; //"face_status": false,
  static var face_score = 0; // -1,
  static String zip = ""; // "302003",
  static String profile_image = ""; //image

  static bool has_image = false; //"has_image": true,

  static String email_hash = "";
  static String mobile_hash = "";

  static String zip_data = "";

  static String raw_xml = "";

  static String care_of = "";

  static String share_code = "";

  static bool mobile_verified = false;

  static String reference_id = "";

  // static String aadhaar_pdf = datafirst["aadhaar_pdf"]; // "aadhaar_pdf": null,
  static String status = ""; // "status": "success_aadhaar",
  static String uniqueness_id = ""; // "uniqueness_id": ""
}

class PanDataSave {
  static String panNumber = "";
  static String fName = "";
  static bool isValid = false;
  static String status = "";
  static String date = "";
  static String firstName = "";
  static String middleName = "";
  static String lastName = "";
  static String title = "";
  static String panStatusCode = "";
  static String lastUpdatedOn = "";
  static String panStatus = "";
  static String aadhaarSeedingStatus = "";
  static String aadhaarSeedingStatusCode = "";
}

class BranchDetails {
  // Branch Details

  static String stateBranch = "";
  static String cityBranch = "";
  static String branchName = "";
  static String selectDist = "";
  static String cityPINCode = "";
  static String branchcode = "";
}

class FinelDataRes {
  static String customerid = "";
  static String accountNo = "";
}

class ProfessionalData {
  static String occupation = "";
  static String grossIncome = "";
  static String mothername = "";
  static String ocpBehav = "";
}

class NomeenieData {
  static String nomniShow = "";
  static String nomiName = "";
  static String nomiRelation = "";
  static String nomiGender = "";
  static String nomiDob = "";
}

class KYCINCode{
  static String kycCode = "";
}
