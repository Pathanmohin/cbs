// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<StatefulWidget> createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController conPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double getButtonFontSize(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      if (screenWidth > 600) {
        return 14.0; // Large screen
      } else if (screenWidth > 400) {
        return 15.0; // Medium screen
      } else {
        return 16.0; // Default size
      }
    }

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Change Password",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Dashboard()),
                  );

                  // context.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              backgroundColor: const Color(0xFF0057C2),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                        child: Text(
                          "Old Password",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: TextFormField(
                            controller: oldPass,
                            decoration: const InputDecoration(
                              hintText: "Enter Old Password",
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                        child: Text(
                          "New Password",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: TextFormField(
                            controller: newPass,
                            decoration: const InputDecoration(
                              hintText: "Enter New Password",
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                        child: Text(
                          "Confirm New Password",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: TextFormField(
                            controller: conPass,
                            decoration: const InputDecoration(
                              hintText: "Enter Confirm New Password",
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          bool val = await Utils.netWorkCheck(context);

                          if (val == false) {
                            return;
                          }

                          await ChangePasswordNow();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 8.0, right: 8.0, bottom: 8.0),
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0057C2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "SUBMIT",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: getButtonFontSize(context),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Image.asset("assets/images/next.png"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      );
    });
  }

  // ignore: non_constant_identifier_names
  Future<void> ChangePasswordNow() async {
    RegExp hasNumber = RegExp(r'[0-9]+');
    RegExp hasUpperChar = RegExp(r'[A-Z]+');
    RegExp hasMiniMaxChars = RegExp(r'.{8,15}');
    RegExp hasLowerChar = RegExp(r'[a-z]+');

    if (oldPass.text.isEmpty) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Old Password",
          );
        },
      );
      return;
    } else if (newPass.text.isEmpty) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter New Password",
          );
        },
      );

      return;
    } else if (!hasMiniMaxChars.hasMatch(newPass.text)) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description:
                "New Password must be at least 8 characters and at most 15 characters",
          );
        },
      );
      return;
    } else if (!hasLowerChar.hasMatch(newPass.text)) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description:
                "New Password must contain at least 1 lowercase letter",
          );
        },
      );

      return;
    } else if (!hasUpperChar.hasMatch(newPass.text)) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description:
                "New Password must contain at least 1 uppercase letter",
          );
        },
      );

      return;
    } else if (!hasNumber.hasMatch(newPass.text)) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "New Password must contain at least 1 number",
          );
        },
      );

      return;
    } else if (conPass.text.isEmpty) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Confirm Password",
          );
        },
      );

      return;
    } else if (newPass.text != conPass.text) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Confirm Password does not match New Password",
          );
        },
      );

      return;
    } else if (oldPass.text == newPass.text) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "New Password should not be the same as Old Password",
          );
        },
      );

      return;
    } else {
      changePasswordAPI();
    }
  }

  Future<void> changePasswordAPI() async {
    try {
      // Password Ency.
      String oldPassWords = Crypt().generateMd5(oldPass.text);
      String newPassWords = Crypt().generateMd5(newPass.text);

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      // API endpoint URL

      String apiUrl = ApiConfig.changepassword;

      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');
      String mobileNo = context.read<SessionProvider>().get('mobileNo');

      Map<String, dynamic> data = {
        "encPassword": newPassWords,
        "OldPassword": oldPassWords,
        "userID": userid,
        "purpose": "Fund Transfer",
        "mobile": mobileNo,
        "sessionID": "mobileapp",
      };

      String jsonString = jsonEncode(data);

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "tokenNo": tokenNo,
        "userID": userid,
      };

      // Convert data to JSON

      String encrypted = AESencryption.encryptString(jsonString, ibUsrKid);

      final parameters = <String, dynamic>{
        "data": encrypted,
      };

      // Make POST request
      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      try {
        if (response.statusCode == 200) {
          if (response.body != "") {
            var data = jsonDecode(response.body);

            if (kDebugMode) {
              print(response.body);
            }

            if (data["Result"].toString().toLowerCase() == "success") {
              Loader.hide();

              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Congratulations!!!!!!!!",
                    description: "Password has been changed successfully..!",
                  );
                },
              );

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Dashboard()));

              // context.pop(context);
            } else if (data["Result"].toString().toLowerCase() == "failure") {
              Loader.hide();

              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: data["Result"].toString(),
                  );
                },
              );
              return;
            } else if (data["Result"] == "Incorrect old password") {
              Loader.hide();
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: data["Result"].toString(),
                  );
                },
              );
              return;
            } else {
              Loader.hide();
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: data["Result"].toString(),
                  );
                },
              );
              return;
            }
          } else {
            Loader.hide();
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertBox(
                  title: "Alert",
                  description: "Server is not responding..!",
                );
              },
            );
            return;
          }
        } else {
          Loader.hide();
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: "Alert",
                description: "Server is not responding..!",
              );
            },
          );
          return;
        }
      } catch (e) {
        Loader.hide();

        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertBox(
              title: "Alert",
              description: "Unable To connect Server",
            );
          },
        );
        return;
      }
    } catch (e) {
      Loader.hide();

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Unable To connect Server",
          );
        },
      );
      return;
    }
  }
}
