// import 'dart:convert';
// 
// import 'package:hpscb/data/models/ContactInfo.dart';
// import 'package:hpscb/presentation/view/BBPS/bbps.dart';
// import 'package:hpscb/presentation/view/appdrawer/drawer.dart';
// import 'package:hpscb/presentation/view/appdrawer/faq/faq.dart';
// import 'package:hpscb/presentation/view/appdrawer/profileview/profileView_share.dart';
// import 'package:hpscb/presentation/view/appdrawer/profileview/profileview.dart';
// import 'package:hpscb/presentation/view/appdrawer/profileview/safty_tips.dart';
// import 'package:hpscb/presentation/view/auth/activate/activateuser.dart';
// import 'package:hpscb/presentation/view/auth/contactus/contactus.dart';
// import 'package:hpscb/presentation/view/auth/login_view.dart';
// import 'package:hpscb/presentation/view/auth/mpin/mpin.dart';
// import 'package:hpscb/presentation/view/dashboard/depositeloan/close_fd_rd/closefdrd.dart';
// import 'package:hpscb/presentation/view/dashboard/depositeloan/close_fd_rd/closerd/closerrd.dart';
// import 'package:hpscb/presentation/view/dashboard/depositeloan/close_fd_rd/closerfd/closerfd.dart';
// import 'package:hpscb/presentation/view/dashboard/depositeloan/close_fd_rd/closerfd/finalpageclosefd/finalcloserfd.dart';
// import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/createfdrd.dart';
// import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fd/fd.dart';
// import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fd/nominee/addaddress/addaddress.dart';
// import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fd/nominee/ifage18/selfage.dart';
// import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fd/nominee/nominee.dart';
// import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fdintrate/fdintrestrate.dart';
// import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/rd/nominee/addaddress/rdaddaddress.dart';
// import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/rd/nominee/ifage18/rdselfage.dart';
// import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/rd/nominee/rdnominee.dart';
// import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/rd/rdcreate.dart';
// import 'package:hpscb/presentation/view/dashboard/depositeloan/loan_against/loanagainstfd.dart';
// import 'package:hpscb/presentation/view/dashboard/depositeloan/loan_against/loanfd/fdloanpage.dart';
// import 'package:hpscb/presentation/view/dashboard/depositeloan/loan_against/loanfd/finalpagefdloan/finalpagefdloan.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/Boardband/Boardbandbill.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/Boardband/sucessbaordband.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/CableTv/cabletv.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/CableTv/fatchBillCable.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/CableTv/successfullyscreen.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/DTH/DTHRecharge.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/DTH/SuccessfulltyScreen.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/EducationBill/BillPaymennt.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/EducationBill/Education.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/ElectricityRecharge/Electricity.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/ElectricityRecharge/Fetchbill.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/ElectricityRecharge/Successfulltelectricity.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/FastTagRecharge/Successfully.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/FastTagRecharge/fasttage.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/LPG_Booking/LPG.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/LPG_Booking/LPG_BillPay.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/LPG_Booking/LPG_FetchBill.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/MobilePospaidRecharge/FatchBill.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/MobilePospaidRecharge/Successfullytransation.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/MobilePospaidRecharge/mobilepostpaid.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/MobileRecharge/Successfullytransation.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/MobileRecharge/mobilerecharge.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/PIPED_Gas/PipedGas.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/PIPED_Gas/Piped_GasPAY.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/PIPED_Gas/Piped_GasSummary.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/Water/WaterFatchBill.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/Water/WaterRecharge.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/Water/WaterSuccessfullytransation.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/creditcard/CreditCard.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/creditcard/FetchBillCreditCard.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/creditcard/ResigesterCreditCard.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/creditcard/SucessScreenCredit.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/banktransfer/ToOtherBank/confirmdeatilstoother.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/banktransfer/ToOtherBank/otpverfication.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/banktransfer/ToOtherBank/toothertransfer.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/banktransfer/WithInBank/withinbanktransfer.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/banktransfer/selftransfer/selfaccountshow.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/quicktransfer.dart';
// import 'package:hpscb/presentation/view/dashboard/payments/manage_beneficiary/addPayee/addpayee.dart';
// import 'package:hpscb/presentation/view/dashboard/security/blockcard/blockcard.dart';
// import 'package:hpscb/presentation/view/dashboard/security/changepassword/changepassword.dart';
// import 'package:hpscb/presentation/view/dashboard/security/generatempin/Generatempin.dart';
// import 'package:hpscb/presentation/view/dashboard/security/generatempin/OtpVerfication.dart';
// import 'package:hpscb/presentation/view/error/error.dart';
// import 'package:hpscb/presentation/view/home/dashboard.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/myaccount/accountsummary/accsummary.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/myaccount/myaccount.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/myaccount/sv&rdaccount/detailedpage/detaile.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/myaccount/sv&rdaccount/detailedpage/finalstatemnet/finalstatemnt.dart';
// import 'package:hpscb/presentation/view/dashboard/instapayment/myaccount/sv&rdaccount/svaccount.dart';
// import 'package:hpscb/presentation/view/more/15H/g_15_h.dart';
// import 'package:hpscb/presentation/view/more/AddNominee/Addnominee.dart';
// import 'package:hpscb/presentation/view/more/AddNominee/Address.dart';
// import 'package:hpscb/presentation/view/more/ChequeService/ChequeBookRequest/ChequeBookRequest.dart';
// import 'package:hpscb/presentation/view/more/ChequeService/ChequeBookRequest/SuccessfullyScreen.dart';
// import 'package:hpscb/presentation/view/more/ChequeService/ChequeInquiry/ChequeInquiry.dart';
// import 'package:hpscb/presentation/view/more/ChequeService/ChequeInquiry/SuccessScreen.dart';
// import 'package:hpscb/presentation/view/more/ChequeService/Chequemenu.dart';
// import 'package:hpscb/presentation/view/more/ChequeService/StopCheque/StopChequeBook.dart';
// import 'package:hpscb/presentation/view/more/ChequeService/StopCheque/Successfullyscreen.dart';
// import 'package:hpscb/presentation/view/more/certificates/certificates.dart';
// import 'package:hpscb/presentation/view/more/certificates/depositcertificates/depositcertificates.dart';
// import 'package:hpscb/presentation/view/more/certificates/depositcertificates/depositfinal/depositefinal.dart';
// import 'package:hpscb/presentation/view/more/certificates/loancertificates/loancertificates.dart';
// import 'package:hpscb/presentation/view/more/certificates/loancertificates/loanfinalpage/loanfinal.dart';
// import 'package:hpscb/presentation/view/more/fd_interest/fdinterest.dart';
// import 'package:hpscb/presentation/view/more/fdliendata/fdliendata.dart';
// import 'package:hpscb/presentation/view/more/fdrdreciptprint/fdrfview.dart';
// import 'package:hpscb/presentation/view/more/fdrdreciptprint/fdview/fdView.dart';
// import 'package:hpscb/presentation/view/more/fdrdreciptprint/rdview/rdview.dart';
// import 'package:hpscb/presentation/view/more/moreoptions.dart';
// import 'package:hpscb/presentation/view/more/positivepay/positivepay.dart';
// import 'package:hpscb/presentation/view/splash/splash.dart';

