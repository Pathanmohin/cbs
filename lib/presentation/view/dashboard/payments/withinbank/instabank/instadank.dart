// ignore_for_file: non_constant_identifier_names, unused_local_variable, use_build_context_synchronously, prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/config/constants.dart';
import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/models/withinbankquick.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/banktransfer/selftransfer/selfaccountshow.dart';
import 'package:hpscb/presentation/view/dashboard/payments/withinbank/withinbank.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String customeraccountnumber = "";
String customermobilenumber = "";

class IntraFund extends StatefulWidget {
  const IntraFund({super.key});

  @override
  State<StatefulWidget> createState() => IntrafundTransfer();
}

class IntrafundTransfer extends State<IntraFund> {
  @override
  void initState() {
    FetchSelfAccounts();
    super.initState();
  }

  String Message = "";
  String Alert = "";
  String AccountholderName = "";
  String Availbalelabel = "";
  String ACCNUMBER = "";

  AccountFetchModel? selectedAccount;

  List<Simple> fromAccount = [
    Simple(
      countryId: '1',
      label: 'Account Number',
     
    ),
    Simple(
      countryId: '2',
      label: 'Mobile Number',
      
    ),
    // Add more accounts as needed
  ];
  String amount = "";
  String fromvalue = "";

  var toSelectedValue;
  var fromSelectedValue;

  List<dynamic> countries = [];
  String? countryId;

  final List<AccountFetchModel> toAccountList = AppListData.Allacc;

  static List<AccountFetchModel> accounts_list_for_transfer_new =
      <AccountFetchModel>[];

  List<AccountFetchModel> fromAccountList = <AccountFetchModel>[];
  bool showMobileField = false;
  bool showMobile = false;
  bool balance = false;
  bool otpvisible = false;

  final txtName = TextEditingController();
  final txtBeneficiry = TextEditingController();
  final txtOTP = TextEditingController();

  final txtAmount = TextEditingController();

  final txtRemark = TextEditingController();
  final txtMobileNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Intra Bank",
              style: TextStyle(color: AppColors.onPrimary, fontSize: 16.sp),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WithIn()),
                );

                //   context.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
            ),
            backgroundColor: AppColors.appBlueC,
