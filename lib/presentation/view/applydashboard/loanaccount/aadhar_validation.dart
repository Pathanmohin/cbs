// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
// import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';
// // Import fluttertoast for showing toast messages

// class AadharEntryForm extends StatefulWidget {
//   @override
//   _AadharEntryFormState createState() => _AadharEntryFormState();
// }

// class _AadharEntryFormState extends State<AadharEntryForm> {
//   final TextEditingController _aadharController = TextEditingController();
//   final TextEditingController _otpController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   String aadharmoblie = '';
//   String panNumberController = '';
//   // Simulate sending OTP (this can be replaced with actual OTP sending logic)
//   bool _isOtpSent = false;

//   void _showAlertDialog(BuildContext context, String title, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     panNumberController = SaveVerifyData.mName;
//     aadharmoblie = SaveVerifyData.fName;

//     setState(() {});
//   }

//   void _sendOtp() {
//     String aadarNumber = _aadharController.text;

//     if (aadarNumber.isEmpty) {
//       _showAlertDialog(context, 'Alert', 'Please enter your Aadhar Number.');
//       return;
//     } else if (_aadharController.text.length != 12) {
//       _showAlertDialog(context, 'Alert', 'Aadhar Must be 12 digit .');
//       return;
//     }

//     setState(() {
//       getOTPVerify();
//       //  _isOtpSent = true;
//     });
//   }

//   void _submitOtp() {
//     // Logic to handle OTP submission
//     if (_otpController.text.isEmpty) {
//       Fluttertoast.showToast(
//         msg: "Please enter the OTP.",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     } else if (_otpController.text.length != 6) {
//       Fluttertoast.showToast(
//         msg: "OTP must be 6 digits.",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     } else {
//       // Here you can add actual OTP verification logic

//       getAadhaarRes();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'verify your Aadhar',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Color(0xFF0057C2),
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//           //change your color here
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: WillPopScope(
//           onWillPop: () async {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => LoanFormScreen()));
//             return false;
//           },
//           key: _formKey,
//           child: SingleChildScrollView(
//             // Allows scrolling for smaller screens
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Let's verify your Aadhar number",
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   "Your privacy is very important to us. Verifying your Aadhar number helps to protect your account.",
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 SizedBox(height: 24), // Increased space after the description
//                 // Aadhar Number Input Field
//                 TextFormField(
//                   controller: _aadharController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     labelText: 'Enter Aadhar Number',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.credit_card),
//                   ),
//                   maxLength: 12,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your Aadhar number';
//                     } else if (value.length != 12) {
//                       return 'Aadhar number must be 12 digits';
//                     } else if (!RegExp(r'^[0-9]{12}$').hasMatch(value)) {
//                       return 'Please enter a valid Aadhar number';
//                     }
//                     return null;
//                   },
//                 ),

//                 SizedBox(height: 20),
//                 // Send OTP Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _sendOtp,
//                     child: Text('Send OTP'),
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: Color(0xFF0057C2),
//                     ),
//                   ),
//                 ),
//                 Text(
//                   'if you do not get OTP so Click Again (Send OTP Button)',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 // OTP Input Field (visible only after sending OTP)
//                 if (_isOtpSent) ...[
//                   SizedBox(height: 20),
//                   TextFormField(
//                     controller: _otpController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       labelText: 'Enter OTP',
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.password),
//                     ),
//                     maxLength: 6,
//                   ),
//                   SizedBox(height: 20),
//                   // Submit OTP Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: _submitOtp,
//                       child: Text('Submit OTP'),
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: Color(0xFF0057C2),
//                       ),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> getOTPVerify() async {
//     DateTime now = DateTime.now();

//     // Format the date (Optional, use Intl package)
//     String formattedDate = DateFormat('yyyy-MM-dd').format(now);

//     try {
//       String ip = ServerDetails().getIPaddress();
//       String port = ServerDetails().getPort();
//       String protocol = ServerDetails().getProtocol();
//       // String? deviceId = await PlatformDeviceId.getDeviceId;

//       Loader.show(context,
//           progressIndicator: const CircularProgressIndicator());

//       String apiUrl = "$protocol$ip$port/rest/AccountService/aadharotpsend";

//       String jsonString = jsonEncode({
//         "aadhaarnumber": _aadharController.text,
//         "aadhaarMob": aadharmoblie,
//         "Email": '',
//         "Pan": panNumberController,
//         "Date": formattedDate,
//       });

