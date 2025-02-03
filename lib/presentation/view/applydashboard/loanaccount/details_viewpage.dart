// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:HPSCB/ui/applydashboard/loanaccount/aadhar_validation.dart';
// import 'package:HPSCB/ui/applydashboard/savingaccount/saveverifydata.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

// class AadhaarCard extends StatefulWidget {
//   const AadhaarCard({super.key});

//   @override
//   State<StatefulWidget> createState() => _AadhaarCardState();
// }

// class _AadhaarCardState extends State<AadhaarCard> {
//   String base64Image = "";
//   final TextEditingController nameCon = TextEditingController();
//   final TextEditingController aNumberCon = TextEditingController();
//   final TextEditingController dobCon = TextEditingController();
//   final TextEditingController genderCon = TextEditingController();
//   final TextEditingController addressCon = TextEditingController();

//   final TextEditingController empliytyp = TextEditingController();
//   final TextEditingController empincome = TextEditingController();
//   final TextEditingController empemaidd = TextEditingController();
//   final TextEditingController tensureee = TextEditingController();
//   final TextEditingController amoutrequer = TextEditingController();

//   final TextEditingController pencardController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     // Initializing data from user data
//     base64Image = AadhaarcardVerifyuser.profile_image;
//     nameCon.text = AadhaarcardVerifyuser.full_name;
//     aNumberCon.text = AadhaarcardVerifyuser.aadhaar_number;
//     dobCon.text = AadhaarcardVerifyuser.dob;
//     genderCon.text = AadhaarcardVerifyuser.gender;

//     empliytyp.text = SaveVerifyData.incomeee;
//     empincome.text = SaveVerifyData.emptypee;
//     empemaidd.text = SaveVerifyData.emailiddd;
//     tensureee.text = SaveVerifyData.tenureee;
//     amoutrequer.text = SaveVerifyData.reuireAmmt;
//     pencardController.text = SaveVerifyData.mName;

//     String address = AadhaarcardVerifyuser.house +
//         AadhaarcardVerifyuser.landmark +
//         "${AadhaarcardVerifyuser.street.isNotEmpty ? AadhaarcardVerifyuser.street + ', ' : ''}"
//             "${AadhaarcardVerifyuser.loc}, ${AadhaarcardVerifyuser.po}, "
//             "${AadhaarcardVerifyuser.vtc}, ${AadhaarcardVerifyuser.dist}, "
//             "${AadhaarcardVerifyuser.state}, ${AadhaarcardVerifyuser.country}";

//     addressCon.text = address;
//     setState(() {});
//   }

//   Future<void> generatePdf() async {
//     final pdf = pw.Document();

//     // Load PNG image from assets
//     final ByteData bytes = await rootBundle.load('assets/images/logo1.png');
//     final Uint8List imageBytes = bytes.buffer.asUint8List();

//     // Add Aadhaar and Additional Details to PDF
//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Container(
//             color: PdfColors.white, // Set background color to white
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 // Centered Title
//                 pw.SizedBox(height: 20), // Add spacing at the top

//                 pw.SizedBox(height: 10), // Space between title and image
//                 pw.Center(
//                   child: pw.Image(
//                     pw.MemoryImage(imageBytes),
//                     width: 150,
//                     height: 150,
//                   ),
//                 ),
//                 pw.SizedBox(height: 20),

//                 pw.Center(
//                   child: pw.Text(
//                     "The Himachal Pradesh State Co-operative Bank Ltd.",
//                     style: pw.TextStyle(
//                       fontSize: 20,
//                       color: PdfColors.blue,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                     textAlign: pw.TextAlign.center,
//                   ),
//                 ),
//                 pw.Center(
//                   child: pw.Text(
//                     "Loan Application Form",
//                     style: pw.TextStyle(
//                       fontSize: 20,
//                       //fontWeight: pw.FontWeight.bold,
//                     ),
//                     textAlign: pw.TextAlign.center,
//                   ),
//                 ),

//                 pw.Center(
//                   child: pw.Text(
//                     "29891694291",
//                     style: pw.TextStyle(
//                       fontSize: 20,
//                       //fontWeight: pw.FontWeight.bold,
//                     ),
//                     textAlign: pw.TextAlign.center,
//                   ),
//                 ), // Space between image and title

//                 pw.SizedBox(height: 10),
//                 // Aadhaar Details
//                 pw.Text("Aadhaar Details",
//                     style: pw.TextStyle(
//                       fontSize: 24,
//                     )),
//                 pw.SizedBox(height: 10),
//                 pw.Text("Name: ${nameCon.text}",
//                     style: pw.TextStyle(
//                       fontSize: 15,
//                     )),
//                 pw.Text("Aadhaar Number: ${aNumberCon.text}",
//                     style: pw.TextStyle(
//                       fontSize: 15,
//                     )),

//                 pw.Text("Date of Birth: ${dobCon.text}",
//                     style: pw.TextStyle(
//                       fontSize: 15,
//                     )),