// class AppRouter {
//   static final GoRouter router = GoRouter(
//     initialLocation: '/splash',
//     routes: [
// // Default page...............
//       GoRoute(
//         path: '/splash',
//         builder: (context, state) => const SplashScreen(),
//       ),

//       GoRoute(
//         path: '/login',
//         builder: (context, state) => const LoginView(),
//       ),

//       GoRoute(
//         path: '/contactus',
//         builder: (context, state) {
//           // Decode the JSON data passed as a parameter
//           final contactJson = jsonDecode(state.extra as String);
//           final contactInfo = ContactInfo.fromJson(contactJson);
//           return ContactUs(contactInfo: contactInfo);
//         },
//       ),

//       GoRoute(
//           path: "/activateuser",
//           builder: (context, state) => const ActivateUser()),

//       GoRoute(path: "/mpin", builder: (context, state) => const Mpin()),

//       GoRoute(
//         path: '/dashboard',
//         builder: (context, state) => const Dashboard(),
//       ),

//       GoRoute(path: '/drawer', builder: (context, state) => DrawerView()),

//       GoRoute(path: '/bbps', builder: (context, state) => const BBPSConnect()),

//       //More Services .............................................................

//       GoRoute(
//         path: '/more',
//         builder: (context, state) => const MoreOptions(),
//       ),

