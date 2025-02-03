// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/config/constants.dart';
import 'package:hpscb/data/models/dashboarddatamodel.dart';

import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/appdrawer/drawer.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/creditcard/CreditCard.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/creditcard/ResigesterCreditCard.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/creditcard/SucessScreenCredit.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/creditcard/showcreditcard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CreditcardFatchBill extends StatefulWidget {
  const CreditcardFatchBill({super.key});

  @override
  State<StatefulWidget> createState() => _CreditcardFatchBill();
}

class _CreditcardFatchBill extends State<CreditcardFatchBill> {
  String BillAmount = '';
  String DueDate = "";
  String CustomeName = "";
  String BillDate = "";
  String Remarks = "";
  String BillNumnber = "";
  String RequestID = "";
  String BillPeriod = "";
  String BILLERID = "";
  String Message = "";
  String CustomermobileNumber = "";
  String AccountBalance = "";
  String ACCOUNTNUMBER = "";
  String TYPE = "";
  String Name = "";
  String amount = "";
  var FromAccountNumberr;
  bool BalanceVisible = false;
  bool ACCOUNUMET = false;
  final List<AccountFetchModel> toAccountList = AppListData.FromAccounts;

  @override
  void initState() {
    super.initState();
    dataFound();
    // updateNumberInWords();
  }

  void onToAccount(String value) {
    OngetBalance(value);
    BalanceVisible = true;
  }

  Future<void> dataFound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      BillAmount = prefs.getString("BillAmount") ?? '';
      CustomeName = prefs.getString("CustomeName") ?? '';
      DueDate = prefs.getString("DueDate") ?? '';
      BillDate = prefs.getString("BillDate") ?? '';
      BillNumnber = prefs.getString("BillNumnber") ?? '';
      RequestID = prefs.getString("RequestID") ?? '';
      BILLERID = prefs.getString("BillerID") ?? '';
      CustomermobileNumber = prefs.getString("MobilenumberCustomet") ?? '';
      AccountBalance = prefs.getString("Balance") ?? '';
      ACCOUNTNUMBER = prefs.getString("AccountNumber") ?? '';
      TYPE = prefs.getString("Type") ?? '';

