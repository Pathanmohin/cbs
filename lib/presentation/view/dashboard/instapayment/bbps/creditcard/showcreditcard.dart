import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/config/constants.dart';
import 'package:hpscb/data/models/creditcardmodel.dart';
import 'package:hpscb/data/models/creditcardsavedata.dart';
import 'package:hpscb/data/models/rechargemodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/presentation/view/BBPS/bbps.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/creditcard/CreditCard.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/creditcard/FetchBillCreditCard.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowCreditCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShowCreditCard();
}

class _ShowCreditCard extends State<ShowCreditCard> {
  @override
  void initState() {
    super.initState();
    cardItems = CreditCARD.CARDNUMBER;
  }

  List<CREDITSVAEDATA> cardItems = [];

  Future<bool> _onBackPressed() async {
    await Future.delayed(const Duration(milliseconds: 1));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BBPSConnect()),
    );
    return false;
  }

  // final List<SimpleObject> toAccountList = AppListData.FromAccounts;

  String bankname = "";
  String creditcardnumber = "";
  String cutomername = "";
  String billerid = "";
  String cutomermobilenumber = "";
  String Message = "";

  final List<Rechargmobile> fromAccountList = <Rechargmobile>[];

  Widget _buildCardList() {
    print("Number of cards: ${cardItems.length}");
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: cardItems.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              CardWidget(
                item: cardItems[index],
                onPressed: () {
                  setState(() {
                    bankname = cardItems[index].BANKNAME.toString();
                    creditcardnumber =
                        cardItems[index].CREDITCARDNUMBER.toString();
                    cutomername = cardItems[index].CustomerName.toString();
                    billerid = cardItems[index].BillerID.toString();
                    cutomermobilenumber =
                        cardItems[index].CutomerMobileNumber.toString();
                  });

                  GetBillerName();
                },
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    double _getButtonFontSize(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      if (screenWidth > 600) {
        return 14.0; // Large screen
      } else if (screenWidth > 400) {
        return 15.0; // Medium screen
      } else {
        return 16.0; // Default size
      }
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Builder(builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                "Credit Card",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BBPSConnect()),
                  );
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
                        image: AssetImage(CustomImages.bbpsconnect),
                      )),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  child: Column(children: [
                    Container(
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
                          Container(height: 400.h, child: _buildCardList()),
                          InkWell(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CreditCard()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  left: 10.0,
                                  right: 10.0,
                                  bottom: 10.0),
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0057C2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "PAY BILL",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: _getButtonFontSize(context),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ])),
            ),
          ),
        );
      }),
    );
  }

  void onFromAccount(String item) {
    print('Selected value: $item');
  }

  void DialogboxAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Builder(builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.1)),
            child: AlertDialog(
              title: const Text(
                'Alert',
                style: TextStyle(fontSize: 16),
              ),
              content: Text(
                message,
                style: const TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  Future<void> GetBillerName() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      // API endpoint URL

      //String apiUrl = "rest/BBPSService/billereducationvali";
      String apiUrl = ApiConfig.billereducationvali;

      String jsonString = jsonEncode({
        "billerId": billerid,
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
          Loader.hide();
          Map<String, dynamic> responseData = jsonDecode(response.body);

          var a = responseData["paramname"].toString();

          List<dynamic> paramList = jsonDecode(responseData['paramname']);
          String THIRD = paramList[0]['paramName'];
          String SECOND = paramList[1]['paramName'];

          String Name = "$THIRD,$SECOND";

          OnFatchBill(Name);
        } else {
          Loader.hide();
          Message = "Server Failed....!";
          DialogboxAlert(Message);
          return;

          //   Message = "Server Failed....!";
          // DialogboxAlert(Message);
          // return;
        }
      } catch (error) {
        Loader.hide();
        Message = "Server Failed....!";
        DialogboxAlert(Message);
        return;
      }
    } catch (e) {
      Loader.hide();
      Message = "Unable to Connect to the Server";
      DialogboxAlert(Message);
      return;
    }
  }

  Future<void> OnFatchBill(String name) async {
    try {
      // Loader.show(context,
      //     progressIndicator: const CircularProgressIndicator());

      // Password Ency.

      String CREDITCARDNUMBERR = creditcardnumber;

      String cleanedString = CREDITCARDNUMBERR.replaceAll(' ', '');

      // Get the last 4 digits
      String lastFourDigits = cleanedString.substring(cleanedString.length - 4);

      String apiUrl = ApiConfig.creditcardfetchbill;

      //  String apiUrl = "${AppCongifP.apiurllinkBBPS}/rest/BBPSService/creditcardfetchbill";

      String jsonString = jsonEncode({
        "Billerid": billerid,
        "Circle": "",
        "mobileno": cutomermobilenumber,
        "cardno": lastFourDigits,
        "billercat": "Credit Card",
        "ParamValue": name,
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
          //  var a = responseData["Data"].toString());

          if (responseData["Result"] == "Sucess") {
            // Loader.hide();
            var decryptedResult = responseData["Data"];
            Map<String, dynamic> billData = responseData["Data"][0];

            String billAmount = billData["billAmount"].toString();
            String requestId = billData["requestId"].toString();
            String DueDatee = billData["dueDate"].toString();
            String billDatee = billData["billDate"].toString();
            String billNumber = billData["billNumber"].toString();
            String customerName = billData["customerName"].toString().trim();
            String Minimumamountdue = responseData["info"].toString();
            // String RequestID = responseData["requestId"].toString();

            // List<dynamic> dataList = jsonDecode(Minimumamountdue);
            // String minimumAmountDue = dataList.firstWhere((element) =>
            //     element['infoName'] == 'Minimum Amount Due')['description'];
            // String currentOutstandingAmount = dataList.firstWhere((element) =>
            //     element['infoName'] ==
            //     'Current Outstanding Amount')['description'];

            final prefs = await SharedPreferences.getInstance();

            prefs.setString("BillAmount", billAmount);
            prefs.setString("CustomeName", customerName);
            prefs.setString("DueDate", DueDatee);
            prefs.setString("BillDate", billDatee);

            prefs.setString("BillNumnber", billNumber);
            prefs.setString("RequestID", requestId);
            prefs.setString("BillerID", billerid);
            prefs.setString("MobilenumberCustomet", cutomermobilenumber);
            // prefs.setString("Balance", amount);
            // prefs.setString("AccountNumber", FromAccountNumber);
            prefs.setString("Type", "Registercard");
            prefs.setString("CardNumber", creditcardnumber);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreditcardFatchBill()),
            );
          } else {
            // Loader.hide();

            var decryptedResult = responseData["Data"] as List<dynamic>;
            var decryptedResultt = decryptedResult[0] as Map<String, dynamic>;

            String decryptedResulttt =
                decryptedResultt["errorMessage"] as String;

            Message = decryptedResulttt;
            DialogboxAlert(Message);
            return;
            // }
          }
        } else {
          //  Loader.hide();

          Message = "Server Failed....!";
          DialogboxAlert(Message);
          return;
        }
      } catch (error) {
        // Loader.hide();
        Message = "Server Failed....!";
        DialogboxAlert(Message);
        return;
      }
    } catch (e) {
      // Loader.hide();
      Message = "Unable to Connect to the Server";
      DialogboxAlert(Message);
      return;
    }
  }
}

class CardWidget extends StatelessWidget {
  final CREDITSVAEDATA item;
  final VoidCallback onPressed;

  const CardWidget({Key? key, required this.item, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF0057C2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              // Bank Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.BANKNAME.toString(),
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.CREDITCARDNUMBER.toString(),
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Pay',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
