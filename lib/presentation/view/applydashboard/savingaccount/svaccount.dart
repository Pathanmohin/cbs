// ignore_for_file: unused_element, use_build_context_synchronously, unnecessary_null_comparison

import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/presentation/view/applydashboard/savingaccount/saveverifydata.dart';
import 'package:hpscb/presentation/view/applydashboard/savingaccount/svaadhaarotp.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class SVOpenAccount extends StatefulWidget {
  const SVOpenAccount({super.key});

  @override
  State<SVOpenAccount> createState() => _SVOpenAccountState();
}

class _SVOpenAccountState extends State<SVOpenAccount> {

  bool? value = false;
  final FocusNode mobileFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode panFocusNode = FocusNode();
  final FocusNode aadhaarFocusNode = FocusNode();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController panController = TextEditingController();
  final TextEditingController aadhaarController = TextEditingController();

  @override
  void dispose() {
    // Dispose focus nodes to avoid memory leaks
    mobileFocusNode.dispose();
    emailFocusNode.dispose();
    panFocusNode.dispose();
    aadhaarFocusNode.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    } else if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePAN(String? value) {
    final RegExp panRegExp = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
    if (value == null || value.isEmpty) {
      return 'Please enter your PAN number';
    } else if (!panRegExp.hasMatch(value)) {
      return 'Please enter a valid PAN number (e.g., AAAAA0000A)';
    }
    return null;
  }

  String? _validateAadhaar(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Aadhaar number';
    } else if (value.length != 12) {
      return 'Aadhaar number must be 12 digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Close the keyboard when back button is pressed
        FocusScope.of(context).unfocus();
        return false; // Prevent the default back button behavior
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Saving Account",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          backgroundColor: const Color(0xFF0057C2),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                // Shimmer effect on the image
                SizedBox(
                  height: 220,
                  child: Stack(
                    children: [
                      // Placeholder for shimmer effect
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      // Actual image
                      Image.asset(
                        'assets/image/savingbanner.png',
                        fit: BoxFit.fill,
                        height: 220,
                        width: double.infinity, // Ensure it takes full width
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(child: Icon(Icons.error)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // Container for form inputs
                Container(
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
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Aadhaar linked mobile",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF0057C2),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, right: 5.0, left: 5.0),
                        child: TextFormField(
                          focusNode: mobileFocusNode,
                          controller: phoneController,
                          autofocus: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone),
                            labelText: 'Enter Aadhaar linked Mobile Number',
                            hintText: '922xxxxxxx',
                          ),
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(emailFocusNode);
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 5.0),
                        child: Text(
                          "Email address",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF0057C2),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          focusNode: emailFocusNode,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.mail),
                            labelText: 'Enter Email Address',
                            hintText: 'example@gmail.com',
                          ),
                          
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(panFocusNode);
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Permanent account number (PAN)",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF0057C2),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, right: 5.0, left: 5.0),
                        child: TextFormField(
                          focusNode: panFocusNode,
                          textCapitalization: TextCapitalization.characters,
                          maxLength: 10,
                          controller: panController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.credit_card),
                            labelText: 'Enter PAN Card Number',
                            hintText: 'AAAAA0000A',
                          ),
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(aadhaarFocusNode);
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 10),
                        child: Text(
                          "Aadhaar number",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF0057C2),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          focusNode: aadhaarFocusNode,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          controller: aadhaarController,
                          maxLength: 12,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.perm_identity),
                            labelText: 'Enter Aadhaar Card Number',
                            hintText: '0000 0000 0000',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                              value: value,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  value = newValue;
                                });
                              },
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  text:
                                      'I authorise HPSCB Bank and its representatives to contact me through phone, email, SMS, and WhatsApp. I also agree to HPSCB Bank’s ',
                                  style: const TextStyle(
                                      fontSize: 14.0, color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Terms & Conditions',
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          await getTermPDF();
                                        },
                                    ),
                                    const TextSpan(
                                      text: '.',
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
                        child: InkWell(
                          onTap: () async {
                            bool val = await Utils.netWorkCheck(context);
                            if (val == false) {
                              return;
                            }
                            getAadhaarOTPVerify();
                          },
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0057C2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Get OTP To Verify Aadhaar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ------------------- alert

  Future<void> showCustomizeFlushbar(BuildContext context, String msg) {
    return Flushbar(
      messageText: Builder(builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.1)),
          child: Text(
            '$msg',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
              color: Color(0xFFFEFEFE),
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }),
      boxShadows: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 3,
        )
      ],
      duration: const Duration(seconds: 2),
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 26.0),
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(8.0),
      backgroundColor: const Color(0xFFB8585B),
      flushbarPosition: FlushbarPosition.TOP,
      forwardAnimationCurve: Curves.bounceIn,
    ).show(context);
  }

  // For OTP send

  Future<void> showCustomizeFlushbarComp(BuildContext context, String msg) {
    return Flushbar(
      messageText: Builder(builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.1)),
          child: Text(
            msg,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
              color: Color(0xFFFEFEFE),
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }),
      boxShadows: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 3,
        )
      ],
      duration: const Duration(seconds: 0),
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 26.0),
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(8.0),
      backgroundColor: Colors.green,
      flushbarPosition: FlushbarPosition.TOP,
      forwardAnimationCurve: Curves.bounceIn,
    ).show(context);
  }

