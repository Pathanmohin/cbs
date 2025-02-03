// import 'dart:convert';
// import 'package:HPSCB/ip/ipset.dart';
// import 'package:HPSCB/ui/alertui/alert.dart';
// import 'package:HPSCB/ui/applydashboard/applyaccount.dart';
// import 'package:HPSCB/ui/applydashboard/loanaccount/aadhar_validation.dart';
// import 'package:HPSCB/ui/applydashboard/loanaccount/apply/loanapply.dart';
// import 'package:HPSCB/ui/applydashboard/loanaccount/eligilibity_asses.dart';
// import 'package:HPSCB/ui/applydashboard/loanaccount/loan_deasire.dart';
// import 'package:HPSCB/ui/applydashboard/savingaccount/saveverifydata.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
// import 'package:hpscb/utility/alertbox.dart';
// import 'package:intl/intl.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:http/http.dart' as http;
// import 'package:platform_device_id_v3/platform_device_id.dart';

// class eligiblityLoan extends StatefulWidget {
//   const eligiblityLoan({super.key});
//   @override
//   State<StatefulWidget> createState() => _SavingApplyState();
// }

// class UpperCaseTextInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     return TextEditingValue(
//       text: newValue.text.toUpperCase(),
//       selection: newValue.selection,
//     );
//   }
// }

// class _SavingApplyState extends State<eligiblityLoan> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController phonenymber = TextEditingController();
//   final TextEditingController _PANNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController dobController = TextEditingController();
//   bool _isTermsAccepted = false;
//   bool _isConsentGiven = false;
//   PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'IN');

//   @override
//   void dispose() {
//     phonenymber.dispose();
//     _PANNameController.dispose();
//     _lastNameController.dispose();
//     super.dispose();
//   }

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       final String phoneNo = phonenymber.text;
//       final pancardd = _PANNameController.text;
//       final lastName = _lastNameController.text;

//       final dob = dobController.text;

//       // Process the input data as needed
//       print('Phone Number: $phoneNo');
//       print('PAN Card: $pancardd');
//       print('Last Name: $lastName');
//       print('DOB: $dob');
//       print('Phone Number: ${_phoneNumber.phoneNumber}');

//       SaveVerifyData.fName = phoneNo.toString();
//       SaveVerifyData.mName = pancardd.toString();
//       SaveVerifyData.lName = lastName.toString();
//       SaveVerifyData.dobb = dob.toString();

//       SaveVerifyData.verifyOTP = _phoneNumber.phoneNumber.toString();