//       Map<String, String> headers = {
//         "Content-Type": "application/x-www-form-urlencoded",
//       };

//       var response = await http.post(
//         Uri.parse(apiUrl),
//         body: jsonString,
//         headers: headers,
//         encoding: Encoding.getByName('utf-8'),
//       );

//       try {
//         if (response.statusCode == 200) {
//           var data = json.decode(response.body);

//           var getDataList = data[0];

//           if (getDataList["statusCode"].toString() == "200") {
//             if (getDataList["aadhaar_validation"] != "") {
//               var getData = getDataList["aadhaar_validation"];

//               print(getData);

//               if (getData["statusCode"] == 200) {
//                 var getRes = getData["data"];

//                 if (getRes != null || getRes != "") {
//                   String requestId = getRes["requestId"].toString();
//                   // String status = getRes["status"].toString();

//                   String msg = getData["message"].toString();

//                   Loader.hide();
//                   await showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertBox(
//                         title: "Success",
//                         description: msg,
//                       );
//                     },
//                   );

//                   _isOtpSent = true;

//                   SaveVerifyData.aadharNumberVerify = _aadharController.text;
//                   SaveVerifyData.reqIDGen = requestId;

//                   // Navigator.push(
//                   //     context,
//                   //     MaterialPageRoute(
//                   //         builder: (context) => const AadhaarOTP()));
//                 } else {
//                   Loader.hide();
//                   await showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertBox(
//                         title: "Alert",
//                         description: getData["message"].toString(),
//                       );
//                     },
//                   );

//                   return;
//                 }
//               } else {
//                 Loader.hide();
//                 await showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertBox(
//                       title: "Alert",
//                       description: getData["message"].toString(),
//                     );
//                   },
//                 );

//                 return;
//               }
//             } else {
//               Loader.hide();
//               await showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertBox(
//                     title: "Alert",
//                     description: "Server failed..!",
//                   );
//                 },
//               );

//               return;
//             }
//           } else {
//             Loader.hide();
//             await showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertBox(
//                   title: "Alert",
//                   description: "Server failed..!",
//                 );
//               },
//             );

//             return;
//           }
//         } else {
//           Loader.hide();
//           await showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertBox(
//                 title: "Alert",
//                 description: "Server failed..!",
//               );
//             },
//           );

//           return;
//         }
//       } catch (e) {
//         Loader.hide();
//         await showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertBox(
//               title: "Alert",
//               description: "Unable to Connect to the Server",
//             );
//           },
//         );

//         return;
//       }
//     } catch (e) {
//       Loader.hide();
//       await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertBox(
//             title: "Alert",
//             description: "Unable to Connect to the Server",
//           );
//         },
//       );

//       return;
//     }
//   }

//   Future<void> getAadhaarDetails() async {
//     try {
//       String ip = ServerDetails().getIPaddress();
//       String port = ServerDetails().getPort();
//       String protocol = ServerDetails().getProtocol();
//       // String? deviceId = await PlatformDeviceId.getDeviceId;

//       Loader.show(context,
//           progressIndicator: const CircularProgressIndicator());

//       String apiUrl = "$protocol$ip$port/rest/AccountService/aadharotpsend";

//       String jsonString = jsonEncode({
//         "aadhaarnumber": SaveVerifyData.aadharNumberVerify,
//       });

//       Map<String, String> headers = {
//         "Content-Type": "application/x-www-form-urlencoded",
//       };

//       var response = await http.post(
//         Uri.parse(apiUrl),
//         body: jsonString,
//         headers: headers,
//         encoding: Encoding.getByName('utf-8'),
//       );

//       try {
//         if (response.statusCode == 200) {
//           Map<String, dynamic> data = jsonDecode(response.body);

//           if (data["statusCode"] == "200") {
//             if (data["aadhaar_validation"] != "") {
//               Map<String, dynamic> getData = data["aadhaar_validation"];

//               if (getData["statusCode"] == 200) {
//                 var getRes = getData["data"];

//                 if (getRes != null || getRes != "") {
//                   String requestId = getRes["requestId"].toString();
//                   // String status = getRes["status"].toString();

//                   String msg = getData["message"].toString();

//                   Loader.hide();
//                   await showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertBox(
//                         title: "Success",
//                         description: msg,
//                       );
//                     },
//                   );

