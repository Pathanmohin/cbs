class UserInput {
  String userID;
  String encPassword;
  String simNO;
  String type;
  String mobVer;
  String latitude;
  String longitude;
   String address;

  UserInput({
    required this.userID,
    required this.encPassword,
    required this.simNO,
    required this.type,
    required this.mobVer,
    required this.longitude,
    required this.latitude,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'encPassword': encPassword,
      'SIMNO': simNO,
      'Type': Type,
      'MobVer': mobVer,
      'latitude' : latitude,
      'longitude': longitude,
      'address':address
    };
  }
}
