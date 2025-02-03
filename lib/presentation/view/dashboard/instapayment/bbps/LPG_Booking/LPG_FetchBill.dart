// ignore_for_file: non_constant_identifier_names, deprecated_member_use, unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/FastTagRecharge/Successfully.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/LPG_Booking/LPG.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class LPG_Fatch extends StatefulWidget {
  const LPG_Fatch({super.key});

  @override
  State<StatefulWidget> createState() => LPGBookingScreen();
}

class LPGBookingScreen extends State<LPG_Fatch> {
  @override
  void initState() {
    super.initState();
    dataFound();
    // OnFatchBill();
  }

  Future<void> dataFound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      BILLERID = prefs.getString("BillerID") ?? '';
      consumerno = prefs.getString("consumerno") ?? '';

      AccountBalance = prefs.getString("AccountBalance") ?? '';
      accountnumber = prefs.getString("AccountNUMber") ?? '';
      billamountApi = prefs.getString("BillAMOUNT") ?? '';
      RequestID = prefs.getString("RequestID") ?? '';
      consumerNameeee = prefs.getString("consmasjabd") ?? '';
      Billername = prefs.getString("Billername") ?? '';
    });
  }

  String BILLERID = "";
  String consumerno = "";
  String AccountBalance = "";
  String accountnumber = "";
  String RequestID = "";
  String Billername = "";

  String consumerName = "";
  String consumerNameeee = "";

  String billamountApi = "";
  String Customename = "";

  String consumerNo = "";
  String lpgbiller = "";
  // String consumerName="";
  String billamtt = "";
  String payAmt = "";
  // String consumerNo="";
  String Message = "";

  // TextEditingController consumerNo = TextEditingController();
  // TextEditingController lpg_biller = TextEditingController();

  // TextEditingController consumerName = TextEditingController();
  // TextEditingController BillAmout = TextEditingController();

  // TextEditingController payAmt = TextEditingController();

  Future<bool> _onBackPressed() async {
    // Use Future.delayed to simulate async behavior
    await Future.delayed(const Duration(milliseconds: 1));

    // Perform the navigation
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LPG()),
    );
    // ignore: use_build_context_synchronously

    // ignore: use_build_context_synchronously
    //Navigator.pop(context);
    //context.pop(context);

    // Prevent the default back button behavior
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Builder(
        builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  "LPG Booking",
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LPG()),
                    );

                    //  context.pop(context);

                    //Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Image.asset(
                        CustomImages.bbpsconnect,
                        width: 85,
                        height: 75,
                      ),
                    ),
                  ),
                ],
                backgroundColor: const Color(0xFF0057C2),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        consumerno,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        Billername,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),

                      Center(
                        child: Container(
                          width: 100,
                          height: 150,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Image.asset(CustomImages.lpgbbps),
                        ),
                      ),

                      const SizedBox(height: 5.0),

                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Bill Payment for',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        consumerNameeee,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        billamountApi,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0057C2),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Bill amount',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => SuccessfullyLPG()));

OnSubmitButton();

                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xFF0057C2),
                        ),
                        child: Text(
                          'Pay $billamountApi',
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

   Dialgbox(String MESSAGE) async{
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

   DialogboxAlert(String message) async{
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
                message,
                style: const TextStyle(fontSize: 18),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => FastTag()));
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

  Future<void> OnSubmitButton() async {
    try {
      String Amounttt = "";

      // if (AmountTxt.text == null) {}

      double userAmount = double.tryParse(Amounttt) ?? 0;
      double userAmountt = double.tryParse(billamountApi) ?? 0;
      // if (Amounttt.toString() == null || Amounttt.toString() == "") {
      //   Message = "Please Enter Amount";
      //   DialogboxAlert(Message);
      //   return;
      // }

      if (userAmount >= userAmountt) {
        Message = "Amount must be above $userAmountt";
        DialogboxAlert(Message);
        return;
      }
      String AccountBalancee = AccountBalance.toString();

      List<String> parts = AccountBalancee.split('.');
      String integerPart = parts[0]; // "-12446"
      String decimalPart = parts[1];

      int numberri = int.parse(Amounttt);
      int numberrr = int.parse(integerPart);
      if (numberri > numberrr) {
        Message = "Insufficient Balance";
      await  DialogboxAlert(Message);
        return;
      }

      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

// Password Ency.

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      // API endpoint URL

      String apiUrl = ApiConfig.postpaidBillpay;

      String userid = context.read<SessionProvider>().get('userid');
      String customerId = context.read<SessionProvider>().get('customerId');
      String branchCode = context.read<SessionProvider>().get('branchCode');
      String branchIFSC = context.read<SessionProvider>().get('branchIFSC');

      String jsonString = jsonEncode({
        "customerMobile": "7014133057",
        "amount": "", // Bill Amt
        "billerId": BILLERID,
        "custConvFee": "",
        "ip": "",
        "customeraccountnumber": "",
        "Remark": "",
        "Custid": customerId,
        "userid": userid,
        "accNo": accountnumber.toString(),
        "email": "",
        "date": "",
        "vendorId": "",
        "activityId": "",
        "mode": "",
        "type": "Fastag",
        "custRole": "",
        "brnCode": branchCode,
        "mobile": "",
        "IFSC": branchIFSC.trim(),
        "paymentMode": "Internet Banking",
        "requestId": RequestID.toString(),
        "billAmount": "", // bill amt
        "dueDate": "",
        "billDate": "",
        "billNumber": "NA",
        "customerName": "",
        "billPeriod": "NA",
        "Paramvalue": consumerno.toString(),
        "info": consumerno
      });

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
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

          if (responseData["Result"] == "Sucess") {
            Loader.hide();
            Map<String, dynamic> billData = responseData["Data"][0];

            String RespCustomerName = billData["RespCustomerName"].toString();
            String RespAmount = billData["RespAmount"].toString();
            String responseCode = billData["responseCode"].toString();
            String txnRespType = billData["txnRespType"].toString().trim();
            String responseReason = billData["responseReason"].toString();
            String requestId = billData["requestId"].toString();
            String txnRefId = billData["txnRefId"].toString();
            String approvalRefNumber = billData["approvalRefNumber"].toString();
            String CustConvFee = billData["CustConvFee"].toString();

            final prefs = await SharedPreferences.getInstance();

            prefs.setString("BillAmount", RespAmount);
            prefs.setString("CustomeName", RespCustomerName);
            prefs.setString("responseReason", responseReason);
            prefs.setString("approvalRefNumber", approvalRefNumber);

            // ignore: use_build_context_synchronously
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SuccessfullyFastag()));

            // ignore: use_build_context_synchronously
            // context.push('/SuccessfullyLPG');
          } else {
            Loader.hide();
            var decryptedResult = responseData["Data"] as List<dynamic>;
            var decryptedResultt = decryptedResult[0] as Map<String, dynamic>;

            String decryptedResulttt =
                decryptedResultt["errorMessage"] as String;

            Message = decryptedResulttt;
          await  DialogboxAlert(Message);
            return;
          }
        } else {
          Loader.hide();
          Message = "Server Failed....!";
        await  DialogboxAlert(Message);
          return;
        }
      } catch (error) {
        Loader.hide();
        //  Loader.hide();
        Message = "Server Failed....!";
      await  DialogboxAlert(Message);
        return;
      }
    } catch (e) {
      Loader.hide();
      Message = "Unable to Connect to the Server";
     await DialogboxAlert(Message);
      return;
    }
  }
}