//       // getOTPNumber();
//       Navigator.push(context,
//           MaterialPageRoute(builder: (context) => EligibilityFormApp()));
//       // Show a success message or navigate to another page
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Builder(builder: (context) {
//       return MediaQuery(
//         data:
//             MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
//         child: WillPopScope(
//           onWillPop: () async {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => ApplyAccount()));
//             return false;
//           },
//           child: Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               title: const Text(
//                 "Loan Application ",
//                 style: TextStyle(color: Colors.white),
//               ),
//               backgroundColor: const Color(0xFF0057C2),
//               iconTheme: const IconThemeData(
//                 color: Colors.white,
//                 //change your color here
//               ),
//             ),
//             body: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Container(
//                   width: size.width,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.0),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.2),
//                         spreadRadius: 1,
//                         blurRadius: 5,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         // Padding(
//                         //   padding: const EdgeInsets.all(8.0),
//                         //   child: const Text(
//                         //     "Pan",
//                         //     style: TextStyle(
//                         //         color: const Color(0xFF0057C2),
//                         //         fontSize: 16.0,
//                         //         fontWeight: FontWeight.bold),
//                         //   ),
//                         // ),

//                         Padding(
//                           padding: const EdgeInsets.only(
//                               left: 8.0, right: 8.0, bottom: 8.0),
//                           child: TextFormField(
//                             controller: _PANNameController,
//                             decoration: InputDecoration(
//                               labelText: 'PAN *',
//                               labelStyle: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold),
//                               prefixIcon: Icon(Icons.assignment_ind),
//                             ),
//                             inputFormatters: [
//                               LengthLimitingTextInputFormatter(10),
//                               UpperCaseTextInputFormatter(),
//                             ],
//                             validator: (value) {
//                               // Check if the field is empty
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your PAN';
//                               }

//                               // Check the length of the PAN
//                               if (value.length != 10) {
//                                 return 'PAN must be exactly 10 characters long';
//                               }

//                               // Define the PAN format using a regex
//                               final panRegex =
//                                   RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
//                               if (!panRegex.hasMatch(value)) {
//                                 return 'Invalid PAN format';
//                               }

//                               return null; // If all validations pass, return null
//                             },
//                           ),
//                         ),

//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: const Text(
//                             "Aadhar Link Mobile Number",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 16.0,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),

//                         Padding(
//                           padding: const EdgeInsets.only(
//                               left: 8.0, right: 8.0, top: 10.0),
//                           child: TextFormField(
//                             controller: phonenymber,
//                             keyboardType: TextInputType.number,
//                             decoration: InputDecoration(
//                               labelText: 'Enter Phone  Number',
//                               border: OutlineInputBorder(),
//                               prefixIcon: Icon(Icons.phone),
//                             ),
//                             maxLength: 10,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your Phone number';
//                               }
//                               if (value.length != 10) {
//                                 return 'phone Number  must be 10 Digits';
//                               }
//                             },
//                             // onSaved: (PhoneNumber number) {
//                             //   _phoneNumber = number;
//                             // },
//                           ),
//                         ),

//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: const Text(
//                             "DOB as per Aadhar or Pen",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 16.0,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         // Adding Date of Birth field with Date Picker
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               left: 8.0, right: 8.0, top: 10.0),
//                           child: TextFormField(
//                             controller:
//                                 dobController, // Add this TextEditingController
//                             decoration: InputDecoration(
//                               labelText: 'Select Date of Birth',
//                               border: OutlineInputBorder(),
//                               prefixIcon: Icon(Icons.calendar_today),
//                             ),
//                             readOnly: true, // Makes the field non-editable
//                             onTap: () async {
//                               // Display date picker
//                               DateTime? pickedDate = await showDatePicker(
//                                 context: context,
//                                 initialDate: DateTime.now(),
//                                 firstDate:
//                                     DateTime(1900), // Earliest date to select
//                                 lastDate:
//                                     DateTime.now(), // Latest date to select
//                               );

//                               if (pickedDate != null) {
//                                 // Format the selected date and update the TextFormField
//                                 String formattedDate =
//                                     DateFormat('dd/MM/yyyy').format(pickedDate);
//                                 dobController.text =
//                                     formattedDate; // Assign the formatted date to the controller
//                               }
//                             },
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please select your Date of Birth';
//                               }

//                               // Parse the selected date of birth
//                               DateTime selectedDate =
//                                   DateFormat('dd/MM/yyyy').parse(value);

//                               // Calculate the difference between today and the selected date
//                               int age = DateTime.now().year - selectedDate.year;

//                               // Adjust if the birthday hasn't occurred this year
//                               if (DateTime.now().month < selectedDate.month ||
//                                   (DateTime.now().month == selectedDate.month &&
//                                       DateTime.now().day < selectedDate.day)) {
//                                 age--;
//                               }

//                               if (age < 18) {
//                                 return 'You must be at least 18 years old.';
//                               }

//                               return null;
//                             },
//                           ),
//                         ),

//                         CheckboxListTile(
//                           title: const Text(
//                             'I accept the Terms & Conditions, Terms of Use, Privacy Policy HPSCB Bank to receive my Consumer Credit Information from CIBIL',
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           value: _isTermsAccepted,
//                           onChanged: (newValue) {
//                             setState(() {
//                               _isTermsAccepted = newValue!;
//                             });
//                           },
//                           controlAffinity: ListTileControlAffinity.leading,
//                         ),

//                         // Checkbox for Consent
//                         CheckboxListTile(
//                           title: const Text(
//                             'I also confirm that I am major, resident of India and currently residing in India.',
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           value: _isConsentGiven,
//                           onChanged: (newValue) {
//                             setState(() {
//                               _isConsentGiven = newValue!;
//                             });
//                           },
//                           controlAffinity: ListTileControlAffinity.leading,
//                         ),

//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: InkWell(
//                             onTap: () async {
//                               final List<ConnectivityResult>
//                                   connectivityResult =
//                                   await (Connectivity().checkConnectivity());

//                               if (connectivityResult
//                                   .contains(ConnectivityResult.none)) {
//                                 showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return Builder(builder: (context) {
//                                       return MediaQuery(
//                                         data: MediaQuery.of(context).copyWith(
//                                             textScaler: TextScaler.linear(1.1)),
//                                         child: AlertDialog(
//                                           title: const Text(
//                                             'Alert',
//                                             style: TextStyle(fontSize: 16),
//                                           ),
//                                           content: const Text(
//                                             'Please Check Your Internet Connection',
//                                             style: TextStyle(fontSize: 16),
//                                           ),
//                                           actions: [
//                                             TextButton(
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                               },
//                                               child: const Text(
//                                                 'OK',
//                                                 style: TextStyle(fontSize: 16),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     });
//                                   },
//                                 );
//                                 return;
//                               } else if (_PANNameController.text == null &&
//                                   _PANNameController.text == "" &&
//                                   phonenymber.text == null &&
//                                   phonenymber.text == "" &&
//                                   dobController.text == null &&
//                                   dobController.text == "") {
//                                 if (!_isTermsAccepted || !_isConsentGiven) {
//                                   showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return AlertDialog(
//                                         title: const Text('Accept T&C'),
//                                         content: const Text(
//                                           'Please accept the Terms & Conditions and give consent before submitting.',
//                                           style: TextStyle(fontSize: 15),
//                                         ),
//                                         actions: [
//                                           TextButton(
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                             },
//                                             child: const Text('OK'),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );
//                                 }