      // else if(TYPE =="AlreadyREgister"){
      //   Name=
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (TYPE == "Registercard") {
      Name = "HOME";

      setState(() {
        ACCOUNUMET = true;
      });
    } else if (TYPE == "BillPay") {
      Name = "PAY NOW";
    } else if (TYPE == "Billpaypast") {}

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Fatch Bill",
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        leading: IconButton(
          onPressed: () {
            if (TYPE == "Registercard") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShowCreditCard()));
            } else if (TYPE == "BillPay") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreditCard()));
            } else if (TYPE == "Billpaypast") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreditCard()));
            }
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF0057C2),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.sp),
            child: Container(
                width: 80.sp,
                height: 45.sp,
                decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.circular(100.0),
                    color: AppColors.appBlueC),
                child: const Image(
                  image: AssetImage(
                    CustomImages.bbpsconnect,
                  ),
                )),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                //width: size.width,
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 8, left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: ACCOUNUMET,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text(
                                "From Account",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                margin: const EdgeInsets.only(top: 5),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    dropdownColor: AppColors.onPrimary,
                                    value: FromAccountNumberr,
                                    hint: const Text(
                                      'From Account',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                    icon: const Icon(Icons.arrow_drop_down),
                                    isExpanded: true,
                                    items: toAccountList
                                        .map((AccountFetchModel obj) {
                                      return DropdownMenuItem<String>(
                                        value: obj.textValue,
                                        child: Builder(builder: (context) {
                                          return MediaQuery(
                                            data: MediaQuery.of(context)
                                                .copyWith(
                                                    textScaler:
                                                        const TextScaler.linear(
                                                            1.1)),
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
                                        FromAccountNumberr = newValue!;
                                      });

                                      onToAccount(newValue!);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: BalanceVisible,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Available Balance",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Visibility(
                                      child: Text(
                                        "\u{20B9}" + amount,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),

                      _buildDetailRow('CONSUMER NAME', CustomeName),
                      // _buildDetailRow('MOBILE NUMBER', '701413305),
                      _buildDetailRow('BILL DUE DATE', DueDate),
                      _buildDetailRow('BILL DATE', BillDate),
                      //  _buildDetailRow('MINIMUM AMOUNT DUE', BillAmount),
                      // _buildDetailRow('CURRENT OUTSTANDING AMOUNT', '₹4394.69'),
                      // SizedBox(height: 8),
                      // Divider(),
                      _buildDetailRow('AMOUNT', "\u{20B9} $BillAmount"),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              // if (Name == "HOME") {
              //   // Navigator.push(context,
              //   //     MaterialPageRoute(builder: (context) => CreditCard()));
              // } else if (Name == "PAY NOW") {
              //   OnSubmitButton();
              // }

              OnSubmitButton();
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
              child: Container(
                height: 50.sp,
                decoration: BoxDecoration(
                  color: const Color(0xFF0057C2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "PAY NOW",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          // SizedBox(
          //   width: double.infinity,
          //   height: 70,
          //   child: Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: Color(0xFF0057C2), // Adjust to your design
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //       ),
          //       onPressed: () {
          //         // Handle pay button click
          //       },
          //       child: Text(
          //         'Pay Now',
          //         style: TextStyle(
          //           fontSize: 18,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> OnSubmitButton() async {
    try {
      if (TYPE == "Registercard") {
        if (FromAccountNumberr == null || FromAccountNumberr == "") {
          Message = "Please Select From Account";
          await DialogboxAlert(Message);
          return;
        }
      }

      String AccountBalancee = BillAmount;

      // List<String> parts = AccountBalancee.split('.');
      // String integerPart = parts[0]; // "-12446"
      // String decimalPart = parts[1];

      // int numberri = int.parse(AccountBalance);
      // int numberrr = int.parse(integerPart);

      String? balance;
      String? Accountnumber;
      if (amount == "") {
        balance = AccountBalance.toString();
      } else {
        balance = amount.toString();
      }

      if (FromAccountNumberr == null || FromAccountNumberr == "") {
        Accountnumber = ACCOUNTNUMBER.toString();
      } else {
        Accountnumber = FromAccountNumberr.toString();
      }

      double ronakValue = double.parse(AccountBalancee);
      double vikasValue = double.parse(balance);
      if (ronakValue > vikasValue) {
        Message = "Insufficient Balance";
        await DialogboxAlert(Message);
        return;
      }
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      // API endpoint URL

      //String apiUrl = "rest/BBPSService/PostpaidBillpay";

      String apiUrl = ApiConfig.postpaidBillpay;

      String userid = context.read<SessionProvider>().get('userid');
      String customerId = context.read<SessionProvider>().get('customerId');
      String branchCode = context.read<SessionProvider>().get('branchCode');
      String branchIFSC = context.read<SessionProvider>().get('branchIFSC');

      String jsonString = jsonEncode({
        "customerMobile": CustomermobileNumber,
        "amount": BillAmount,
        "billerId": BILLERID,
        "billAmount": BillAmount,
        "custConvFee": "",
        "ip": "",
        "customeraccountnumber": "",
        "Remark": "",
        "Custid": customerId,
        "userid": userid,
        "accNo": Accountnumber,
        "email": "",
        "date": "",
        "vendorId": "",
        "activityId": "",
        "mode": "",
        "type": "Credit Card",
        "custRole": "",
        "brnCode": branchCode,
        "mobile": "",
        "IFSC": branchIFSC.trim(),
        "paymentMode": "Internet Banking",
        "requestId": RequestID,
        "dueDate": DueDate,
        "billDate": BillDate,
        "billNumber": "",
        "customerName": CustomeName,
        "billPeriod": "",
        "Paramvalue": BillAmount,
      });

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

      // Convert data to JSON

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

          if (responseData["Result"] == "Sucess") {
            Loader.hide();
            Map<String, dynamic> billData = responseData["Data"][0];

            String RespCustomerName = billData["RespCustomerName"].toString();
            String RespDueDate = billData["RespDueDate"].toString();
            String RespBillDate = billData["RespBillDate"].toString();
            String RespAmount = billData["RespAmount"].toString();
            String responseCode = billData["responseCode"].toString();
            String txnRespType = billData["txnRespType"].toString().trim();
            String responseReason = billData["responseReason"].toString();
            String requestId = billData["requestId"].toString();
            String RespBillNumber = billData["RespBillNumber"].toString();
            String txnRefId = billData["txnRefId"].toString();
            String approvalRefNumber = billData["approvalRefNumber"].toString();
            String RespBillPeriod = billData["RespBillPeriod"].toString();
            String CustConvFee = billData["CustConvFee"].toString();

            DateFormat originalFormat = DateFormat('yyyy-MM-dd');
            DateFormat targetFormat = DateFormat('dd-MM-yyyy');

            DateTime originalDate = originalFormat.parse(RespDueDate);
            String ElectricitDueDate = targetFormat.format(originalDate);

            DateTime originalDatee = originalFormat.parse(RespBillDate);
            String ElectricityBilldate = targetFormat.format(originalDatee);

            final prefs = await SharedPreferences.getInstance();

            prefs.setString("BillAmount", RespAmount);
            prefs.setString("CustomeName", RespCustomerName);
            prefs.setString("DueDate", ElectricitDueDate);
            prefs.setString("BillDate", ElectricityBilldate);
            prefs.setString("BillNumnber", RespBillNumber);
            prefs.setString("RequestID", requestId);
            prefs.setString("txnRespType", txnRespType);
            prefs.setString("responseReason", responseReason);
            prefs.setString("approvalRefNumber", approvalRefNumber);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SuccessfullyCredit()));

            // ignore: use_build_context_synchronously
            //   context.push('/SuccessfullyCredit');
          }
          // else if(Result=="Faisl")
          else {
            Loader.hide();
            if (responseData["message"] == null || responseData["Data"] == "") {
              var decryptedResult = responseData["Data"] as List<dynamic>;
              var decryptedResultt = decryptedResult[0] as Map<String, dynamic>;
//"{"message":"Technical Issue Please Try After Some time.","Result":"Fail"}"

              String decryptedResulttt =
                  decryptedResultt["errorMessage"] as String;

              Message = decryptedResulttt;
              await DialogboxAlert(Message);
              return;
            } else {
              var decryptedResult = responseData["message"];
              Message = decryptedResult;
              await DialogboxAlert(Message);
            }
          }
        } else {
          Loader.hide();
          Message = "Server Failed....!";
          await DialogboxAlert(Message);
          return;
        }
      } catch (error) {
        Loader.hide();
        //  Loader.hide();
        Message = "Server Failed....!";
        await DialogboxAlert(Message);
        return;
      }
    } catch (e) {
      Loader.hide();
      Message = "Unable to Connect to the Server";
      await DialogboxAlert(Message);
      return;
    }
  }

  DialogboxAlert(String message) async {
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

  Future<void> OngetBalance(String item) async {
    try {
      String apiUrl = ApiConfig.getAccountBalance;

      String jsonString = jsonEncode({
        "AccNo": item,
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
          Message = "Server Failed....!";
          await DialogboxAlert(Message);
          return;
        }
      } catch (error) {
        Message = "Server Failed....!";
        await DialogboxAlert(Message);
        return;
      }
    } catch (e) {
      Message = "Unable to Connect to the Server";
      await DialogboxAlert(Message);
      return;
    }
  }
}






// import 'dart:convert';
// import 'package:HPSCB/info/information.dart';
// import 'package:HPSCB/ip/constant.dart';
// import 'package:HPSCB/ip/ipset.dart';
// import 'package:HPSCB/model/dashboardmodel.dart';
// import 'package:HPSCB/model/recharge.dart';
// import 'package:HPSCB/ui/dashboardmenu/instabanking/bbps/FastTagRecharge/FatchBill.dart';
// import 'package:HPSCB/ui/dashboardmenu/instabanking/bbps/bbps.dart';
// import 'package:HPSCB/ui/encryption/md5.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
// import 'package:http/http.dart' as http;
// import 'package:platform_device_id_v3/platform_device_id.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CreditcardFatchBill extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _CreditcardFatchBill();
// }

// class _CreditcardFatchBill extends State<CreditcardFatchBill> {
//   void initState() {
//     // TODO: implement initState
//     //OnGeAvailableBalance();
//     super.initState();
//   }

//   Future<bool> _onBackPressed() async {
//     // Use Future.delayed to simulate async behavior
//     await Future.delayed(Duration(milliseconds: 1));

//     // Perform the navigation
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => BBPS()),
//     );

//     // Prevent the default back button behavior
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;

//     double _getButtonFontSize(BuildContext context) {
//       double screenWidth = MediaQuery.of(context).size.width;
//       if (screenWidth > 600) {
//         return 14.0; // Large screen
//       } else if (screenWidth > 400) {
//         return 15.0; // Medium screen
//       } else {
//         return 16.0; // Default size
//       }
//     }

//     return WillPopScope(
//       onWillPop: _onBackPressed,
//       child: Builder(builder: (context) {
//         return MediaQuery(
//           data: MediaQuery.of(context)
//               .copyWith(textScaler: const TextScaler.linear(1.0)),
//           child: Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               title: const Text(
//                 "Broadband Recharge",
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//               leading: IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => BBPS()),
//                   );
//                 },
//                 icon: const Icon(Icons.arrow_back),
//                 color: Colors.white,
//               ),
//               backgroundColor: const Color(0xFF0057C2),
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 10.0),
//                   child: Container(
//                       width: 55,
//                       height: 45,
//                       decoration: const BoxDecoration(
//                           // borderRadius: BorderRadius.circular(100.0),
//                           color: Colors.white),
//                       child: Image.asset("assets/images/BBPS_Logo.png")),
//                 ),
//               ],
//             ),
//             body: SingleChildScrollView(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
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
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(top: 10.0, left: 10.0),
//                         child: Text(
//                           "From Account",
//                           style: TextStyle(
//                               color: Color(0xFF0057C2),
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () async {},
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
//                           child: Container(
//                             height: 55,
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF0057C2),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 "PROCEED",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: _getButtonFontSize(context),
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   void onFromAccount(String item) {
//     print('Selected value: $item');
//   }

//   void Dialgbox(String MESSAGE) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Builder(builder: (context) {
//           return MediaQuery(
//             data: MediaQuery.of(context)
//                 .copyWith(textScaler: const TextScaler.linear(1.1)),
//             child: AlertDialog(
//               title: Text(
//                 'Alert',
//                 style: TextStyle(fontSize: 16),
//               ),
//               content: Text(
//                 MESSAGE,
//                 style: TextStyle(fontSize: 16),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text(
//                     'OK',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         });
//       },
//     );
//   }

//   // API Code............................................................

//   void DialogboxAlert(String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Builder(builder: (context) {
//           return MediaQuery(
//             data: MediaQuery.of(context)
//                 .copyWith(textScaler: const TextScaler.linear(1.1)),
//             child: AlertDialog(
//               title: Text(
//                 'Alert',
//                 style: TextStyle(fontSize: 16),
//               ),
//               content: Text(
//                 message,
//                 style: TextStyle(fontSize: 16),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text(
//                     'OK',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         });
//       },
//     );
//   }
// }
