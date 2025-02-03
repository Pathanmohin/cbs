// import 'package:HPSCB/ui/applydashboard/loanaccount/Eligibility_Loan.dart';
// import 'package:HPSCB/ui/applydashboard/loanaccount/aadhar_validation.dart';
// import 'package:HPSCB/ui/applydashboard/loanaccount/loan_deasire.dart';
// import 'package:HPSCB/ui/applydashboard/savingaccount/saveverifydata.dart';
// import 'package:flutter/material.dart';

// class PersonalLoanApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: EligibilityFormApp(),
//     );
//   }
// }

// class EligibilityFormApp extends StatefulWidget {
//   @override
//   _LoanFormScreenState createState() => _LoanFormScreenState();
// }

// class _LoanFormScreenState extends State<EligibilityFormApp> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     panNumberController.text = SaveVerifyData.mName;
//     dobcontroler.text = SaveVerifyData.dobb;

//     setState(() {});
//   }

//   final TextEditingController loanAmountController = TextEditingController();
//   final TextEditingController firstNameController = TextEditingController();
//   final TextEditingController middleNameController = TextEditingController();
//   final TextEditingController lastNameController = TextEditingController();
//   final TextEditingController panNumberController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController pinCodeController = TextEditingController();
//   final TextEditingController dobcontroler = TextEditingController();

//   String? selectedTenure;
//   String? selectedNationality;
//   String? selectedGender;
//   String? selectedEmploymentType;
//   String? selectedNetMonthlyIncome;
//   String? dateOfBirth;
//   bool termsAccepted = false;

//   final List<String> tenureOptions = [
//     '12 months',
//     '24 months',
//     '36 months',
//     '48 months',
//     '60 months',
//     '72 months'
//   ];

//   final List<String> nationalityOptions = ['Indian', 'Non-Indian'];
//   final List<String> genderOptions = ['Male', 'Female', 'Other'];
//   final List<String> employmentTypeOptions = [
//     'Salaried',
//     'Self-Employed Business',
//     'Unemployed',
//     'House Person',
//     'Retired',
//     'Student'
//   ];
//   final List<String> netMonthlyIncomeOptions = [
//     'Below ₹20,000',
//     '₹20,000 - ₹40,000',
//     '₹40,000 - ₹60,000',
//     '₹60,000 - ₹80,000',
//     '₹80,000 - ₹1,00,000',
//     'Above ₹1,00,000'
//   ];

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

//   void _submitLoanRequest() {
//     final incomeem = selectedNetMonthlyIncome;
//     final empptype = selectedEmploymentType;
//     final emailidddd = emailController.text;

//     // Process the input data as needed
//     print('Income: $incomeem');
//     print('Emp Type: $empptype');
//     print('Email id: $emailidddd');

//     SaveVerifyData.incomeee = incomeem.toString();
//     SaveVerifyData.emptypee = empptype.toString();
//     SaveVerifyData.emailiddd = emailidddd.toString();
//     // SaveVerifyData.dobb = dob.toString();

//     String loanAmountText = loanAmountController.text;
//     String firstNameText = firstNameController.text;
//     String middleNameText = middleNameController.text;
//     String lastNameText = lastNameController.text;
//     String panNumberText = panNumberController.text;
//     String emailText = emailController.text;
//     String pinCodeText = pinCodeController.text;

//     // Validation checksf

//     if (firstNameText.isEmpty) {
//       _showAlertDialog(context, 'Alert', 'Please enter your first name.');
//       return;
//     }

//     if (lastNameText.isEmpty) {
//       _showAlertDialog(context, 'Alert', 'Please enter your last name.');
//       return;
//     }

//     // if (panNumberText.isEmpty) {
//     //   _showAlertDialog(context, 'Alert', 'Please enter your PAN number.');
//     //   return;
//     // }

//     if (selectedNationality == null) {
//       _showAlertDialog(context, 'Alert', 'Please select your nationality.');
//       return;
//     }

//     if (selectedGender == null) {
//       _showAlertDialog(context, 'Alert', 'Please select your gender.');
//       return;
//     }

//     if (selectedEmploymentType == null) {
//       _showAlertDialog(context, 'Alert', 'Please select your employment type.');
//       return;
//     }

//     if (selectedNetMonthlyIncome == null) {
//       _showAlertDialog(
//           context, 'Alert', 'Please select your net monthly income.');
//       return;
//     }

//     if (emailText.isEmpty) {
//       _showAlertDialog(context, 'Alert', 'Please enter your email address.');
//       return;
//     } else if (!_isValidEmail(emailText)) {
//       _showAlertDialog(
//           context, 'Invalid Email', 'Please enter a valid Gmail address.');
//       return;
//     }

//     if (pinCodeText.isEmpty) {
//       _showAlertDialog(context, 'Alert', 'Please enter your current pin code.');
//       return;
//     }

//     if (!termsAccepted) {
//       _showAlertDialog(
//           context, 'Alert', 'Please accept the terms and conditions.');
//       return;
//     }

//     // Proceed to Aadhar entry form if all validations are passed
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => LoanFormScreen()),
//     );
//   }

