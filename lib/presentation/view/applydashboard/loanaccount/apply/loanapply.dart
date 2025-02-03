// import 'package:HPSCB/ui/applydashboard/loanaccount/apply/loanmodel.dart';
// import 'package:HPSCB/ui/applydashboard/loanaccount/apply/loansave.dart';
// import 'package:HPSCB/ui/auth/login.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:readmore/readmore.dart';

// class LoanAccount extends StatefulWidget {
//   const LoanAccount({super.key});

//   @override
//   State<LoanAccount> createState() => _LoanAccountState();
// }

// class _LoanAccountState extends State<LoanAccount> {
//   List<LoanDetails> loanacc = [];

//   @override
//   void initState() {
//     super.initState();

//     loanacc = LoansaveData.loanacc;
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Builder(builder: (context) {
//       return MediaQuery(
//           data: MediaQuery.of(context)
//               .copyWith(textScaler: const TextScaler.linear(1.0)),
//           child: Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               title: const Text(
//                 "Loan Account",
//                 style: TextStyle(color: Colors.white),
//               ),
//               backgroundColor: const Color(0xFF0057C2),
//               actions: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginPage()),
//                     );
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(15),
//                     child: Image.asset(
//                       'assets/images/home.png',
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//               iconTheme: const IconThemeData(
//                 color: Colors.white,
//                 //change your color here
//               ),
//             ),
//             body: ListView.builder(
//               itemCount: loanacc.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Container(
//                     width: size.width,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10.0),
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.3),
//                           spreadRadius: 1,
//                           blurRadius: 5,
//                           offset: const Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: size.width,
//                           alignment: Alignment.centerLeft,
//                           decoration: const BoxDecoration(
//                             color: Color(0xFF0057C2),
//                             borderRadius: BorderRadius.only(
//                                 topRight: Radius.circular(30.0)),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Flexible(
//                               child: Text(
//                                 loanacc[index].loanname.toString(),
//                                 style: const TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: ReadMoreText(
//                             loanacc[index].ltype_remark.toString() + " ",
//                             trimMode: TrimMode.Line,
//                             trimLines: 2,
//                             colorClickableText: Colors.pink,
//                             trimCollapsedText: 'Show more',
//                             trimExpandedText: 'Show less',
//                             style: TextStyle(fontSize: 16),
//                             moreStyle: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.pink),
//                             lessStyle: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.pink),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Visibility(
//                                 visible: true,
//                                 child: InkWell(
//                                   onTap: () async {
//                                     final List<ConnectivityResult>
//                                         connectivityResult =
//                                         await (Connectivity()
//                                             .checkConnectivity());

//                                     if (connectivityResult
//                                         .contains(ConnectivityResult.none)) {
//                                       showDialog(
//                                         context: context,
//                                         builder: (BuildContext context) {
//                                           return Builder(builder: (context) {
//                                             return MediaQuery(
//                                               data: MediaQuery.of(context)
//                                                   .copyWith(
//                                                       textScaler:
//                                                           const TextScaler
//                                                               .linear(1.1)),
//                                               child: AlertDialog(
//                                                 title: const Text(
//                                                   'Alert',
//                                                   style:
//                                                       TextStyle(fontSize: 16),
//                                                 ),
//                                                 content: const Text(
//                                                   'Please Check Your Internet Connection',
//                                                   style:
//                                                       TextStyle(fontSize: 16),
//                                                 ),
//                                                 actions: [
//                                                   TextButton(
//                                                     onPressed: () {
//                                                       Navigator.of(context)
//                                                           .pop();
//                                                     },
//                                                     child: const Text(
//                                                       'OK',
//                                                       style: TextStyle(
//                                                           fontSize: 16),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             );
//                                           });
//                                         },
//                                       );

//                                       return;
//                                     }
//                                   },
//                                   child: Container(
//                                     height: 50,
//                                     width: size.width * .8,
//                                     decoration: BoxDecoration(
//                                       color: const Color(0xFF0057C2),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         "Apply",
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ));
//     });
//   }
// }
