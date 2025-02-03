// ignore_for_file: non_constant_identifier_names, unused_element, no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hpscb/config/config.dart';
import 'package:hpscb/config/constants.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/presentation/view/auth/login_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

final _formkey = GlobalKey<FormState>();
final _form = GlobalKey<FormState>();

class Activate extends StatefulWidget {
  const Activate({super.key});

  @override
  State<StatefulWidget> createState() => _activate();
}

class _activate extends State<Activate> {
  @override
  void initState() {
    super.initState();
    // Provider.of<SessionTimeoutService>(context, listen: false).startSession();
  }

  Color text = Color(0xFF002E5B);
  Color textColor = Color(0xFF0057C2);
  Color Background = Color(0xFFFAF9F9);
  String? userIdValue;
  String? accountNoValue;
  final USERID = TextEditingController();
  final ACCOUNTNO = TextEditingController();

  final OTP = TextEditingController();

  final NEWPASSWORD = TextEditingController();

  final CONFIRMPASSWORD = TextEditingController();

  final ATMCARD = TextEditingController();
  String Message = "";

  @override
  Widget build(BuildContext context) {
    bool _isUpperCase = false;
    bool _isLowerCase = false;
    bool _isNumeric = false;
    bool _hasSpecialChars = false;
    var size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Activate Device",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginView()),
                );
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
            ),
            backgroundColor: const Color(0xFF0057C2),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      child: const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "USER ID",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: true,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 8.0, bottom: 10),
                        child: Container(
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: TextFormField(
                            controller: USERID,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Enter USER ID",
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: true,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "ACCOUNT NO.",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: true,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 8.0, bottom: 10),
                        child: Container(
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: TextFormField(
                            controller: ACCOUNTNO,
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: " Enter ACCOUNT NO.",
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final List<ConnectivityResult> connectivityResult =
                            await (Connectivity().checkConnectivity());
                        if (connectivityResult
                            .contains(ConnectivityResult.none)) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Alert',
                                  style: TextStyle(fontSize: 16),
                                ),
                                content: const Text(
                                  'Please Check Your Internet Connection',
                                  style: TextStyle(fontSize: 16),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );

                          return;
                        }
                        SendOTP(context, USERID.text, ACCOUNTNO.text);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0057C2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "GENERATE OTP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: true,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "ENTER OTP",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: true,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 8.0, bottom: 10),
                        child: Container(
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: TextFormField(
                            controller: OTP,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6)
                            ],
                            decoration: InputDecoration(
                              hintText: "Enter OTP",
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "NEW PASSWORD",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8.0, bottom: 10),
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          controller: NEWPASSWORD,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Enter NEW PASSWORD",
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "CONFIRM PASSWORD",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8.0, bottom: 10),
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          controller: CONFIRMPASSWORD,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Enter CONFIRM PASSWORD",
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "ATM CARD/Aadhar CARD",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8.0, bottom: 10),
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          controller: ATMCARD,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20)
                          ],
                          decoration: InputDecoration(
                            hintText: "ATM CARD/Aadhar CARD",
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final List<ConnectivityResult> connectivityResult =
                            await (Connectivity().checkConnectivity());
                        if (connectivityResult
                            .contains(ConnectivityResult.none)) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Builder(builder: (context) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(
                                      textScaler: const TextScaler.linear(1.0)),
                                  child: AlertDialog(
                                    title: const Text(
                                      'Alert',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    content: const Text(
                                      'Please Check Your Internet Connection',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                            },
                          );

                          return;
                        }
                        if (USERID.text == null || USERID.text == "") {
                          Message = "Please Enter User ID..!";
                          Dialgbox(Message);
                          return;
                        } else if (ACCOUNTNO.text == null ||
                            ACCOUNTNO.text == "") {
                          Message = "Please Enter Account Number..!";
                          Dialgbox(Message);
                          return;
                        } else if (NEWPASSWORD.text == null ||
                            NEWPASSWORD.text == "") {
                          Message = "Please Enter New Password..!";
                          Dialgbox(Message);
                          return;
                        }
                        _isUpperCase =
                            RegExp(r'[A-Z]').hasMatch(NEWPASSWORD.text);
                        _isLowerCase =
                            RegExp(r'[a-z]').hasMatch(NEWPASSWORD.text);
                        _isNumeric =
                            RegExp(r'[0-9]').hasMatch(NEWPASSWORD.text);
                        _hasSpecialChars = RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                            .hasMatch(NEWPASSWORD.text);
                        if (!_isUpperCase) {
                          Message =
                              "New Password should contain At least one upper case letter";
                          Dialgbox(Message);
                          return;
                          //  return 'Password must contain at least one uppercase letter';
                        } else if (!_isLowerCase) {
                          Message =
                              "New Password should contain At least one lower case letter..!";
                          Dialgbox(Message);
                          return;
                          //  return 'Password must contain at least one lowercase letter';
                        } else if (!_isNumeric) {
                          Message =
                              "New Password should contain At least one numeric value";
                          Dialgbox(Message);
                          return;
                          // return 'Password must contain at least one number';
                        } else if (!_hasSpecialChars) {
                          Message = "Add Special Character";
                          Dialgbox(Message);
                          return;
                          // return 'Password must contain at least one special character';
                        } else if (CONFIRMPASSWORD.text == null ||
                            CONFIRMPASSWORD.text == "") {
                          Message = "Please Confirm Enter Password..!";
                          Dialgbox(Message);
                          return;
                        } else if (CONFIRMPASSWORD.text !=
                            NEWPASSWORD.text.toString()) {
                          Message = "Password is Mis matched..!";
                          Dialgbox(Message);
                          return;
                        } else if (USERID == null || USERID == "") {
                          Message = "Please Enter User ID..!";
                          Dialgbox(Message);
                          return;
                        } else if (ACCOUNTNO.text == null ||
                            ACCOUNTNO.text == "") {
                          Message = "Please Enter Account Number..!";
                          Dialgbox(Message);
                          return;
                        } else if (ATMCARD.text == null || ATMCARD.text == "") {
                          Message = "Please Enter ATM Card No.";
                          Dialgbox(Message);
                          return;
                        } else if (OTP.text == null || OTP.text == "") {
                          Message = "Please Enter OTP";
                          Dialgbox(Message);
                          return;
                        }

                        ActivateUser(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0057C2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "PROCEED",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  void Dialgbox(String MESSAGE) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Builder(builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.1)),
            child: AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                'Alert',
                style: TextStyle(fontSize: 16),
              ),
              content: Text(
                MESSAGE,
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  Future<void> SendOTP(
      BuildContext context, String customerID, String accountnumber) async {
    if (USERID.text == null || USERID.text == "") {
      Message = "Please Enter User ID..!";
      Dialgbox(Message);
      return;
    } else if (ACCOUNTNO.text == null || ACCOUNTNO.text == "") {
      Message = "Please Enter Account Number..!";
      Dialgbox(Message);
      return;
    }

    userIdValue = customerID;
    accountNoValue = accountnumber;

// Password Ency.
    // String md5Hash = Crypt().generateMd5(password);
    Loader.show(context, progressIndicator: CircularProgressIndicator());

    // API endpoint URL

    String apiUrl = ApiConfig.passCon;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    String jsonString = jsonEncode({
      "userID": USERID.text,
      "beneficiaryAccNo": ACCOUNTNO.text,
      "purpose": "Account Activation",
      "simNo": androidInfo.id.toString(),
      "sessionID": "mobileapp"
    });

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
    };

    // Convert data to JSON

    String encrypted =
        AESencryption.encryptString(jsonString, Constants.AESENCRYPTIONKEY);

    String d = "data=" + encrypted;

    final parameters = <String, dynamic>{
      "data": encrypted,
    };

    try {
      // Make POST request
      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      // Check if request was successful
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData["Result"].toString() == "Success") {
          var a = responseData["Data"];

          var data = AESencryption.decryptString(
            a,
            Constants.AESENCRYPTIONKEY,
          );

          Map<String, dynamic> dataa = jsonDecode(data);

          String authorise = dataa['authorise'];
          String userType = dataa['userType'];
          String validUser = dataa['validUser'];
          String customerId = dataa['customerId'];
          String sessionId = dataa['sessionId'];
          String custName = dataa['custName'];
          String lastLogin = dataa['lastlogin'];
          String mobileNo = dataa['mobileNo'];
          Loader.hide();
          if (authorise == "success") {
            Message = "OTP has been send to your Registered Mobile.";
            OTP.text = "";
            NEWPASSWORD.text = "";
            CONFIRMPASSWORD.text = "";
            ATMCARD.text = "";
            Dialgbox(Message);
            return;
          } else {
            Message = "Unable to Send OTP";
            Dialgbox(Message);
            return;
          }
        } else {
          Loader.hide();
          Message = responseData["Message"].toString();
          Dialgbox(Message);
          return;
        }
      } else {
        Loader.hide();
        Message = response.statusCode.toString();
        Dialgbox(Message);
        return;
      }
    } catch (error) {
      Loader.hide();
      Message = error.toString();
      Dialgbox(Message);
      return;
    }
  }

  Future<void> ActivateUser(BuildContext context) async {
    // String ip = ServerDetails().getIPaddress();
    // String port = ServerDetails().getPort();
    // String protocol = ServerDetails().getProtocol();
    // String? deviceId = await PlatformDeviceId.getDeviceId;

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

// Password Ency.
    String md5Hash = Crypt().generateMd5(NEWPASSWORD.text);

    Loader.show(context, progressIndicator: CircularProgressIndicator());

    // API endpoint URL

    //String apiUrl = "$protocol$ip$port/rest/AccountService/passWordChangeUrl";

    String apiUrl = ApiConfig.passwordchange;

    String jsonString = jsonEncode({
      "userID": USERID.text,
      "beneficiaryAccNo": ACCOUNTNO.text,
      "purpose": "Account Activation",
      "SIMNO": androidInfo.id.toString(),
      "OTP": OTP.text,
      "sessionID": "mobileapp",
      "ATMno": ATMCARD.text,
      "encPassword": md5Hash
    });

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
    };

    // Convert data to JSON

    String encrypted =
        AESencryption.encryptString(jsonString, Constants.AESENCRYPTIONKEY);

    String d = "data=" + encrypted;

    final parameters = <String, dynamic>{
      "data": jsonString,
    };

    try {
      // Make POST request
      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonString,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      // Check if request was successful
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        var a = jsonDecode(responseData["Data"].toString());
        var b = responseData["Result"].toString();

        if (b == "Success") {
          if (a["result"] == "success") {
            Loader.hide();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: const Text(
                    'Success',
                    style: TextStyle(fontSize: 16),
                  ),
                  content: Text(
                    'Password Change Successfully..!!',
                    style: TextStyle(fontSize: 16),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => LoginView())));
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (a['result'] == "-2") {
            Loader.hide();
            Message = "OTP Mismatch...!";
            Dialgbox(Message);
            return;
          } else if (a['result'] == "-3") {
            Loader.hide();
            Message = "OTP has been expired..!";
            Dialgbox(Message);
            return;
          } else {
            Loader.hide();
            Message = "This Account have not ATM Card No.";
            Dialgbox(Message);
            return;
          }
        } else {
          Loader.hide();
          Map<String, dynamic> responseData = jsonDecode(response.body);
          var a = jsonDecode(responseData["Data"].toString());
          var error = a['Error'].toString();
          Message = error.toString();
          Dialgbox(Message);
          return;
        }
      }
    } catch (error) {
      Loader.hide();
      Message = "Server Error";
      Dialgbox(Message);
      return;
    }
  }

  void resetFormFields() {
    USERID.text = userIdValue ?? '';
    ACCOUNTNO.text = accountNoValue ?? '';
  }
}
