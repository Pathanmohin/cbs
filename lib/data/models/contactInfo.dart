class ContactInfo {
  final String email;
  final String mobile;
  final String address;
  final String phone;

  ContactInfo({
    required this.email,
    required this.mobile,
    required this.address,
    required this.phone,
  });

  // Factory constructor to create ContactInfo from JSON
  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      email: json['c_email'],
      mobile: json['c_mob'],
      address: json['c_addr'],
      phone: json['c_phone'],
    );
  }

  // Method to convert ContactInfo to JSON
  Map<String, dynamic> toJson() {
    return {
      'c_email': email,
      'c_mob': mobile,
      'c_addr': address,
      'c_phone': phone,
    };
  }
}