actions: [

              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Dashboard()));

                    //  context.pop(context);
                  },
                  child: Image.asset(
                    "assets/images/dashlogo.png",
                    width: 24.sp,
                    height: 24.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Container(
                width: size.width,
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
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        "From Account",
                        style: TextStyle(
                            color: Color(0xFF0057C2),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     margin: EdgeInsets.only(top: 5),
                    //     padding: EdgeInsets.symmetric(horizontal: 10),
                    //     height: 50,
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(8),
                    //       border: Border.all(color: Colors.grey),
                    //     ),
                    //     child: DropdownButtonHideUnderline(
                    //       child: DropdownButton<String>(
                    //         value: fromSelectedValue,
                    //         hint: Text(
                    //           'From Account',
                    //           style: TextStyle(
                    //             color: Color(0xFF898989),
                    //             fontSize: 15,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //         icon: Icon(Icons.arrow_drop_down),
                    //         isExpanded: true,
                    //         items: fromAccountList.map((AccountFetchModel obj) {
                    //           return DropdownMenuItem<String>(
                    //             value: obj.accountType,
                    //             child: Text(
                    //               "${obj.textValue}",
                    //               style: TextStyle(
                    //                 color: Colors.black,
                    //                 fontSize: 15,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           );
                    //         }).toList(),
                    //         onChanged: (newValue) {
                    //           setState(() {
                    //             fromSelectedValue = newValue!;
                    //           });
                    //           // Call your method here, similar to SelectedIndexChanged
                    //           //onFromAccount(newValue);

                    //           // onToAccount(newValue!);

                    //            onToAccount(fromAccountList.firstWhere(
                    //               (account) => account.accountType == newValue));
                    //         },
                    //       ),
                    //     ),
                    //   ),
                    // ),

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
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<AccountFetchModel>(
                            dropdownColor: AppColors.onPrimary,
                            value: fromSelectedValue,
                            hint: const Text(
                              'From Account',
                              style: TextStyle(
                                color: Color(0xFF898989),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            icon: const Icon(Icons.arrow_drop_down),
                            isExpanded: true,
                            items: fromAccountList.map((AccountFetchModel obj) {
                              return DropdownMenuItem<AccountFetchModel>(
                                value: obj,
                                child: Builder(builder: (context) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                        textScaler:
                                            const TextScaler.linear(1.1)),
                                    child: Text(
                                      "${obj.textValue}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                fromSelectedValue = newValue!;
                              });

                              ACCNUMBER = newValue!.textValue.toString();
                              // Call your method here, similar to SelectedIndexChanged
                              //onFromAccount(newValue);

                              //onToAccount(newValue!);
                              String accNo = newValue.textValue.toString();
                              String accountTy =
                                  newValue.accountType.toString();

                              onToAccount(accNo, accountTy);
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: balance,
                            child: const Text(
                              "Available Balance",
                              style: TextStyle(
                                  color: Color(0xFF0057C2),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Visibility(
                            visible: balance,
                            child: Text(
                              "\u{20B9} $amount",
                              style: const TextStyle(
                                  color: Color(0xFF0057C2),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        "Payment Using",
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
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: AppColors.onPrimary,
                            value: toSelectedValue,
                            hint: const Text(
                              'Payment Using',
                              style: TextStyle(
                                color: Color(0xFF898989),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            icon: const Icon(Icons.arrow_drop_down),
                            isExpanded: true,
                            items: fromAccount.map((Simple obj) {
                              return DropdownMenuItem<String>(
                                value: obj.label,
                                child: Builder(builder: (context) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                        textScaler:
                                            const TextScaler.linear(1.1)),
                                    child: Text(
                                      obj.label,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                toSelectedValue = newValue!;
                              });

                              if (toSelectedValue == "Mobile Number") {
                                setState(() {
                                  showMobileField = true;
                                  showMobile = false;

                                  txtName.text = "";
                                  txtBeneficiry.text = "";
                                  txtOTP.text = "";

                                  txtAmount.text = "";

                                  txtRemark.text = "";
                                  txtMobileNumber.text = "";
                                });
                              } else {
                                setState(() {
                                  showMobile = true;
                                  showMobileField = false;
                                  txtName.text = "";
                                  txtBeneficiry.text = "";
                                  txtOTP.text = "";

                                  txtAmount.text = "";

                                  txtRemark.text = "";
                                  txtMobileNumber.text = "";
                                });
                              }
                              // Call your method here, similar to SelectedIndexChanged
                              //onFromAccount(newValue);
                              fromSelectedValue(newValue);
                              // onToAccount(newValue!);
                            },
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: showMobileField,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "Mobile Number",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: showMobileField,
                      child: Padding(
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
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10)
                            ],
                            controller: txtMobileNumber,
                            decoration: const InputDecoration(
                              hintText: "Enter Mobile Number",
                            ),
                            onFieldSubmitted: (value) {
                              FindName(value);
                            },
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: showMobile,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "Beneficiry Details",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: showMobile,
                      child: Padding(
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
                            controller: txtBeneficiry,
                            decoration: const InputDecoration(
                              hintText: " Enter Beneficiry Details",
                            ),
                            onFieldSubmitted: (value) {
                              FindName(value);
                            },
                            onTapOutside: (value) {
                              FindName(txtBeneficiry.text);
                            },
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        "Name",
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
                          readOnly: true,
                          controller: txtName,
                          decoration: const InputDecoration(
                            hintText: "Enter Name",
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        "Amount",
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
                          keyboardType: TextInputType.number,
                          controller: txtAmount,
                          decoration: const InputDecoration(
                            hintText: "Enter Amount",
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        "Remark",
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
                          controller: txtRemark,
                          decoration: const InputDecoration(
                            hintText: "Enter Remark",
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

                        if (fromSelectedValue == null || fromSelectedValue == "") {
                          Message = "Please Select Account Number";
                        await  Dialgbox(Message);
                          return;
                        } else if (toSelectedValue != null || toSelectedValue != "") {

                          if (toSelectedValue == "" || toSelectedValue == null) {
                            Message = "Please Select Payment Using";
                   await  Dialgbox(Message);
                          return;
                          }

                          if (toSelectedValue == "Mobile Number") {

                            if (txtMobileNumber.text   == "") {

                               Message = "Please Enter Mobile Number"; 
                             await Dialgbox(Message);
                              return;
                            }
                            else if (txtMobileNumber.text.length<10){
                                Message = "Please Enter 10 digit Mobile Number";
                                Dialgbox(Message);
                                return;
                              }

                            


                          } else if (toSelectedValue == "Account Number") {

                            if (txtBeneficiry.text == "") {

                              Message = "Please Enter Beneficiary Account Number";
                                await  Dialgbox(Message);
                              return;

                            }

                          }


                        } 
                         if (txtName.text == "") {
                          Message = " Please Enter Name";
                        await  Dialgbox(Message);
                          return;
                        } 
                         if (txtAmount.text == ""||txtAmount.text.toString()==null) {
                          Message = "Please Enter Amount";
                        await  Dialgbox(Message);
                          return;
                        } 
                         if (txtRemark.text == ""||txtRemark.text == null) {
                          Message = "Please Enter Remark";
                        await  Dialgbox(Message);
                          return;
                        }

                        GetOTP();

                      },


                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0057C2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "SEND OTP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: otpvisible,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "OTP",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: otpvisible,
                      child: Padding(
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
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6)
                            ],
                            keyboardType: TextInputType.number,
                            controller: txtOTP,
                           
                            decoration: const InputDecoration(
                              hintText: "Enter OTP",
                            ),
                          ),
                        ),
                      ),
                    ),


                    Visibility(
                      visible: otpvisible,
                      child: InkWell(
                        onTap: () async {
                          bool val = await Utils.netWorkCheck(context);

                          if (val == false) {
                            return;
                          }

                          // if (fromSelectedValue == null ||
                          //     fromSelectedValue == "") {
                          //   Message = "Please Select Account Number";
                          //   Dialgbox(Message);
                          //   return;
                          // } 
                          // else if (toSelectedValue != null ||
                          //     toSelectedValue != "") {

                          //       if(toSelectedValue == "" || toSelectedValue == null){
                          //         Message = "Please Select Payment Using";
                          //        await Dialgbox(Message);
                          //         return;

                          //       }

                          //   if (toSelectedValue == "Mobile Number" ) {
                          //     if (txtMobileNumber.text   == "") {
                          //       Message =  "Please Enter Mobile Number"
                          //           ;
                          //       Dialgbox(Message);
                          //       return;
                          //     }

                          //     else if (txtMobileNumber.text.length<10){
                          //       Message = "Please Enter 10 digit Mobile Number";
                          //       Dialgbox(Message);
                          //       return;
                          //     }
                          //   } else if (toSelectedValue == "Account Number") {
                          //     if (txtBeneficiry.text == "") {
                          //       Message = "Please Enter Beneficiary Account Number";
                          //       Dialgbox(Message);
                          //       return;
                          //     }
                          //   }


                          // }  
                            if (txtOTP.text == ""||txtOTP.text ==null) {
                            Message = "Please Enter OTP";
                            Dialgbox(Message);
                            return;
                          }
                          
                           if(txtOTP.text.length < 6){
                            Message = "Please Enter 6 digit OTP";
                            Dialgbox(Message);
                            return;

                          }
                          FinalProceed();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0057C2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "PROCEED",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  void onFromAccount(String item) {
    if (kDebugMode) {
      print('Selected value: $item');
    }
  }

  void onToAccount(String account, String accountTy) {
    setState(() {
      if (accountTy == "CC Account") {
        Availbalelabel = "Available Limit";
      } else {
        Availbalelabel = "Available Balance";
      }
      OnGeAvailableBalance(account);
      balance = true;
      // Update balance and amount based on the selected account
    });

    // OnGeAvailableBalance(value);
    // balance = true;

    // setState(() {
    //   fromvalue = value;
    // });
  }

   Dialgbox(String MESSAGE) async{
  await  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Builder(builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.1)),
            child: AlertDialog(
              backgroundColor: AppColors.onPrimary,
              title: const Text(
                'Alert',
                style: TextStyle(fontSize: 18),
              ),
              content: Text(
                MESSAGE,
                style: const TextStyle(fontSize: 18),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

// API Code............................................................

  Future<void> FetchSelfAccounts() async {
    //String? deviceId = await PlatformDeviceId.getDeviceId;

// Password Ency.

    // String md5Hash = Crypt().generateMd5(password);

    // API endpoint URL

    // String apiUrl = "rest/AccountService/getFundTrfDebitAcc";

    String apiUrl = ApiConfig.getFundTrfDebitAcc;

    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');
    //       String branchCode = context.read<SessionProvider>().get('branchCode');
    String customerId = context.read<SessionProvider>().get('customerId');

    SelfFromAccountModel userInput = SelfFromAccountModel(
      custid: customerId,
    );

    String jsonString = jsonEncode(userInput.toJson());

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

    try {
      // Make POST request
      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      // Check if request was successful
      if (response.statusCode == 200) {
        var data = AESencryption.decryptString(response.body, ibUsrKid);

        // print(data);

        var js = jsonDecode(data);

        List<dynamic> jsonResponse = jsonDecode(data);

        //       List<AccountFetchModel> accounts =
        //           jsonResponse.map((account) => AccountFetchModel.fromJson(account)).toList();

// Initialize lists of AccountFetchModel
        var accounts_list = <AccountFetchModel>[]; // all
        var accounts_list_for_fdr = <AccountFetchModel>[]; // all
        var accounts_list_for_transfer = <AccountFetchModel>[]; // s a c
        var accounts_list_for_transfer_to = <AccountFetchModel>[]; // s a c d t
        var accounts_list_for = <AccountFetchModel>[]; // s a c d t
        var accounts_list_for_loan = <AccountFetchModel>[]; // s a c d t
        var accounts_list_for_sav = <AccountFetchModel>[]; // s a c d t
        var accounts_list_for_fd = <AccountFetchModel>[]; // s a c d t
        var accounts_list_for_fd_close = <AccountFetchModel>[]; // s a c d t
        var accounts_list_for_rd_close = <AccountFetchModel>[]; // s a c d t
        var accounts_list_for_rd = <AccountFetchModel>[]; // s a c d t
        var accounts_list_for_SavCA = <AccountFetchModel>[]; // s a c d t
        var accounts_list_for_SACACC = <AccountFetchModel>[]; // s a c d t
        var accounts_list_for_INtraFund = <AccountFetchModel>[]; //s a c d t

        int all = 0;
        int from = 0;
        int to = 0;
        int Allacc = 0;
        int Accloan = 0;
        int Sav = 0;
        int fd = 0;
        int rd = 0;
        int SavCA = 0;
        int intrafund = 0;

        for (var config in jsonResponse) {
          if (config["accountType"] == "S") {
            //var test[] = new AccountFetchModel();

            AccountFetchModel vObject = AccountFetchModel();

            vObject.textValue = config["accountNo"].toString().trim();
            vObject.dataValue = config["acckid"].toString().trim();
            vObject.customerName = config["customerName"].toString().trim();
            vObject.actEname = config["actEname"].toString().trim();
            vObject.accountType = "Saving Account";

            vObject.availbalance = config["clearBalance"].toString().trim();
            vObject.brancode = config["brancode"].toString().trim();
            vObject.brnEname = config["brnname"].toString().trim();

            accounts_list.insert(all, vObject);
            accounts_list_for_transfer.insert(from, vObject);
            accounts_list_for_transfer_new.insert(from, vObject);

            accounts_list_for_transfer_to.insert(to, vObject);
            accounts_list_for.insert(Allacc, vObject);
            accounts_list_for_sav.insert(Sav, vObject);
            accounts_list_for_SavCA.insert(SavCA, vObject);

            accounts_list_for_INtraFund.insert(intrafund, vObject);

            all = all + 1;
            from = from + 1;
            to = to + 1;
            Allacc = Allacc + 1;
            Sav = Sav + 1;
            SavCA = SavCA + 1;
            intrafund = intrafund + 1;
          } else if (config["accountType"] == "A") {
            //var test[] = new AccountFetchModel();

            AccountFetchModel vObject = AccountFetchModel();

            vObject.textValue = config["accountNo"].toString().trim();
            vObject.dataValue = config["acckid"].toString().trim();
            vObject.customerName = config["customerName"].toString().trim();
            vObject.actEname = config["actEname"].toString().trim();
            vObject.accountType = "Current Account";
            vObject.availbalance = config["clearBalance"].toString().trim();
            vObject.brancode = config["brancode"].toString().trim();
            vObject.brnEname = config["brnname"].toString().trim();
            accounts_list.insert(all, vObject);
            accounts_list_for_transfer.insert(from, vObject);
            accounts_list_for_transfer_new.insert(from, vObject);
            accounts_list_for_transfer_to.insert(to, vObject);
            accounts_list_for.insert(Allacc, vObject);
            accounts_list_for_SavCA.insert(SavCA, vObject);
            accounts_list_for_INtraFund.insert(intrafund, vObject);

            all = all + 1;
            from = from + 1;
            to = to + 1;
            Allacc = Allacc + 1;
            SavCA = SavCA + 1;
            intrafund = intrafund + 1;
          } else if (config["accountType"] == "C") {
            //var test[] = new AccountFetchModel();

            AccountFetchModel vObject = AccountFetchModel();

            vObject.textValue = config["accountNo"].toString().trim();
            vObject.dataValue = config["acckid"].toString().trim();
            vObject.customerName = config["customerName"].toString().trim();
            vObject.actEname = config["actEname"].toString().trim();
            vObject.accountType = "CC Account";
            vObject.availbalance = config["clearBalance"].toString().trim();
            vObject.brancode = config["brancode"].toString().trim();
            vObject.brnEname = config["brnname"].toString().trim();
            accounts_list.insert(all, vObject);
            accounts_list_for_transfer.insert(from, vObject);
            accounts_list_for_transfer_new.insert(from, vObject);
            accounts_list_for_transfer_to.insert(to, vObject);
            accounts_list_for.insert(
                Allacc, vObject); // for transfer: in to Account List
            accounts_list_for_SavCA.insert(SavCA, vObject);
            accounts_list_for_INtraFund.insert(intrafund, vObject);

            all = all + 1;
            from = from + 1;
            to = to + 1;
            Allacc = Allacc + 1;
            SavCA = SavCA + 1;
            intrafund = intrafund + 1;
          } else if (config["accountType"] == "F") {
            //var test[] = new AccountFetchModel();

            AccountFetchModel vObject = AccountFetchModel();

            vObject.textValue = config["accountNo"];
            vObject.dataValue = config["acckid"];
            vObject.customerName = config["customerName"];
            vObject.actEname = config["actEname"];
            vObject.accountType = "Fixed Deposit Account";
            vObject.availbalance = config["clearBalance"];
            vObject.brancode = config["brancode"];
            vObject.brnEname = config["brnname"];
            accounts_list.insert(all, vObject);
            //  accounts_list_for.Insert(Allacc, vObject);
            accounts_list_for_fd.insert(fd, vObject);
            all = all + 1;
            //  Allacc = Allacc + 1;
            fd = fd + 1;
          } else if (config["accountType"] == "E") {
            //var test[] = new AccountFetchModel();

            AccountFetchModel vObject = AccountFetchModel();

            vObject.textValue = config["accountNo"];
            vObject.dataValue = config["acckid"];
            vObject.customerName = config["customerName"];
            vObject.actEname = config["actEname"];
            vObject.accountType = "RD Account";
            vObject.availbalance = config["clearBalance"];
            vObject.brancode = config["brancode"];
            vObject.brnEname = config["brnname"];
            accounts_list.insert(all, vObject);
            accounts_list_for.insert(Allacc, vObject);
            accounts_list_for_rd.insert(rd, vObject);

            all = all + 1;
            Allacc = Allacc + 1;
            rd = rd + 1;
          } else if (config["accountType"] == "D" ||
              config["accountType"] == "T") {
            //var test[] = new AccountFetchModel();
            var vObject = AccountFetchModel();
            vObject.textValue = config["accountNo"];
            vObject.dataValue = config["acckid"];
            vObject.customerName = config["customerName"];
            vObject.actEname = config["actEname"];
            vObject.accountType = "Loan Account";
            vObject.availbalance = config["clearBalance"];
            vObject.brancode = config["brancode"];
            vObject.brnEname = config["brnname"];
            accounts_list.insert(all, vObject);
            accounts_list_for_transfer_to.insert(to, vObject);
            accounts_list_for_loan.insert(Accloan, vObject);
            accounts_list_for.insert(Allacc, vObject);
            //  accounts_list_for_transfer.Insert(from, vObject);

            all = all + 1;
            to = to + 1;
            Accloan = Accloan + 1;
            Allacc = Allacc + 1;
            //  from = from + 1;
          }
        }

// Get List

        AppListData.FromAccounts = accounts_list_for_transfer;
        AppListData.ToAccounts = accounts_list_for_transfer_to;
        AppListData.AllAccounts = accounts_list;
        AppListData.Allacc = accounts_list_for;
        AppListData.Accloan = accounts_list_for_loan;
        AppListData.Sav = accounts_list_for_sav;
        AppListData.fd = accounts_list_for_fd;
        AppListData.rd = accounts_list_for_rd;
        AppListData.SavCA = accounts_list_for_SavCA;
        AppListData.SACACC = accounts_list_for_SACACC;
        AppListData.FDR = accounts_list_for_fdr;
        AppListData.fdclose = accounts_list_for_fd_close;
        AppListData.Fundtransfertransfer = accounts_list_for_INtraFund;

        setState(() {
          fromAccountList = AppListData.Fundtransfertransfer;
        });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Builder(builder: (context) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.1)),
                  child: AlertDialog(
                    backgroundColor: AppColors.onPrimary,
                    title: const Text(
                      'Alert',
                      style: TextStyle(fontSize: 18),
                    ),
                    content: const Text(
                      "Server Failed....!",
                      style: TextStyle(fontSize: 18),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                );
              });
            });
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Builder(builder: (context) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.1)),
              child: AlertDialog(
                backgroundColor: AppColors.onPrimary,
                title: const Text(
                  'Alert',
                  style: TextStyle(fontSize: 18),
                ),
                content: const Text(
                  "Unable to Connect to the Server",
                  style: TextStyle(fontSize: 18),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            );
          });
        },
      );
    }
  }

  Future<void> OnGeAvailableBalance(String item) async {
    try {
// Password Ency.
      String md5Hash = Crypt().generateMd5("Bank@123");

      //Loader.show(context, progressIndicator: CircularProgressIndicator());

      // API endpoint URL

      // String apiUrl = "rest/AccountService/GetAccountBalance";

      String apiUrl = ApiConfig.getAccountBalance;

      String jsonString = jsonEncode({
        "AccNo": item.toString(),
      });

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

      // Convert data to JSON

      String encrypted =
          AESencryption.encryptString(jsonString, Constants.AESENCRYPTIONKEY);

      final parameters = <String, dynamic>{
        "data": jsonString,
      };

      try {
        // Make POST request
        var response = await http.post(
          Uri.parse(apiUrl),
          body: jsonString,
          headers: headers,
          encoding: Encoding.getByName('utf-8'),
        );

        // Check if request was successful
        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = jsonDecode(response.body);
          //var data = jsonDecode(response.body);
          // Map<String, dynamic> jsonData = jsonDecode(response.body);
          var a = jsonDecode(responseData["Data"].toString());
          var b = responseData["Result"].toString();

          setState(() {
            amount = a.toString();
          });
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Builder(builder: (context) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.1)),
                  child: AlertDialog(
                    backgroundColor: AppColors.onPrimary,
                    title: const Text(
                      'Alert',
                      style: TextStyle(fontSize: 18),
                    ),
                    content: const Text(
                      "Server Failed....!",
                      style: TextStyle(fontSize: 18),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                );
              });
            },
          );
        }
      } catch (error) {
        Loader.hide();

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Builder(builder: (context) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.1)),
                child: AlertDialog(
                  backgroundColor: AppColors.onPrimary,
                  title: const Text(
                    'Alert',
                    style: TextStyle(fontSize: 18),
                  ),
                  content: const Text(
                    "Server Failed....!",
                    style: TextStyle(fontSize: 18),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              );
            });
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Builder(builder: (context) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.1)),
              child: AlertDialog(
                backgroundColor: AppColors.onPrimary,
                title: const Text(
                  'Alert',
                  style: TextStyle(fontSize: 18),
                ),
                content: const Text(
                  "Unable to Connect to the Server",
                  style: TextStyle(fontSize: 18),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            );
          });
        },
      );
    }
  }

  Future<void> FindName(String Name) async {
    Loader.show(context, progressIndicator: const CircularProgressIndicator());
    //String? deviceId = await PlatformDeviceId.getDeviceId;

// Password Ency.

    // String md5Hash = Crypt().generateMd5(password);

    // API endpoint URL

    // String apiUrl = "/rest/AccountService/fetchDataForFtr";
    String apiUrl = ApiConfig.fetchDataForFtr;

    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');
    String mobileNo = context.read<SessionProvider>().get('mobileNo');
    String branchCode = context.read<SessionProvider>().get('branchCode');
    String customerId = context.read<SessionProvider>().get('customerId');

  

    String mobileNumber = "91${txtMobileNumber.text}";
    String Benficiary = txtBeneficiry.text;
    String jsonString = jsonEncode({
      "data": Benficiary,
      "type": toSelectedValue,
      "Mobileno": mobileNumber,
    });

//     data = beneficary,
// type = searchselect,
// Mobileno = MobileNumber

    // String jsonString = jsonEncode(userInput.toJson());

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

    try {
      // Make POST request
      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      // Check if request was successful
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        String RESPONES = data["Data"].toString();
        String Result = data["Result"].toString();
        // String Request = response.body[Data].toString();
        
        // print(data);

        // var js = jsonDecode(data);

        // List<dynamic> jsonResponse = jsonDecode(data);

        if (Result == "Success") {
          Loader.hide();
          var dataa = AESencryption.decryptString(RESPONES, ibUsrKid);
          //var bob = dataa.toString();

          final responseData = json.decode(dataa);

          if (responseData.containsKey("customername")) {
            AccountholderName = responseData["customername"].toString().trim();
          } else if (responseData.containsKey("customerName")) {
            AccountholderName = responseData["customerName"].toString().trim();
          }

          customeraccountnumber =
              responseData["customeraccno"].toString().trim();
          customermobilenumber = responseData["adr_mobile"].toString().trim();
          txtName.text = AccountholderName;
        } else {
          Loader.hide();
          var dataa = AESencryption.decryptString(RESPONES, ibUsrKid);
          //var bob = dataa.toString();

          final responseData = json.decode(dataa);

             txtBeneficiry.text = "";
            txtMobileNumber.text = "";

          //String yut = bob.me.toString();
          Message = responseData["message"];
          Dialgbox(Message);
        }
      } else {
        Loader.hide();

                     txtBeneficiry.text = "";
            txtMobileNumber.text = "";

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Builder(builder: (context) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.1)),
                  child: AlertDialog(
                    backgroundColor: AppColors.onPrimary,
                    title: const Text(
                      'Alert',
                      style: TextStyle(fontSize: 18),
                    ),
                    content: const Text(
                      "Server Failed....!",
                      style: TextStyle(fontSize: 18),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                );
              });
            });
      }
    } catch (error) {
      Loader.hide();

                   txtBeneficiry.text = "";
            txtMobileNumber.text = "";

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Builder(builder: (context) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.1)),
              child: AlertDialog(
                backgroundColor: AppColors.onPrimary,
                title: const Text(
                  'Alert',
                  style: TextStyle(fontSize: 18),
                ),
                content: const Text(
                  "Unable to Connect to the Server",
                  style: TextStyle(fontSize: 18),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            );
          });
        },
      );
    }
  }

  Future<void> GetOTP() async {

 txtOTP.text = "";

    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    //String apiUrl = "rest/AccountService/sendOTP";

    String apiUrl = ApiConfig.sendOTP;

    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');
    String mobileNo = context.read<SessionProvider>().get('mobileNo');
    String sessionId = context.read<SessionProvider>().get('sessionId');
    String customerId = context.read<SessionProvider>().get('customerId');

    String accountnumberintrabank = customeraccountnumber.toString();
    String mobilenumberintrabank = customermobilenumber.toString();

    if (toSelectedValue == "Mobile Number") {
      accountnumberintrabank = customeraccountnumber;
      mobilenumberintrabank = customermobilenumber;
    } else {
      accountnumberintrabank = txtBeneficiry.text;
      mobilenumberintrabank = mobileNo;
    }

    OtpAccount userInput = OtpAccount(
        beneficiaryAccNo: accountnumberintrabank,
        userID: userid,
        purpose: "Fund Transfer",
        mobile: mobilenumberintrabank,
        sessionID: sessionId);

    String jsonString = jsonEncode(userInput.toJson());

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "tokenNo": tokenNo,
      "userID": userid,
    };

    // Convert data to JSON

    String encrypted = AESencryption.encryptString(jsonString, ibUsrKid);

    String d = "data=$encrypted";

    final parameters = <String, dynamic>{
      "data": encrypted,
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data["Result"] == "Success") {
          Loader.hide();
          var a = data["Data"];

          // var dataa = AESencryption.decryptString(
          //   a,
          //   Constants.AESENCRYPTIONKEY,
          // );
          var dataa = AESencryption.decryptString(a, ibUsrKid);
          var dataaa = jsonDecode(dataa);
          // String rona = dataa.toString();

          if (dataaa["authorise"] == "success") {
            otpvisible = true;

            setState(() {});
          } else {
            Loader.hide();
            Message = dataaa["Message"].toString();
            Dialgbox(Message);
          }
        } else {
          Loader.hide();

          Message = data["Message"].toString();
          Dialgbox(Message);
        }
      } else {
        Loader.hide();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Builder(builder: (context) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.1)),
                child: AlertDialog(
                  backgroundColor: AppColors.onPrimary,
                  title: const Text(
                    'Alert',
                    style: TextStyle(fontSize: 18),
                  ),
                  content: const Text(
                    "Server Failed....!",
                    style: TextStyle(fontSize: 18),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              );
            });
          },
        );
      }
    } catch (e) {
      Loader.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Builder(builder: (context) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.1)),
              child: AlertDialog(
                backgroundColor: AppColors.onPrimary,
                title: const Text(
                  'Alert',
                  style: TextStyle(fontSize: 18),
                ),
                content: const Text(
                  "Unable to Connect to the Server",
                  style: TextStyle(fontSize: 18),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            );
          });
        },
      );
    }
  }

  Future<void> FinalProceed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    String apiUrl = ApiConfig.fundTransferwithinBank;

    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');
    String mobileNo = context.read<SessionProvider>().get('mobileNo');
    String branchCode = context.read<SessionProvider>().get('branchCode');
    String customerId = context.read<SessionProvider>().get('customerId');
    String sessionId = context.read<SessionProvider>().get('sessionId');

    String accountnumberintrabank = customeraccountnumber.toString();
    String mobilenumberintrabank = customermobilenumber.toString();

    if (toSelectedValue == "Mobile Number") {
      accountnumberintrabank = customeraccountnumber;
      mobilenumberintrabank = customermobilenumber;
    } else {
      accountnumberintrabank = txtBeneficiry.text;
      mobilenumberintrabank = mobileNo;
    }

    // String jsonString = jsonEncode({
    //   "AccNo": item,
    // });

    String date = "&quot;2017-04-06 11:53:46&quot";
    List<String> time = date.split(' ')[1].split(':');
    String scDate = date;
    scDate = scDate.substring(5, 7) +
        "/" +
        scDate.substring(8, 10) +
        "/" +
        scDate.substring(0, 4);
    scDate += " " + time[0] + "" + time[1] + "" + time[2];

    String jsonString = jsonEncode({
      "beneficiaryAccNo": accountnumberintrabank,
      "accNo": ACCNUMBER.toString(),
      "userID": userid,
      "purpose": "Fund Transfer",
      "mobile": mobilenumberintrabank,
      "sessionID": sessionId,
      "OTP": txtOTP.text,
      "transferAmt": txtAmount.text,
      "sMode": "SingleTran",
      "isSch": "N",
      "schDate": scDate,
      "trnType": "O",
      "periodicity": "-1",
      "Remark": txtRemark.text + "~ MB-WTB",
      "benName": txtName.text,
      "custID": customerId,
      "payeemob": mobileNo,
      "chkFav": "",
      "ftrnwith": "",
      'latitude': prefs.getString('latitude').toString(),
      'longitude': prefs.getString('longitude').toString(),
      'address': prefs.getString('address').toString()
    });
    //String jsonString = jsonEncode(userInput.toJson());

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "tokenNo": tokenNo,
      "userID": userid,
    };

    // Convert data to JSON

    String encrypted = AESencryption.encryptString(jsonString, ibUsrKid);

    String d = "data=$encrypted";

    final parameters = <String, dynamic>{
      "data": encrypted,
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      if (response.statusCode == 200) {
        Loader.hide();
        var data = jsonDecode(response.body);

        if (data["Result"] == "Success") {
          var a = data["Data"];
          String decryptedResult = AESencryption.decryptString(a, ibUsrKid);
          var dataaa = jsonDecode(decryptedResult);

          if (dataaa["result"] == "success") {
            String res = dataaa["transactionID"].toString();

            await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Builder(builder: (context) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(textScaler: const TextScaler.linear(1.1)),
                      child: AlertDialog(
                        backgroundColor: AppColors.onPrimary,
                        title: const Text(
                          "Congratulations!!!!!!!!",
                          style: TextStyle(fontSize: 18),
                        ),
                        content: Text(
                          "Transaction Successfully Processed with ID:-$res",
                          style: const TextStyle(fontSize: 18),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Dashboard()));
                            },
                            child: const Text(
                              'OK',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
                });

            String ReferenceID = dataaa["transactionID"].toString();
            String MODETYPE = "Intra Bank Transfer";

            ShowSelfData.RefId = dataaa["transactionID"].toString();
            ShowSelfData.Mode = MODETYPE;
            ShowSelfData.ToAccount = accountnumberintrabank;
            ShowSelfData.Amount = txtAmount.text;
            ShowSelfData.FromAccount = ACCNUMBER.toString();

            var now = DateTime.now();

            String DateToday = "${now.day}-${now.month}-${now.year}";

            ShowSelfData.Date = DateToday;

            ShowSelfData.Remark = txtRemark.text;
//----------------------------------------------------------------------------------------------------
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const SelfAccountShow()));

// -----------------------------------------------------------------------------------------------------------------
          } else if (dataaa["result"] == "failure" &&
              dataaa["transactionID"].toString() == "-1" &&
              dataaa["Error"] == "InSufficient Balance") {
            Message = "Transaction Failed,Error Message-" +
                dataaa["Error"].toString();
            Alert = "Alert!!!!!!!!";
            DialogboxAlert(Message, Alert);
          } else if (dataaa["result"] == "failure" &&
              dataaa["Error"] == "OTP Mismatch") {
            Message = "Transaction Failed,Error Message-" +
                dataaa["Error"].toString();
            Alert = "Alert!!!!!!!!";
            DialogboxAlert(Message, Alert);
          } else if (dataaa["result"] == "failure" &&
              dataaa["transactionID"].toString() == "-1") {
            Message = "Transaction Failed,Error Message-" +
                dataaa["Error"].toString();
            Alert = "Alert!!!!!!!!";
            DialogboxAlert(Message, Alert);
          }
        } else {
          Message = data["Message"];
          Dialgbox(Message);
        }
      } else {
        Loader.hide();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Builder(builder: (context) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.1)),
                child: AlertDialog(
                  backgroundColor: AppColors.onPrimary,
                  title: const Text(
                    'Alert',
                    style: TextStyle(fontSize: 18),
                  ),
                  content: const Text(
                    "Server Failed....!",
                    style: TextStyle(fontSize: 18),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              );
            });
          },
        );
      }
    } catch (e) {
      Loader.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Builder(builder: (context) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.1)),
              child: AlertDialog(
                backgroundColor: AppColors.onPrimary,
                title: const Text(
                  'Alert',
                  style: TextStyle(fontSize: 18),
                ),
                content: const Text(
                  "Unable to Connect to the Server",
                  style: TextStyle(fontSize: 18),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            );
          });
        },
      );
    }
  }

  void DialogboxAlert(String message, String Alert) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Builder(builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.1)),
            child: AlertDialog(
              backgroundColor: AppColors.onPrimary,
              title: const Text(
                'Alert',
                style: TextStyle(fontSize: 18),
              ),
              content: Text(
                message,
                style: const TextStyle(fontSize: 18),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
