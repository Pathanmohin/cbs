class BankDetailsModel {
  String? brnBrcod;
  String? brnEaddr;
  String? brnEname;
  String? brnEbank;
  String? brnIfsc;
  String? brnType;
  String? brnBkcod;
  String? brnZoacode;
  String? brnPtype;
  String? brnHname;

  // Constructor with named parameters
  BankDetailsModel({
    this.brnBrcod,
    this.brnEaddr,
    this.brnEname,
    this.brnEbank,
    this.brnIfsc,
    this.brnType,
    this.brnBkcod,
    this.brnZoacode,
    this.brnPtype,
    this.brnHname,
  });

  // Factory constructor to create an instance from a JSON object
  factory BankDetailsModel.fromJson(Map<String, dynamic> json) {
    return BankDetailsModel(
      brnBrcod: json['brn_brcod'] as String?,
      brnEaddr: json['brn_eaddr'] as String?,
      brnEname: json['brn_ename'] as String?,
      brnEbank: json['brn_ebank'] as String?,
      brnIfsc: json['brn_ifsc'] as String?,
      brnType: json['brn_type'] as String?,
      brnBkcod: json['brn_bkcod'] as String?,
      brnZoacode: json['brn_zoacode'] as String?,
      brnPtype: json['brn_ptype'] as String?,
      brnHname: json['brn_hname'] as String?,
    );
  }

  // Convert the object to a JSON format (map)
  Map<String, dynamic> toJson() {
    return {
      'brn_brcod': brnBrcod,
      'brn_eaddr': brnEaddr,
      'brn_ename': brnEname,
      'brn_ebank': brnEbank,
      'brn_ifsc': brnIfsc,
      'brn_type': brnType,
      'brn_bkcod': brnBkcod,
      'brn_zoacode': brnZoacode,
      'brn_ptype': brnPtype,
      'brn_hname': brnHname,
    };
  }
}


class Pancard {
  final String panNumber;
  final String fullName;
  final bool isValid;
  final String firstName;
  final String middleName;
  final String lastName;
  final String title;
  final String panStatusCode;
  final String panStatus;
  final String aadhaarSeedingStatus;
  final String aadhaarSeedingStatusCode;
  final String lastUpdatedOn;

  Pancard({
    required this.panNumber,
    required this.fullName,
    required this.isValid,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.title,
    required this.panStatusCode,
    required this.panStatus,
    required this.aadhaarSeedingStatus,
    required this.aadhaarSeedingStatusCode,
    required this.lastUpdatedOn,
  });

  // Factory method to create a Pancard object from JSON
  factory Pancard.fromJson(Map<String, dynamic> json) {
    return Pancard(
      panNumber: json['panNumber'],
      fullName: json['fullName'],
      isValid: json['isValid'].toLowerCase() == 'true',
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      title: json['title'],
      panStatusCode: json['panStatusCode'],
      panStatus: json['panStatus'],
      aadhaarSeedingStatus: json['aadhaarSeedingStatus'],
      aadhaarSeedingStatusCode: json['aadhaarSeedingStatusCode'],
      lastUpdatedOn: json['lastUpdatedOn'],
    );
  }
}

class PancardResponse {
  final Pancard pancard;
  final int statusCode;

  PancardResponse({
    required this.pancard,
    required this.statusCode,
  });

  // Factory method to create a PancardResponse object from JSON
  factory PancardResponse.fromJson(Map<String, dynamic> json) {
    return PancardResponse(
      pancard: Pancard.fromJson(json['data']),
      statusCode: json['status_code'],
    );
  }
}