// // Email validation function
//   bool _isValidEmail(String email) {
//     final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
//     return regex.hasMatch(email);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => eligiblityLoan()));
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Eligibility Form',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Color(0xFF0057C2),
//           iconTheme: const IconThemeData(
//             color: Colors.white,
//             //change your color here
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Card(
//               elevation: 4.0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         'Hi, Help us assess your Eligibility',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Color(0xFF0057C2)),
//                       ),
//                     ),

//                     // Personal Information Fields
//                     TextField(
//                       controller: firstNameController,
//                       decoration: InputDecoration(
//                         labelText: 'First Name as per PAN',
//                         labelStyle: TextStyle(color: Colors.black),
//                         prefixIcon: Icon(Icons.person),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     TextField(
//                       controller: middleNameController,
//                       decoration: InputDecoration(
//                         labelText: 'Middle Name as per PAN',
//                         labelStyle: TextStyle(color: Colors.black),
//                         prefixIcon: Icon(Icons.person),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     TextField(
//                       controller: lastNameController,
//                       decoration: InputDecoration(
//                         labelText: 'Last Name as per PAN',
//                         labelStyle: TextStyle(color: Colors.black),
//                         prefixIcon: Icon(Icons.person),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     TextField(
//                       controller: panNumberController,
//                       readOnly: true,
//                       decoration: InputDecoration(
//                         labelText: 'PAN Number',
//                         labelStyle: TextStyle(color: Colors.black),
//                         prefixIcon: Icon(Icons.credit_card),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     DropdownButtonFormField<String>(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Select Nationality',
//                         labelStyle: TextStyle(color: Colors.black),
//                         prefixIcon: Icon(Icons.public),
//                       ),
//                       value: selectedNationality,
//                       items: nationalityOptions.map((nationality) {
//                         return DropdownMenuItem(
//                           value: nationality,
//                           child: Text(nationality),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           selectedNationality = value;
//                         });
//                       },
//                     ),
//                     SizedBox(height: 8),
//                     DropdownButtonFormField<String>(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Select Gender',
//                         labelStyle: TextStyle(color: Colors.black),
//                         prefixIcon: Icon(Icons.male),
//                       ),
//                       value: selectedGender,
//                       items: genderOptions.map((gender) {
//                         return DropdownMenuItem(
//                           value: gender,
//                           child: Text(gender),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           selectedGender = value;
//                         });
//                       },
//                     ),
//                     SizedBox(height: 8),
//                     TextField(
//                       controller: dobcontroler,
//                       readOnly: true,
//                       decoration: InputDecoration(
//                         labelText: 'Date of brith',
//                         labelStyle: TextStyle(color: Colors.black),
//                         prefixIcon: Icon(Icons.credit_card),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     DropdownButtonFormField<String>(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Employment Type',
//                         labelStyle: TextStyle(color: Colors.black),
//                         prefixIcon: Icon(Icons.work),
//                       ),
//                       value: selectedEmploymentType,
//                       items: employmentTypeOptions.map((employment) {
//                         return DropdownMenuItem(
//                           value: employment,
//                           child: Text(employment),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           selectedEmploymentType = value;
//                         });
//                       },
//                     ),
//                     SizedBox(height: 8),
//                     DropdownButtonFormField<String>(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Net Monthly Income',
//                         labelStyle: TextStyle(color: Colors.black),
//                         prefixIcon: Icon(Icons.money),
//                       ),
//                       value: selectedNetMonthlyIncome,
//                       items: netMonthlyIncomeOptions.map((income) {
//                         return DropdownMenuItem(
//                           value: income,
//                           child: Text(income),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           selectedNetMonthlyIncome = value;
//                         });
//                       },
//                     ),
//                     SizedBox(height: 8),
//                     TextField(
//                       controller: emailController,
//                       decoration: InputDecoration(
//                         labelText: 'Email ID',
//                         labelStyle: TextStyle(color: Colors.black),
//                         prefixIcon: Icon(Icons.email),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     TextField(
//                       controller: pinCodeController,
//                       keyboardType: TextInputType.number,
//                       maxLength: 6,
//                       decoration: InputDecoration(
//                         labelText: 'Current Pin Code',
//                         labelStyle: TextStyle(color: Colors.black),
//                         prefixIcon: Icon(Icons.location_pin),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Checkbox(
//                           value: termsAccepted,
//                           onChanged: (value) {
//                             setState(() {
//                               termsAccepted = value!;
//                             });
//                           },
//                         ),
//                         Flexible(
//                           child: Text('I accept the terms and conditions',
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 15)),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 14),
//                     Center(
//                       child: ElevatedButton(
//                         onPressed: _submitLoanRequest,
//                         child: Text(
//                           'Next',
//                           style: TextStyle(
//                               fontSize: 18), // Increase the font size if needed
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: Color(0xFF0057C2),
//                           minimumSize:
//                               Size(200, 50), // Set the width and height here
//                           padding: EdgeInsets.symmetric(
//                               horizontal:
//                                   20), // Add horizontal padding for more width
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
