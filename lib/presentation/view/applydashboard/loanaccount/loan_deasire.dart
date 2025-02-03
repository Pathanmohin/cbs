// import 'package:HPSCB/ui/applydashboard/loanaccount/Eligibility_Loan.dart';
// import 'package:HPSCB/ui/applydashboard/loanaccount/aadhar_validation.dart';
// import 'package:HPSCB/ui/applydashboard/loanaccount/eligilibity_asses.dart';
// import 'package:HPSCB/ui/applydashboard/savingaccount/saveverifydata.dart';
// import 'package:flutter/material.dart';

// class PersonalLoanApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoanFormScreen(),
//     );
//   }
// }

// class LoanFormScreen extends StatefulWidget {
//   @override
//   _LoanFormScreenState createState() => _LoanFormScreenState();
// }

// class _LoanFormScreenState extends State<LoanFormScreen> {
//   final TextEditingController loanAmountController = TextEditingController();
//   String? selectedTenure;
//   final List<String> tenureOptions = [
//     '12 months',
//     '24 months',
//     '36 months',
//     '48 months',
//     '60 months',
//     '72 months'
//   ];

//   final List<String> loanImages = [
//     'https://example.com/image1.jpg', // Replace with actual URLs
//     'https://example.com/image2.jpg', // Replace with actual URLs
//     'https://example.com/image3.jpg', // Replace with actual URLs
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
//     final tenuaree = selectedTenure;
//     final amoutrere = loanAmountController.text;

//     // Process the input data as needed
//     print('Tenure: $tenuaree');
//     print('Ammount : $amoutrere');

//     SaveVerifyData.tenureee = tenuaree.toString();
//     SaveVerifyData.reuireAmmt = amoutrere.toString();

//     String loanAmountText = loanAmountController.text;
//     if (loanAmountText.isEmpty) {
//       _showAlertDialog(context, 'Alert', 'Please enter the loan amount.');
//     } else {
//       int loanAmount = int.tryParse(loanAmountText) ?? 0;

//       // Validate the loan amount range and check if it's a multiple of 1000
//       if (loanAmount < 50000 || loanAmount > 5000000) {
//         _showAlertDialog(
//           context,
//           'Invalid Loan Amount',
//           'Please enter a loan amount between ₹50,000 and ₹50,00,000.',
//         );
//       } else if (loanAmount % 1000 != 0) {
//         _showAlertDialog(
//           context,
//           'Invalid Loan Amount',
//           'The loan amount must be in multiples of ₹1,000.',
//         );
//       } else if (selectedTenure == null) {
//         _showAlertDialog(
//             context, 'Alert', 'Please select a comfortable tenure.');
//       } else {
//         // Proceed to eligibility screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => AadharEntryForm()),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => EligibilityFormApp()));
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Loan Requirement',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Color(0xFF0057C2),
//           iconTheme: const IconThemeData(
//             color: Colors.white,
//             //change your color here
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Image slider outside the frame
//               // SizedBox(
//               //   height: 200,
//               //   child: PageView.builder(
//               //     itemCount: loanImages.length,
//               //     itemBuilder: (context, index) {
//               //       return Image.network(
//               //         loanImages[index],
//               //         fit: BoxFit.cover,
//               //         errorBuilder: (context, error, stackTrace) => Center(
//               //           child: Text('Image not available'),
//               //         ),
//               //       );
//               //     },
//               //   ),
//               // ),
//               // Spacing between the image slider and the card
//               SizedBox(height: 16),
//               Padding(
//                 padding:
//                     const EdgeInsets.only(bottom: 200, left: 10, right: 10),
//                 child: Center(
//                   child: Card(
//                     elevation: 4.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Help us Understand Your Loan Requirement ',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF0057C2),
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             'Get a Personal Loan up to ₹50,00,000',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15,
//                               color: Color(0xFF0057C2),
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             'Flexible Tenure from 12-72 months',
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             'Rate of Interest as low as 10.80% pa',
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             'Get your eligibility in few clicks',
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 16),
//                           Text(
//                             'Get the loan best suited for your wish',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF0057C2),
//                             ),
//                           ),
//                           SizedBox(height: 16),
//                           TextField(
//                             controller: loanAmountController,
//                             keyboardType: TextInputType.number,
//                             decoration: InputDecoration(
//                               labelText: 'How much loan do you require?',
//                               hintText: '₹ Enter loan amount',
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             'Please enter Loan Amount between ₹50,000 & ₹50,00,000 (Multiples of 1000)',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 16),
//                           DropdownButtonFormField<String>(
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               labelText: 'Select a comfortable tenure',
//                             ),
//                             value: selectedTenure,
//                             items: tenureOptions.map((tenure) {
//                               return DropdownMenuItem(
//                                 value: tenure,
//                                 child: Text(tenure),
//                               );
//                             }).toList(),
//                             onChanged: (value) {
//                               setState(() {
//                                 selectedTenure = value;
//                               });
//                             },
//                           ),
//                           SizedBox(height: 24),
//                           Center(
//                             child: ElevatedButton(
//                               onPressed: _submitLoanRequest,
//                               child: Text('Submit'),
//                               style: ElevatedButton.styleFrom(
//                                 foregroundColor: Colors.white,
//                                 backgroundColor: Color(0xFF0057C2),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