//       GoRoute(
//         path: '/fdinterestrate',
//         builder: (context, state) => const FDInterestRate(),
//       ),

//       // Instapayment -------------------------

//       // My account

//       GoRoute(
//         path: "/myaccount",
//         builder: (context, state) => const MyAccounts(),
//       ),

//       GoRoute(
//         path: '/summaryaccount',
//         builder: (context, state) => const AccSummary(),
//       ),

//       GoRoute(
//           path: '/ministatment',
//           builder: (context, state) => const SVAccount()),

//       GoRoute(
//           path: '/minidetails',
//           builder: (context, state) => const DetailsPage()),

//       GoRoute(
//           path: '/finalsatement',
//           builder: (context, state) => const FinalStatement()),

//       GoRoute(
//         path: '/mobilerecharge',
//         builder: (context, state) => const Recharge(),
//       ),

//       GoRoute(
//         path: '/successfullyRecharge',
//         builder: (context, state) => const Successfully(),
//       ),

//       GoRoute(path: '/PostPaid', builder: (context, state) => const PostPaid()),

//       GoRoute(
//           path: '/fatchbill', builder: (context, state) => const FatchBill()),

//       GoRoute(
//           path: '/successfullyPostpaid',
//           builder: (context, state) => const SuccessfullyPostpaid()),

// // Security pages

// // Change Password
//       GoRoute(
//           path: '/changePassword',
//           builder: (context, state) => const ChangePassword()),

// // Block Card

//       GoRoute(
//           path: '/atmaeactivation',
//           builder: (context, state) => const AtmDeactivation()),

// // Gem MPIN

//       GoRoute(
//           path: '/MpinGenerate',
//           builder: (context, state) => const MpinGenerate()),

//       GoRoute(
//           path: '/OTPVerfication',
//           builder: (context, state) => const OTPVerfication()),

// // Profile View

//       GoRoute(
//           path: '/profileView',
//           builder: (context, state) => const ProfileView()),

//       GoRoute(
//           path: '/AccountDetailsScreen',
//           builder: (context, state) => const AccountDetailsScreen()),

//       GoRoute(
//           path: '/SafetyTipsScreenView',
//           builder: (context, state) => const SafetyTipsScreenView()),

//       GoRoute(path: '/FAQ', builder: (context, state) => const FAQ()),

// // Close FD RD

//       GoRoute(
//           path: '/closerfdrd', builder: (context, state) => const CloserFDRD()),

//       GoRoute(path: '/closerrd', builder: (context, state) => const CloserRD()),

//       GoRoute(path: '/closerfd', builder: (context, state) => const CloserFD()),

//       GoRoute(
//           path: '/closerfdfinal',
//           builder: (context, state) => const FinalCloserFD()),

// // Loan Against FD

//       GoRoute(
//           path: '/loanagainstFD',
//           builder: (context, state) => const LoanAgainstFD()),
//       GoRoute(
//           path: '/loanFDPage', builder: (context, state) => const LoanFDPage()),

//       GoRoute(
//           path: '/fdloanFinalPage',
//           builder: (context, state) => const FDLoanFinalPage()),

// // Create FD RD

//       GoRoute(
//           path: '/createfDRD', builder: (context, state) => const CreateFDRD()),


// // FD Create -------------------------------------------
//       GoRoute(
//         path: '/fdcreate',
//         builder: (context, state) => const FDCreate(),
//       ),

