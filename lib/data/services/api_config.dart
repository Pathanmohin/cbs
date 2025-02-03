// lib/api/api_config.dart

import 'package:hpscb/config/config.dart';

class ApiConfig {
  static final String _baseUrl =
      "${ServerDetails.protocol}${ServerDetails.serverIP}${ServerDetails.port}/rest/AccountService";
  static final String _baseUrlBBPS =
      "${ServerDetails.protocol}${ServerDetails.serverIP}${ServerDetails.port}/rest";

  // Define your endpoints
  //static String get login => "$_baseUrl/login";
  // static String get fetchUsers => "$_baseUrl/users";
  // static String get fetchTransactions => "$_baseUrl/transactions";

// BaseURLs
  static String get loginauth => "$_baseUrl/userAuthenticatePost";
  static String get loginauthMPIN => "$_baseUrl/loginwithMPIN";

  // Login Page Banner API
  static String get banLogin => "$_baseUrl/getMobileBanner";
  static String eventShowBanner = "$_baseUrl/fetchfestivalEntry";

  static String get tipess => "$_baseUrl/fetchSafetytips";

  static String contactus =
      "https://netbanking.hpscb.com/rest/AccountService/contactUs";

// Activate User
  static String passwordchange = "$_baseUrl/passWordChangeUrl";
  static String passCon = "$_baseUrl/sendOTP";

// Dashboard API get Data

  static String fetchAccount = "$_baseUrl/fetchCustomerAccounts";

  static String ministatement = "$_baseUrl/getMiniStatement";

  static String minidetails = "$_baseUrl/";

// BBPS API

  static String getbilleroperator = "$_baseUrl/Getbilleroperator";

  static String getAccountBalance = "$_baseUrl/GetAccountBalance";
  static String UserFetchCreditCardDetails =
      "$_baseUrl/UserFetchCreditCardDetails";

// Payment BBPS
  static String fetchBill = "$_baseUrlBBPS/BBPSService/fetchbill";
  static String billpay = "$_baseUrlBBPS/BBPSService/Billpay";

  static String postpaidBillpay = "$_baseUrlBBPS/BBPSService/PostpaidBillpay";

// ele recharge

  static String billervalidate = "$_baseUrlBBPS/BBPSService/billervalidate";
  static String educationfetchbill =
      "$_baseUrlBBPS/BBPSService/educationfetchbill";

  static String billereducationvali =
      "$_baseUrlBBPS/BBPSService/billereducationvali";

  static String creditcardfetchbill =
      "$_baseUrlBBPS/BBPSService/creditcardfetchbill";

// Security

// Change Password

  static String changepassword = "$_baseUrl/passWordChangeMobile";

// Block Card

  static String blockcard = "$_baseUrl/atmDeactivateBySMS";

// genPIN

  static String genPinSendOTP = "$_baseUrl/sendOTP";
  static String genMPIN = "$_baseUrl/GenreateMPIN";

// Drawer
  static String profiledata = "$_baseUrl/ViewProfileMB";
  static String profileView = "$_baseUrl/ViewProfileMB";
  static String fetchSafetytips = "$_baseUrl/fetchSafetytips";

// FAQ

  static String faq = "$_baseUrl/Faq";

// Loan Deposite

  static String preclosureRd = "$_baseUrl/preclosureRd";

  static String preclosurefd = "$_baseUrl/preclosurefd";

  static String clsoefdrdetails = "$_baseUrl/clsoefdrdetails";

// Loan Against FD

  static String overdfd = "$_baseUrl/overdfd";
  static String odfdLoanApp = "$_baseUrl/odfdLoanApp";

  static String fetchFDScheme = "$_baseUrl/fetchFDScheme";

// Create FD RD

  static String getonlineintrestrate = "$_baseUrl/getonlineintrestrate";

  static String getFundTrfDebitAcc = "$_baseUrl/getFundTrfDebitAcc";

  static String fetchDataForFtr = "$_baseUrl/fetchDataForFtr";