//                 pw.Text("Gender: ${genderCon.text}",
//                     style: pw.TextStyle(
//                       fontSize: 15,
//                     )),

//                 pw.Text("Address: ${addressCon.text}",
//                     style: pw.TextStyle(
//                       fontSize: 15,
//                     )),

//                 pw.SizedBox(height: 20),
//                 // Additional Details
//                 pw.Text("Additional Details",
//                     style: pw.TextStyle(
//                       fontSize: 24,
//                     )),

//                 pw.Text("Pen Card: ${pencardController.text}",
//                     style: pw.TextStyle(
//                       fontSize: 15,
//                     )),

//                 pw.Text("Monthly Income: ${empliytyp.text}",
//                     style: pw.TextStyle(
//                       fontSize: 15,
//                     )),

//                 pw.Text("Employee Type: ${empincome.text}",
//                     style: pw.TextStyle(
//                       fontSize: 15,
//                     )),

//                 pw.Text("Email ID: ${empemaidd.text}",
//                     style: pw.TextStyle(
//                       fontSize: 15,
//                     )),

//                 pw.Text("Required Loan Amount: ${amoutrequer.text}",
//                     style: pw.TextStyle(
//                       fontSize: 15,
//                     )),

//                 pw.Text("Comfortable Tenure: ${tensureee.text}",
//                     style: pw.TextStyle(
//                       fontSize: 15,
//                     )),

//                 // Add Email and Contact Number at the end
//                 pw.SizedBox(
//                     height: 150), // Space before email and contact number
//                 pw.Text("Email: ${empemaidd.text}",
//                     style: pw.TextStyle(fontSize: 15)),
//                 pw.Text("Contact Number: ${8118813481}",
//                     style: pw.TextStyle(fontSize: 15)),
//               ],
//             ),
//           );
//         },
//       ),
//     );

//     // Save or Print PDF
//     try {
//       await Printing.layoutPdf(
//         onLayout: (PdfPageFormat format) async => pdf.save(),
//       );
//     } catch (e) {
//       print("Error generating PDF: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => AadharEntryForm()));
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: Text(
//             "Aadhaar Details",
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: const Color(0xFF0057C2),
//           iconTheme: const IconThemeData(
//             color: Colors.white,
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               children: [
//                 // Aadhaar Details Section
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: const Text(
//                     "Aadhaar Details",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 buildTextField(
//                     controller: nameCon, label: "Name", icon: Icons.person),
//                 buildTextField(
//                     controller: aNumberCon,
//                     label: "Aadhaar Number",
//                     icon: Icons.edit_document),
//                 buildTextField(
//                     controller: dobCon,
//                     label: "Date of Birth",
//                     icon: Icons.cake),
//                 buildTextField(
//                     controller: genderCon,
//                     label: "Gender",
//                     icon: Icons.male_outlined),
//                 buildTextField(
//                     controller: addressCon,
//                     label: "Address",
//                     icon: Icons.location_on,
//                     maxLines: 3),

//                 // Additional Details Section
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: const Text(
//                     "Additional Details",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 buildTextField(
//                     controller: pencardController,
//                     label: "Pen Card",
//                     icon: Icons.card_membership),
//                 buildTextField(
//                     controller: empliytyp,
//                     label: "Monthly Income",
//                     icon: Icons.monetization_on),
//                 buildTextField(
//                     controller: empincome,
//                     label: "Employee Type",
//                     icon: Icons.business_center),
//                 buildTextField(
//                     controller: empemaidd,
//                     label: "Email ID",
//                     icon: Icons.email),
//                 buildTextField(
//                     controller: amoutrequer,
//                     label: "Required Loan Amount",
//                     icon: Icons.attach_money),
//                 buildTextField(
//                     controller: tensureee,
//                     label: "Comfortable Tenure",
//                     icon: Icons.timelapse),
//                 SizedBox(height: 20),
//                 // Button to generate and share PDF
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Container(
//                       width: 150, // Set the desired width
//                       height: 45, // Set the desired height
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Implement your submission functionality here
//                         },
//                         child: Text(
//                           "Submit",
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: Color(0xFF0057C2),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: 150, // Set the desired width
//                       height: 45, // Set the desired height
//                       child: ElevatedButton(
//                         onPressed: () {
//                           generatePdf(); // Ensure PDF is generated before saving
//                         },
//                         child: Text(
//                           "Save PDF",
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: Color(0xFF0057C2),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 // SizedBox(height: 20),
//                 // // Button to generate PDF
//                 // ElevatedButton(
//                 //   onPressed: () {
//                 //     generatePdf();
//                 //   },
//                 //   child: Text("Save PDF"),
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     int maxLines = 1,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: TextFormField(
//         controller: controller,
//         maxLines: maxLines,
//         readOnly: true,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           labelText: label,
//           prefixIcon: Icon(icon),
//         ),
//       ),
//     );
//   }
// }