// GoRoute(path: '/NomineeFD',
// builder: (context, state) => const NomineeFD()),

// GoRoute(path: '/ADDADDRESS',
// builder: (context,state) => const ADDADDRESS()),

// GoRoute(path: '/SelfAgePage',
// builder: (context, state) => const SelfAgePage(),),


//       GoRoute(path: '/rdCreate', builder: (context, state) => const RDCreate()),


      

//       GoRoute(
//           path: '/fdIntersetRate',
//           builder: (context, state) => const FDIntersetRate()),

// // Quick Transfer

//       GoRoute(
//           path: '/QuickTransfer',
//           builder: (context, state) => const QuickTransfer()),

//       GoRoute(
//         path: '/WithInbANK',
//         builder: (context, state) => const WithInbANK(),
//       ),

//       GoRoute(
//         path: '/ConfirmDeatilsToOther',
//         builder: (context, state) => const ConfirmDeatilsToOther(),
//       ),

//       GoRoute(
//         path: '/ToOtherBank',
//         builder: (context, state) => const ToOtherBank(),
//       ),

//       GoRoute(
//         path: '/SelfAccountShow',
//         builder: (context, state) => const SelfAccountShow(),
//       ),

//       GoRoute(
//         path: '/OtpVerfication',
//         builder: (context, state) => const OtpVerfication(),
//       ),

// // BBPS Ele Rec

//       GoRoute(
//           path: '/Electricity',
//           builder: (context, state) => const Electricity()),

//       GoRoute(
//           path: '/FatchBillElectricity',
//           builder: (context, state) => const FatchBillElectricity()),

//       GoRoute(
//           path: '/SuccessfullyElectricity',
//           builder: (context, state) => const SuccessfullyElectricity()),

//       GoRoute(
//           path: '/DTHRecharhemobile',
//           builder: (context, state) => const DTHRecharhemobile()),

//       GoRoute(
//           path: '/DTHSuccessfully',
//           builder: (context, state) => const DTHSuccessfully()),

//       GoRoute(
//           path: '/FatchBillWater',
//           builder: (context, state) => const FatchBillWater()),

//       GoRoute(
//           path: '/WaterSuccessfully',
//           builder: (context, state) => const WaterSuccessfully()),

//       GoRoute(
//           path: '/WaterRecharge',
//           builder: (context, state) => const WaterRecharge()),

//       GoRoute(
//           path: '/SuccessfullyFastag',
//           builder: (context, sate) => const SuccessfullyFastag()),

//       GoRoute(
//         path: '/FastTag',
//         builder: (context, state) => const FastTag(),
//       ),

//       GoRoute(
//           path: '/Boradbandbill',
//           builder: (context, state) => const Boradbandbill()),

//       GoRoute(
//           path: '/Successfullyboardband',
//           builder: (context, state) => const Successfullyboardband()),

//       GoRoute(
//           path: '/CreditCard', builder: (context, state) => const CreditCard()),

//       GoRoute(
//           path: '/CreditcardFatchBill',
//           builder: (context, state) => const CreditcardFatchBill()),

//       GoRoute(
//           path: '/SuccessfullyCredit',
//           builder: (context, state) => const SuccessfullyCredit()),

//       GoRoute(
//           path: '/NewCreditCard',
//           builder: (context, state) => const NewCreditCard()),

//       GoRoute(path: '/CABLETV', builder: (context, state) => const CABLETV()),

//       GoRoute(
//           path: '/CableTVFatchBill',
//           builder: (context, state) => const CableTVFatchBill()),

//       GoRoute(
//           path: '/SuccessfullyCabletv',
//           builder: (context, state) => const SuccessfullyCabletv()),

//       GoRoute(path: '/LPG', builder: (context, state) => const LPG()),

//       GoRoute(
//           path: '/LPG_Fatch', builder: (context, state) => const LPG_Fatch()),

//       GoRoute(
//           path: '/SuccessfullyLPG',
//           builder: (context, state) => const SuccessfullyLPG()),

