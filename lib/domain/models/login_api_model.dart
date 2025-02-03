class LoginApiModel {
  String userID;
  String encPassword;
  String SIMNO;
  String Type;
  String MobVer;
  String latitude;
  String longitude;
  String address;

  LoginApiModel({
    required this.userID,
    required this.encPassword,
    required this.SIMNO,
    required this.Type,
    required this.MobVer,
    required this.longitude,
    required this.latitude,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'encPassword': encPassword,
      'SIMNO': SIMNO,
      'Type': Type,
      'MobVer': MobVer,
      'latitude': latitude,
      'longitude': longitude,
      'address': address
    };
  }
}
