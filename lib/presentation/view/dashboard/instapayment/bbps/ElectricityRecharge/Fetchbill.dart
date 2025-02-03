// ignore_for_file: non_constant_identifier_names, deprecated_member_use, use_build_context_synchronously, unused_local_variable

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/presentation/view/BBPS/bbps.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/ElectricityRecharge/Electricity.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/ElectricityRecharge/Successfulltelectricity.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FatchBillElectricity extends StatefulWidget {
  const FatchBillElectricity({super.key});

  @override
  State<StatefulWidget> createState() => _FatchBillElectricity();
}

class _FatchBillElectricity extends State<FatchBillElectricity> {
  Future<bool> _onBackPressed() async {
    // Use Future.delayed to simulate async behavior
    await Future.delayed(const Duration(milliseconds: 1));

    // Perform the navigation
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Electricity()),
    );

    //Navigator.pop(context);
    // Prevent the default back button behavior
    return false;
  }

  String BillAmount = '';
  String DueDate = "";
  String CustomeName = "";
  String BillDate = "";
  String Remarks = "";
  String BillNumnber = "";
  String RequestID = "";
  String BillPeriod = "";
  String Premvalue = "";
  String Message = "";

  @override
  void initState() {
    super.initState();
    dataFound();
    // updateNumberInWords();
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
      BillPeriod = prefs.getString("BillPeriod") ?? '';
      Premvalue = prefs.getString("Premvalue") ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Builder(builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: Text(
                    "Fetch Bill",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                  backgroundColor: const Color(0xFF0057C2),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.asset(
                        CustomImages.assured,
                        height: 52,
                    width: 52,
                      ),
                    ),
                  ],
                  leading: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BBPSConnect()),
                      );
                     // Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                    //change your color here
                  ),
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 20, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                child: Text(
                                  "Customer Name:",
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF0057C2)),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  CustomeName,
                                  style: const TextStyle(
                                      fontSize: 16, color: Color(0xFF0057C2)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Center(
                              child: SizedBox(
                            width: size.width * 0.9,
                            height: 2,
                            child: Center(
                                child: Container(
                              color: Colors.black26,
                            )),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 20, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                child: Text(
                                  "Bill Number:",
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF0057C2)),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  BillNumnber,
                                  style: const TextStyle(
                                      fontSize: 16, color: Color(0xFF0057C2)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Center(
                              child: SizedBox(
                            width: size.width * 0.9,
                            height: 2,
                            child: Center(
                                child: Container(
                              color: Colors.black26,
                            )),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 20, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                child: Text(
                                  "Bill Date:",
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF0057C2)),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  BillDate,
                                  style: const TextStyle(
                                      fontSize: 16, color: Color(0xFF0057C2)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Center(
                              child: SizedBox(
                            width: size.width * 0.9,
                            height: 2,
                            child: Center(
                                child: Container(
                              color: Colors.black26,
                            )),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 20, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                child: Text("Due Date:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF0057C2))),
                              ),
                              Flexible(
                                child: Text(
                                  DueDate,
                                  style: const TextStyle(
                                      fontSize: 16, color: Color(0xFF0057C2)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Center(
                              child: SizedBox(
                            width: size.width * 0.9,
                            height: 2,
                            child: Center(
                                child: Container(
                              color: Colors.black26,
                            )),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 20, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                child: Text("Amount:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF0057C2))),
                              ),
                              Flexible(
                                child: Text(
                                  BillAmount,
                                  style: const TextStyle(
                                      fontSize: 16, color: Color(0xFF0057C2)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Center(
                              child: SizedBox(
                            width: size.width * 0.9,
                            height: 2,
                            child: Center(
                                child: Container(
                              color: Colors.black26,
                            )),
                          )),
                        ),
                        InkWell(
                          onTap: () async {
                            // Your onTap functionality here

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => DashboardPage()));

                            _checkLatency();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 50.0,
                                left: 10.0,
                                right: 10.0,
                                bottom: 10.0),
                            child: Container(
                              height: 50.sp,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0057C2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Add some spacing between the icon and the text

                                    Text(
                                      "PAY",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // const SizedBox(width: 8),
                                    // Image.asset("assets/images/next.png"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))),
          );
        }));
  }

  // ignore: unused_element
  Future<void> _checkLatency() async {
    final stopwatch = Stopwatch()..start();

    try {
      var response = await http.get(Uri.parse('https://www.google.com/'));

      if (kDebugMode) {
        print(response.statusCode);
      }

      stopwatch.stop();
      if (response.statusCode == 200) {
        if (stopwatch.elapsedMilliseconds > 5000) {
          await QuickAlert.show(
              context: context,
              type: QuickAlertType.warning,
              headerBackgroundColor: Colors.yellow,
              title: 'Oops...',
              text:
                  "There’s a minor network issue at the moment. Click 'Yes' to keep your connection active, but be aware it might be risky. Select 'No' to log off securely.",
              confirmBtnText: 'Yes',
              cancelBtnText: 'No',
              onConfirmBtnTap: () {
                Navigator.pop(context);

                OnSubmitButton();
              },
              onCancelBtnTap: () {
                Navigator.pop(context);
              },
              showCancelBtn: true,
              confirmBtnColor: Colors.green,
              barrierDismissible: false);
        } else {
          OnSubmitButton();
        }
      } else {
        OnSubmitButton();
      }
    } catch (e) {
      OnSubmitButton();
    }
  }

  Future<void> OnSubmitButton() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      // API endpoint URL

      // String apiUrl = "/rest/BBPSService/PostpaidBillpay";

      String apiUrl = ApiConfig.postpaidBillpay;

      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

      String branchCode = context.read<SessionProvider>().get('branchCode');
      String customerId = context.read<SessionProvider>().get('customerId');
      // String accountNo = context.read<SessionProvider>().get('accountNo');

      String branchIFSC = context.read<SessionProvider>().get('branchIFSC');

      String jsonString = jsonEncode({
        "customerMobile": "7014133057",
        "amount": BillAmount,
        "billerId": RequestID,
        "billAmount": BillAmount,
        "custConvFee": "",
        "ip": "",
        "customeraccountnumber": "",
        "Remark": "",
        "Custid": customerId,
        "userid": userid,
        "accNo": "",
        "email": "",
        "date": "",
        "vendorId": "",
        "activityId": "",
        "mode": "",
        "type": "",
        "custRole": "",
        "brnCode": branchCode,
        "mobile": "",
        "IFSC": branchIFSC,
        "paymentMode": "Internet Banking",
        "requestId": RequestID,
        "dueDate": DueDate,
        "billDate": BillDate,
        "billNumber": BillNumnber,
        "customerName": CustomeName,
        "billPeriod": BillPeriod,
        "Paramvalue": Premvalue,
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
                    builder: (context) => const SuccessfullyElectricity()));
          } else {
            Loader.hide();
            var decryptedResult = responseData["Data"] as List<dynamic>;
            var decryptedResultt = decryptedResult[0] as Map<String, dynamic>;

            String decryptedResulttt =
                decryptedResultt["errorMessage"] as String;

            Message = decryptedResulttt;
         await   DialogboxAlert(Message);
            return;
          }
        } else {
          Loader.hide();
          Message = "Server Failed....!";
       await   DialogboxAlert(Message);
          return;
        }
      } catch (error) {
        Loader.hide();
        //  Loader.hide();
        Message = "Server Failed....!";
     await   DialogboxAlert(Message);
        return;
      }
    } catch (e) {
      Loader.hide();
      Message = "Unable to Connect to the Server";
    await  DialogboxAlert(Message);
      return;
    }
  }

   DialogboxAlert(String message) async{
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
}