  static String fundTransferwithinBank = "$_baseUrl/fundTransferwithinBank";

  static String sendOTP = "$_baseUrl/sendOTP";

  static String transectionRiciptDownload =
      "$_baseUrl/TransectionRiciptDownload";

  static String fetchbillvalidate =
      "$_baseUrlBBPS/BBPSService/fetchbillvalidate";

  static String creditcardRegister = "$_baseUrl/CreditcardRegister";

  static String lPGfetchbill = "$_baseUrlBBPS/BBPSService/LPGfetchbill";

  static String getLoanCertificate = "$_baseUrl/getLoanCertificate";

  static String getintrestCertificatedownload =
      "$_baseUrl/getintrestcertificatedownload";

  static String getDepositeCertificate = "$_baseUrl/getDepositeCertificate";

  static String downloadDepositeCertificate =
      "$_baseUrl/DownloadDepositeCertificate";

  static String chequeLostStopRequest = '$_baseUrl/chequeLostStopRequest';

  static String statusCheque = '$_baseUrl/statusCheque';

  static String issueChequeToAccNo = '$_baseUrl/issueChequeToAccNo';

  static String getrelationship = '$_baseUrl/getrelationship';

  static String getdistName = "$_baseUrl/getdistName";

  static String getStateName = "$_baseUrl/getStateName";

  static String newnomDetail = "$_baseUrl/newnomDetail";

  static String submission15GH = "$_baseUrl/submission15GH";

  static String passAccDetail = "$_baseUrl/passAccDetail";

  static String positivePayConfirmation = "$_baseUrl/positivePayConfirmation";

  static String getlienFDData = "$_baseUrl/getlienFDData";

  static String fddepositrecipt = "$_baseUrl/fddepositrecipt";

  static String rddepositrecipt = "$_baseUrl/RDdepositrecipt";

  static String getfdReceiptdownload = "$_baseUrl/getfdReceiptdownload";

  static String getFdseriescheck = "$_baseUrl/getFdseriescheck";

  static String sNomData = "$_baseUrl/sNomData";

  static String calculateFDintrest = "$_baseUrl/CalculateFDintrest";

  static String fetchsglcodebyschcode = "$_baseUrl/fetchsglcodebyschcode";

  static String createFD = "$_baseUrl/createFD";

  static String calculaterDintrest = "$_baseUrl/CalculateRdintrest";

  static String accDetails = "$_baseUrl/accDetails";

  static String fetchloantypes = "$_baseUrl/fetchloantypes";

  static String accOpeningDetails = "$_baseUrl/accOpeningDetails";

  static String fundTransferAddPayee = "$_baseUrl/fundTransferAddPayee";

  static String fetchIfscDetails = "$_baseUrl/fetchIfscDetails";

  static String fetchPayeeForConfirm = "$_baseUrl/fetchPayeeForConfirm";

  static String otpVerify = "$_baseUrl/otpVerify";

  static String rDinstallmentdetails = "$_baseUrl/RDinstallmentdetails";

  static String fetchPayeeIMPS = "$_baseUrl/fetchPayeeIMPS";
  static String fundTransferOtherBank = "$_baseUrl/fundTransferOtherBank";

  static String createRD = "$_baseUrl/CreateRD";

  static String fetchPayee = "$_baseUrl/fetchPayee";

  static String removePayee = "$_baseUrl/removePayee";

  static String aadharotpsend = "$_baseUrl/aadharotpsend";

  static String aadharotpverify = "$_baseUrl/aadharotpverify";

  static String getocupationMaster = "$_baseUrl/getocupationMaster";

  static String getBrnName = "$_baseUrl/getBrnName";

  static String unauthAccountgenebyMobile =
      "$_baseUrl/unauthAccountgenebyMobile";

  static String initiateKYC = "$_baseUrl/initiateKYC";

  static String getKYCUrl = "$_baseUrl/getKYCUrl";
}