//                   //   SaveVerifyData.aadharNumberVerify = aadhaarController.text;
//                   SaveVerifyData.reqIDGen = requestId;
//                 } else {
//                   Loader.hide();
//                   await showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertBox(
//                         title: "Alert",
//                         description: getData["message"].toString(),
//                       );
//                     },
//                   );

//                   return;
//                 }
//               } else {
//                 Loader.hide();
//                 await showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertBox(
//                       title: "Alert",
//                       description: getData["message"].toString(),
//                     );
//                   },
//                 );

//                 return;
//               }
//             } else {
//               Loader.hide();
//               await showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertBox(
//                     title: "Alert",
//                     description: "Server failed..!",
//                   );
//                 },
//               );

//               return;
//             }
//           } else {
//             Loader.hide();
//             await showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertBox(
//                   title: "Alert",
//                   description: "Server failed..!",
//                 );
//               },
//             );

//             return;
//           }
//         } else {
//           Loader.hide();
//           await showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertBox(
//                 title: "Alert",
//                 description: "Server failed..!",
//               );
//             },
//           );

//           return;
//         }
//       } catch (e) {
//         Loader.hide();
//         await showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertBox(
//               title: "Alert",
//               description: "Unable to Connect to the Server",
//             );
//           },
//         );

//         return;
//       }
//     } catch (e) {
//       Loader.hide();
//       await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertBox(
//             title: "Alert",
//             description: "Unable to Connect to the Server",
//           );
//         },
//       );

//       return;
//     }
//   }

//   Future<void> getAadhaarRes() async {
//     if (_otpController.text.length < 6) {
//       await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertBox(
//             title: "Alert",
//             description: 'Please Enter Correct OTP',
//           );
//         },
//       );

//       return;
//     }

//     try {
//       String ip = ServerDetails().getIPaddress();
//       String port = ServerDetails().getPort();
//       String protocol = ServerDetails().getProtocol();
//       // String? deviceId = await PlatformDeviceId.getDeviceId;

//       Loader.show(context,
//           progressIndicator: const CircularProgressIndicator());

//       String apiUrl = "$protocol$ip$port/rest/AccountService/aadharotpverify";

//       String jsonString = jsonEncode({
//         "clientid": SaveVerifyData.reqIDGen,
//         "otp": _otpController.text,
//       });

//       Map<String, String> headers = {
//         "Content-Type": "application/x-www-form-urlencoded",
//       };

//       var response = await http.post(
//         Uri.parse(apiUrl),
//         body: jsonString,
//         headers: headers,
//         encoding: Encoding.getByName('utf-8'),
//       );

//       try {
//         if (response.statusCode == 200 ||
//             response.statusCode.toString() == "200") {
//           if (response.body.isNotEmpty) {
//             var data = jsonDecode(response.body);
//             var getDataList = data[0];

//             if (getDataList["statusCode"].toString() == "200") {
//               Loader.hide();

//               var dataGet = getDataList["aadhaar_otp_submit"];

//               if (dataGet["statusCode"] == "200" ||
//                   dataGet["statusCode"] == 200) {
//                 var datafirst = dataGet["data"];

//                 AadhaarcardVerifyuser.client_id = datafirst["client_id"]
//                     .toString(); //"aadhaar_v1_Tk33p2LmWQBKKLbZumVJ",
//                 AadhaarcardVerifyuser.full_name =
//                     datafirst["full_name"].toString(); //"Mohit Sahu",
//                 AadhaarcardVerifyuser.aadhaar_number =
//                     datafirst["aadhaar_number"].toString(); //"953527038357"
//                 AadhaarcardVerifyuser.dob =
//                     datafirst["dob"].toString(); // "2000-05-12",

//                 if (datafirst["gender"] == "M") {
//                   AadhaarcardVerifyuser.gender = "Male"; //"M",
//                 } else {
//                   AadhaarcardVerifyuser.gender = "Female"; //"M",
//                 }