//       GoRoute(
//           path: '/pipedGass', builder: (context, state) => const pipedGass()),

//       GoRoute(
//           path: '/PipedGas_Fatch',
//           builder: (context, state) => const PipedGas_Fatch()),

//       GoRoute(
//         path: '/pipedGasSumaary',
//         builder: (context, state) => const pipedGasSumaary(),
//       ),

//       GoRoute(
//         path: '/Education',
//         builder: (context, state) => const Education(),
//       ),

//       GoRoute(
//         path: '/Educationbillpayment',
//         builder: (context, state) => const Educationbillpayment(),
//       ),


// GoRoute(path: '/Certificates',
// builder: (context,state) => const Certificates()),

// GoRoute(path: '/LoanCertificate',
// builder: (context,state) => const LoanCertificate()),


//       GoRoute(path: '/LoanFinal',
//       builder: (context, state) => const LoanFinal(),),


// GoRoute(path: '/DepositCertificate',
// builder: (context, state) =>  const DepositCertificate(),),

//       GoRoute(path: '/DepositeFinal',
//       builder: (context,state) => const DepositeFinal()),



// GoRoute(path: '/Chequemenu',
// builder: (context,state) => const Chequemenu()),

//       GoRoute(path: '/ChequeBookRequest',
//       builder: (context, state) => const ChequeBookRequest(),),

//       GoRoute(path: '/ChequeBookinquiry',
//       builder:  (context,state) => const ChequeBookinquiry()),

//       GoRoute(path: '/ChequeBookstop',
//       builder: (context,state) => const ChequeBookstop()),


//       GoRoute(path: '/chequestopsuccess',
//       builder: (context,state)=> const chequestopsuccess()),

//       GoRoute(path: "/chequeinquirysuccess",
//       builder: (context,state) => const chequeinquirysuccess()),

//       GoRoute(path: '/successfullyChequeBook',
//       builder: (context,state) => const successfullyChequeBook()),


//       GoRoute(path: '/AddNominee',
//       builder: (context,state) => const AddNominee()),

//       GoRoute(path: '/Addresspage',
//       builder:  (context,state) => const Addresspage()),

//       // 15G / 15H

//       GoRoute(path: '/G15H15',
//       builder: (context,state) => const G15H15()),

//       // Positive pay

//       GoRoute(path: '/PositivePay',
//       builder: (context,state) => const PositivePay()),

//       GoRoute(path: '/FdLienData',
//       builder: (context, state) => const FdLienData(),),


//       GoRoute(path: '/RdView',
//       builder: (context,state) => const RdView()),

//       GoRoute(path: '/FDView',
//       builder: (context, state) => const FDView()),

//       GoRoute(path: '/FDRDView',
//       builder:  (context,state) => const FDRDView()),


//       GoRoute(path: '/AddPayee',
//        builder: (context,state) => const AddPayee()),

//        GoRoute(path: '/NomineeRD',
//        builder: (context,state) => const NomineeRD()),

//        GoRoute(path: '/SelfRDAgePage',
//        builder: (context, state) => const SelfRDAgePage()),

//        GoRoute(path: '/ADDADDRESSRD',
//        builder: (context, state) => const ADDADDRESSRD(),),

//        GoRoute(path: '/CreateFDRD',
//        builder: (context,state) => const CreateFDRD()),

//       // Home Route
//       // GoRoute(
//       //   name: 'Home',
//       //   path: '/',
//       //   builder: (context, state) => const MyHomePage(),
//       // ),

//       // GoRoute(
//       //   path: '/Home',
//       //   builder: (context, state) => const MyHomePage(),
//       // ),

//       // Details Route with an example of dynamic route parameters
//       // GoRoute(
//       //   path: '/details/:id',
//       //   builder: (context, state) {
//       //     final id = state.params['id']; // Retrieving the ID from the URL
//       //     return DetailsPage(id: id!);
//       //   },
//       // ),
//     ],

//     // Optional: Redirect or error handling
//     errorBuilder: (context, state) => const ErrorPage(),
//   );
// }