//                                 _submitForm();
//                               } else if (_PANNameController.text != null &&
//                                   _PANNameController.text != "" &&
//                                   phonenymber.text != null &&
//                                   phonenymber.text != "" &&
//                                   dobController.text != null &&
//                                   dobController.text != "") {
//                                 if (!_isTermsAccepted || !_isConsentGiven) {
//                                   showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return AlertDialog(
//                                         title: const Text('Accept T&C'),
//                                         content: const Text(
//                                             'Please accept the Terms & Conditions and give consent before submitting.',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 15)),
//                                         actions: [
//                                           TextButton(
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                             },
//                                             child: const Text('OK'),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );
//                                 } else {
//                                   _submitForm();
//                                 }
//                               } else {
//                                 _submitForm();
//                               }
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 10.0,
//                                   left: 10.0,
//                                   right: 10.0,
//                                   bottom: 10.0),
//                               child: Container(
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFF0057C2),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     "Check Eligibility",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }

//   Future<void> getOTPNumber() async {
//     String num = _phoneNumber.phoneNumber.toString();

//     try {
//       // String ip = ServerDetails().getIPaddress();
//       // String port = ServerDetails().getPort();
//       // String protocol = ServerDetails().getProtocol();
//       // String? deviceId = await PlatformDeviceId.getDeviceId;

//       Loader.show(context,
//           progressIndicator: const CircularProgressIndicator());

//       String apiUrl =
//           "rest/AccountService/newaccOpeningByMobile";

//       String jsonString = jsonEncode({
//         "firstname": phonenymber.text,
//         "midname": _PANNameController.text,
//         "lastname": _lastNameController.text,
//         "mobile": _phoneNumber.phoneNumber.toString(),
//         "systemUniqueid": deviceId.toString()
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
//           var res = jsonDecode(response.body);

//           if (res["Result"].toString().toLowerCase() == "success") {
//             print(res);

//             Loader.hide();

//             await showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return Builder(builder: (context) {
//                   return MediaQuery(
//                     data: MediaQuery.of(context)
//                         .copyWith(textScaler: const TextScaler.linear(1.1)),
//                     child: AlertBox(
//                       title: "Success",
//                       description: res["Data"].toString(),
//                     ),
//                   );
//                 });
//               },
//             );

//             // AccOpenStart.name = phonenymber.text;
//             // AccOpenStart.middle = _PANNameController.text;
//             // AccOpenStart.sname = _lastNameController.text;
//             // AccOpenStart.phone = _phoneNumber.phoneNumber.toString();
//             // AccOpenStart.uniId = deviceId.toString();

//             // Navigator.push(context,
//             //     MaterialPageRoute(builder: (context) => const OTPPage()));
//           } else if (res["Result"].toString().toLowerCase() == "fail") {
//             Loader.hide();
//             await showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return Builder(builder: (context) {
//                   return MediaQuery(
//                     data: MediaQuery.of(context)
//                         .copyWith(textScaler: const TextScaler.linear(1.1)),
//                     child: AlertBox(
//                       title: "Alert",
//                       description: res["Data"].toString(),
//                     ),
//                   );
//                 });
//               },
//             );

//             return;
//           } else {
//             Loader.hide();
//             await showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return Builder(builder: (context) {
//                   return MediaQuery(
//                     data: MediaQuery.of(context)
//                         .copyWith(textScaler: const TextScaler.linear(1.1)),
//                     child: AlertBox(
//                       title: "Alert",
//                       description: "Server is not responding..!",
//                     ),
//                   );
//                 });
//               },
//             );

//             return;
//           }
//         } else {
//           Loader.hide();
//           await showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return Builder(builder: (context) {
//                 return MediaQuery(
//                   data: MediaQuery.of(context)
//                       .copyWith(textScaler: const TextScaler.linear(1.1)),
//                   child: AlertBox(
//                     title: "Alert",
//                     description: "Server failed..!",
//                   ),
//                 );
//               });
//             },
//           );

//           return;
//         }
//       } catch (e) {
//         Loader.hide();
//         await showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return Builder(builder: (context) {
//               return MediaQuery(
//                 data: MediaQuery.of(context)
//                     .copyWith(textScaler: const TextScaler.linear(1.1)),
//                 child: AlertBox(
//                   title: "Alert",
//                   description: "Unable to Connect to the Server",
//                 ),
//               );
//             });
//           },
//         );

//         return;
//       }
//     } catch (e) {
//       Loader.hide();
//       await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Builder(builder: (context) {
//             return MediaQuery(
//               data: MediaQuery.of(context)
//                   .copyWith(textScaler: const TextScaler.linear(1.1)),
//               child: AlertBox(
//                 title: "Alert",
//                 description: "Unable to Connect to the Server",
//               ),
//             );
//           });
//         },
//       );

//       return;
//     }
//   }
// }