// API for aadhaar number

  Future<void> getAadhaarOTPVerify() async {
    final RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    final RegExp panRegExp = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');

    if (phoneController.text == null || phoneController.text.isEmpty) {
      await showCustomizeFlushbar(context, 'Please enter your phone number');

      return;
    } else if (phoneController.text.length != 10) {
      await showCustomizeFlushbar(context, 'Phone number must be 10 digits');
      return;
    } else if (emailController.text == null || emailController.text.isEmpty) {
      await showCustomizeFlushbar(context, 'Please enter your email address');
      return;
    } else if (!emailRegExp.hasMatch(emailController.text)) {
      await showCustomizeFlushbar(
          context, 'Please enter a valid email address');
      return;
    } else if (panController.text == null || panController.text.isEmpty) {
      await showCustomizeFlushbar(context, 'Please enter your PAN number');
      return;
    } else if (!panRegExp.hasMatch(panController.text)) {
      await showCustomizeFlushbar(
          context, 'Please enter a valid PAN number (e.g., AAAAA0000A)');
      return;
    } else if (aadhaarController.text == null ||
        aadhaarController.text.isEmpty) {
      await showCustomizeFlushbar(context, 'Please enter your Aadhaar number');
      return;
    } else if (aadhaarController.text.length != 12) {
      await showCustomizeFlushbar(context, 'Aadhaar number must be 12 digits');
      return;
    } else if (value == false) {
      await showCustomizeFlushbar(context, 'Please Select Terms & Conditions');
      return;
    }

    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
      // String? deviceId = await PlatformDeviceId.getDeviceId;

        DateTime now = DateTime.now();
  
  // Define the date format
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      //String apiUrl = "rest/AccountService/aadharotpsend";

      String apiUrl = ApiConfig.aadharotpsend; 

      String jsonString = jsonEncode({
        "aadhaarnumber": aadhaarController.text,
        "aadhaarMob": phoneController.text,
        "Email": emailController.text,
        "Pan": panController.text,
        "Date" : formattedDate.toString(),
      });

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonString,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      try {
        if (response.statusCode == 200) {
          var data = json.decode(response.body);

          var getDataList = data[0];

          if (getDataList["statusCode"].toString() == "200") {
            if (getDataList["aadhaar_validation"] != "") {
              var getData = getDataList["aadhaar_validation"];

              if (kDebugMode) {
                print(getData);
              }

              if (getData["statusCode"] == 200) {
                var getRes = getData["data"];

                if (getRes != null || getRes != "") {
                  Loader.hide();

                  String requestId = getRes["requestId"].toString();
                  // String status = getRes["status"].toString();

                  SaveVerifyData.aadharNumberVerify = aadhaarController.text;
                  SaveVerifyData.reqIDGen = requestId;
                  AccOpenStart.aadhaar = aadhaarController.text.toString();
                  AccOpenStart.phoneNumber = phoneController.text.toString();
                  AccOpenStart.email = emailController.text.toString();
                  AccOpenStart.pan = panController.text.toString();
                  
                  await QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.success,
                                  text: getData["message"].toString(),
                                  );
                         
                  Navigator.push(
                    
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SVAadhaarOTP()));
                          
                } else {
                  Loader.hide();
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertBox(
                        title: "Alert",
                        description: getData["message"].toString(),
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
                      description: getData["message"].toString(),
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
                    description: "Server failed..!",
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
                  description: "Server failed..!",
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
                description: "Server failed..!",
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
              description: "Unable to Connect to the Server",
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
            description: "Unable to Connect to the Server",
          );
        },
      );

      return;
    }
  }

  Future<void> getTermPDF() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      String restUrl = "jsp/Terms.pdf";

      Uri pdfUrl = Uri.parse(restUrl);

      launchUrl(
        pdfUrl,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      Loader.hide();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Builder(
            builder: (context) {
              return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.1)),
                child: AlertDialog(
                  backgroundColor: AppColors.onPrimary,
                  title: const Text('Alert',style: TextStyle(fontSize: 18),),
                  content: Text('An error occurred: ${e.toString()}',style: const TextStyle(fontSize: 18)),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK',style: TextStyle(fontSize: 18)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            }
          );
        },
      );

      return;
    }
  }
}