//                 //Address List
//                 var dataaddress = datafirst["address"];
//                 AadhaarcardVerifyuser.country =
//                     dataaddress["country"].toString(); //"India",
//                 AadhaarcardVerifyuser.dist =
//                     dataaddress["dist"].toString(); // "Jaipur",
//                 AadhaarcardVerifyuser.state =
//                     dataaddress["state"].toString(); // "Rajasthan",
//                 AadhaarcardVerifyuser.po =
//                     dataaddress["po"].toString(); // "Jaipur City",
//                 AadhaarcardVerifyuser.loc =
//                     dataaddress["loc"].toString(); // "ghatgate",
//                 AadhaarcardVerifyuser.vtc =
//                     dataaddress["vtc"].toString(); //"Jaipur",
//                 AadhaarcardVerifyuser.subdist =
//                     dataaddress["subdist"].toString(); // "",
//                 AadhaarcardVerifyuser.street =
//                     dataaddress["street"].toString(); // "",
//                 AadhaarcardVerifyuser.house =
//                     dataaddress["house"].toString(); //  "",
//                 AadhaarcardVerifyuser.landmark = dataaddress["landmark"]
//                     .toString(); // "4744/22,dadiya house purani kotwali ka rasta"

//                 AadhaarcardVerifyuser.face_status =
//                     datafirst["face_status"]; //"face_status": false,
//                 AadhaarcardVerifyuser.face_score =
//                     datafirst["face_score"]; // -1,
//                 AadhaarcardVerifyuser.zip =
//                     datafirst["zip"].toString(); // "302003",
//                 AadhaarcardVerifyuser.profile_image =
//                     datafirst["profile_image"]; //image

//                 AadhaarcardVerifyuser.has_image =
//                     datafirst["has_image"]; //"has_image": true,

//                 AadhaarcardVerifyuser.email_hash =
//                     datafirst["email_hash"].toString();
//                 AadhaarcardVerifyuser.mobile_hash = datafirst["mobile_hash"]
//                     .toString(); //"mobile_hash": "8760da2f333ef13cee1e1d03002d66ecd1e805bb2cde8763779d2ca75629c01a",
//                 AadhaarcardVerifyuser.zip_data = datafirst["zip_data"]
//                     .toString(); //"zip_data": "https://persist.signzy.tech/api/files/963781670/download/f1e4e9aa65554368a2b1faa3a34ca71a53acf71588704e9cb34d75bad370efe1.zip",
//                 AadhaarcardVerifyuser.raw_xml = datafirst["raw_xml"]
//                     .toString(); //"raw_xml": "https://persist.signzy.tech/api/files/963781669/download/502475a6518f4e6596aa93fd1066cb7401d638e2737a4e60804be7c639f6d27c.xml",

//                 AadhaarcardVerifyuser.care_of = datafirst["care_of"]
//                     .toString(); //"care_of": "S/O Surendra Kumar",
//                 AadhaarcardVerifyuser.share_code =
//                     datafirst["share_code"].toString(); // "share_code": "1234",
//                 AadhaarcardVerifyuser.mobile_verified =
//                     datafirst["mobile_verified"]; //"mobile_verified": false,
//                 AadhaarcardVerifyuser.reference_id = datafirst["reference_id"]
//                     .toString(); // "reference_id": "835720240806135000272",
//                 //   String aadhaar_pdf = datafirst["aadhaar_pdf"]; // "aadhaar_pdf": null,
//                 AadhaarcardVerifyuser.status = datafirst["status"]
//                     .toString(); // "status": "success_aadhaar",
//                 AadhaarcardVerifyuser.uniqueness_id = datafirst["uniqueness_id"]
//                     .toString(); // "uniqueness_id": ""

//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const AadhaarCard()));
//               } else {
//                 await showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertBox(
//                       title: "Alert",
//                       description: dataGet["message"].toString(),
//                     );
//                   },
//                 );

//                 return;
//               }
//             }

//             print(data);
//           } else {
//             Loader.hide();
//             await showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertBox(
//                   title: "Alert",
//                   description: "Server failed..!",
//                 );
//               },
//             );

//             return;
//           }
//         } else {
//           Loader.hide();
//           await showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertBox(
//                 title: "Alert",
//                 description: "Server failed..!",
//               );
//             },
//           );

//           return;
//         }
//       } catch (e) {
//         Loader.hide();
//         await showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertBox(
//               title: "Alert",
//               description: "Unable to Connect to the Server",
//             );
//           },
//         );

//         return;
//       }
//     } catch (e) {
//       Loader.hide();
//       await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertBox(
//             title: "Alert",
//             description: "Unable to Connect to the Server",
//           );
//         },
//       );

//       return;
//     }
//   }
// }
