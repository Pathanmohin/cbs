import 'package:flutter/material.dart';

class SessionProvider with ChangeNotifier {
  // A map to store session fields
  final Map<String, String> _sessionData = {
    'lastLogin': '',
    'cusName': '',
    'accountNo': '',
    'branchCode': '',
    'authorise': '',
    'userType': '',
    'validUser': '',
    'customerId': '',
    'sessionId': '',
    'mobileNo': '',
    'custRoll': '',
    'branchName': '',
    'sibusrFor': '',
    'ifsc': '',
    'tokenNo': '',
    'ibUsrKid': '',
    'brnemail': '',
    'custemail': '',
    'errorMsg': '',
    'otp': '',
    'responseCode': '',
    'userid': '',
    'secondusermob': '',
    'branchIFSC': '',
  };

  // Getters to retrieve session data
  String get(String key) {
    return _sessionData[key] ?? '';
  }

  // Method to update a session field
  void updateField(String field, String value) {
    if (_sessionData.containsKey(field)) {
      _sessionData[field] = value;  // Update value in the map
      notifyListeners();  // Notify listeners about the change
    } else {
      print("Field '$field' not found!");
    }
  }

  // Method to clear all session data
  void clearSession() {
    _sessionData.forEach((key, value) {
      _sessionData[key] = '';  // Clear all session data
    });
    notifyListeners();  // Notify listeners about the change
  }
}
