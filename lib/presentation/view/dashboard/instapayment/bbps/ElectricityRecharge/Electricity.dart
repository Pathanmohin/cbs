// ignore_for_file: non_constant_identifier_names, deprecated_member_use, unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/models/rechargemodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/BBPS/bbps.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/ElectricityRecharge/Fetchbill.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final txtAmount = TextEditingController();

bool balance = false;
bool biller = false;
String Billerkid = "";

class Electricity extends StatefulWidget {
  const Electricity({super.key});

  @override
  State<StatefulWidget> createState() => _Electricity();
}

class _Electricity extends State<Electricity> {
  @override
  void initState() {
    //OnGeAvailableBalance();
    GetBiller();
    super.initState();
  }

  TextEditingController txtAmount = TextEditingController();

  TextEditingController txtMobileNumber = TextEditingController();

  bool balance = false;
  bool biller = false;
  String Billerkid = "";

  void onToAccount(String value) {
    // Handle the selection change
    // print('Selected value: $value');

    OngetBalance(value);
    balance = true;

    // setState(() {
    //   fromvalue = value;
    // });
  }

  void ToAccount(String item) {
    // Handle the selection change
    GetBillerName();
    biller = true;
    //print('Selected value: $item');
  }

  Future<bool> _onBackPressed() async {
    // Use Future.delayed to simulate async behavior
    await Future.delayed(const Duration(milliseconds: 1));

    // Perform the navigation
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BBPSConnect()),
    );

    // ignore: use_build_context_synchronously
    //Navigator.pop(context);

    // Prevent the default back button behavior
    return false;
  }

  String Message = "";
  String Alert = "";
  String Name = "";
  String AccountholderName = "";

  String amount = "";
  String fromvalue = "";

  var toSelectedValue;
  var fromSelectedValue;

  final List<AccountFetchModel> toAccountList = AppListData.FromAccounts;

  final List<Rechargmobile> fromAccountList = <Rechargmobile>[];
  List<String> Ronaknyariya = [];

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
                "Electricity",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
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
                              items: toAccountList.map((AccountFetchModel obj) {
                                return DropdownMenuItem<String>(
                                  value: obj.textValue,
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
                                // Call your method here, similar to SelectedIndexChanged
                                //onFromAccount(newValue);
                                //
                                //OngetBalance(fromSelectedValue);
                                onToAccount(newValue!);
                              },
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: balance,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Available Balance",
                                style: TextStyle(
                                    color: Color(0xFF0057C2),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Visibility(
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
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "Select Biller",
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
                                'Select Biller',
                                style: TextStyle(
                                  color: Color(0xFF898989),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              isExpanded: true,
                              items: fromAccountList.map((Rechargmobile obj) {
                                return DropdownMenuItem<String>(
                                  value: obj.biller_id,
                                  child: Builder(builder: (context) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          textScaler:
                                              const TextScaler.linear(1.1)),
                                      child: Text(
                                        "${obj.biller_name}",
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

                                ToAccount(newValue!);
                              },
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: biller,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                          child: Text(
                            Name,
                            style: const TextStyle(
                                color: Color(0xFF0057C2),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: biller,
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
                              controller: txtAmount,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight
                                      .bold // Set the color for the input text
                                  ),
                              decoration: InputDecoration(
                                hintText: Name,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (fromSelectedValue == null ||
                              fromSelectedValue == "") {
                            Message = "Please Select From Account";
                          await  DialogboxAlert(Message);
                            return;
                          } else if (toSelectedValue == null ||
                              toSelectedValue == "") {
                            Message = "Please Select Biller Name";
                          await  DialogboxAlert(Message);
                            return;
                          } else if (txtAmount.text == "") {
                            Message = "Please Enter $Name";
                          await  DialogboxAlert(Message);
                            return;
                          } 
                          OnFatchBill();
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
                            child: const Center(
                              child: Text(
                                "FETCH BILL",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
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
      }),
    );
  }

  void onFromAccount(String item) {
    if (kDebugMode) {
      print('Selected value: $item');
    }
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

  Future<void> GetBiller() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      // Loader.show(context, progressIndicator: CircularProgressIndicator());

      // API endpoint URL

      // String apiUrl = "rest/AccountService/Getbilleroperator";

      String apiUrl = ApiConfig.getbilleroperator;

      String jsonString = jsonEncode({
        "billerCat": "Electricity",
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
          // Loader.hide();
          Map<String, dynamic> responseData = jsonDecode(response.body);

          var b = responseData["Result"].toString();
          var js = responseData["data"];
          List<dynamic> jsonResponse = jsonDecode(responseData["data"]);

          int all = 0;
          for (var config in jsonResponse) {
            //var test[] = new AccountFetchModel();

            Rechargmobile vObject = Rechargmobile();

            vObject.biller_id = config["biller_id"];
            vObject.biller_name = config["biller_name"];

            //accounts.insert(all, vObject);
            fromAccountList.add(vObject);

            // all = all + 1;
          }
        } else {
          // Loader.hide();
          Message = "Server Failed....!";
         await DialogboxAlert(Message);
          return;
        }
      } catch (error) {
        //  Loader.hide();

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

  Future<void> OngetBalance(String item) async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
      // String? deviceId = await PlatformDeviceId.getDeviceId;

      // String apiUrl = "/rest/AccountService/GetAccountBalance";

      String apiUrl = ApiConfig.getAccountBalance;

      String jsonString = jsonEncode({
        "AccNo": item,
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
          //var data = jsonDecode(response.body);
          // Map<String, dynamic> jsonData = jsonDecode(response.body);
          var a = jsonDecode(responseData["Data"].toString());
          var b = responseData["Result"].toString();
          setState(() {
            amount = a.toString();
          });
        } else {
          Message = "Server Failed....!";
        await  DialogboxAlert(Message);
          return;
        }
      } catch (error) {
        Message = "Server Failed....!";
     await   DialogboxAlert(Message);
        return;
      }
    } catch (e) {
      Message = "Unable to Connect to the Server";
    await  DialogboxAlert(Message);
      return;
    }
  }

  Future<void> GetBillerName() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
      // String? deviceId = await PlatformDeviceId.getDeviceId;

// Password Ency.
      // String md5Hash = Crypt().generateMd5("Bank@123");

      //Loader.show(context, progressIndicator: CircularProgressIndicator());

      // API endpoint URL

      //String apiUrl = "rest/BBPSService/billervalidate";

      String apiUrl = ApiConfig.billervalidate;

      String jsonString = jsonEncode({
        "billerId": toSelectedValue,
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
          //var data = jsonDecode(response.body);
          // Map<String, dynamic> jsonData = jsonDecode(response.body);
          var a = responseData["paramname"].toString();
          //  var b = responseData["Result"].toString();
          setState(() {
            // txtAmount.text = a.toString();
            Name = a.toString();
          });
        } else {
          Message = "Server Failed....!";
       await   DialogboxAlert(Message);
          return;
        }
      } catch (error) {
        Message = "Server Failed....!";
      await  DialogboxAlert(Message);
        return;
      }
    } catch (e) {
      Message = "Unable to Connect to the Server";
    await  DialogboxAlert(Message);
      return;
    }
  }

  Future<void> OnFatchBill() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
      // String? deviceId = await PlatformDeviceId.getDeviceId;
      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

// Password Ency.
      // String md5Hash = Crypt().generateMd5("Bank@123");

      //String apiUrl = "rest/BBPSService/educationfetchbill";

      String apiUrl = ApiConfig.fetchBill;

      String jsonString = jsonEncode({
        "Billerid": toSelectedValue,
        "Circle": "",
        "mobileno": "7014133057",
        "paramvalue": txtAmount.text,
        "billercat": "Electricity",
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
          //var data = jsonDecode(response.body);
          // Map<String, dynamic> jsonData = jsonDecode(response.body);
          //  var a = responseData["Data"].toString());

          if (responseData["Result"] == "Sucess") {
            Loader.hide();
            var decryptedResult = responseData["Data"];
            Map<String, dynamic> billData = responseData["Data"][0];

            String billAmount = billData["billAmount"].toString();
            String requestId = billData["requestId"].toString();
            String DueDatee = billData["dueDate"].toString();
            String billDatee = billData["billDate"].toString();
            String billNumber = billData["billNumber"].toString();
            String customerName = billData["customerName"].toString().trim();
            String responseCode = billData["responseCode"].toString();
            String billPeriod = billData["billPeriod"].toString();

            DateFormat originalFormat = DateFormat('dd-MM-yyyy');
            DateFormat targetFormat = DateFormat('yyyy-MM-dd');

            DateTime originalDate = originalFormat.parse(DueDatee);
            String DueDate = targetFormat.format(originalDate);

            DateTime originalDatee = originalFormat.parse(billDatee);
            String billDate = targetFormat.format(originalDatee);

            final prefs = await SharedPreferences.getInstance();

            prefs.setString("BillAmount", billAmount);
            prefs.setString("CustomeName", customerName);
            prefs.setString("DueDate", DueDate);
            prefs.setString("BillDate", billDate);

            prefs.setString("BillNumnber", billNumber);
            prefs.setString("RequestID", requestId);
            prefs.setString("BillPeriod", billPeriod);
            prefs.setString("Premvalue", txtAmount.text);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FatchBillElectricity()),
            );
            // ignore: use_build_context_synchronously
            //  context.push('/FatchBillElectricity');
          } else {
            Loader.hide();

            var decryptedResult = responseData["Data"] as List<dynamic>;
            var decryptedResultt = decryptedResult[0] as Map<String, dynamic>;

            String decryptedResulttt =
                decryptedResultt["errorMessage"] as String;

            Message = decryptedResulttt;
       await     DialogboxAlert(Message);
            return;
            // }
          }
        } else {
          Loader.hide();

          Message = "Server Failed....!";
       await   DialogboxAlert(Message);
          return;
        }
      } catch (error) {
        Loader.hide();
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

class ElectrcityBill {
  final String billAmount;
  final String requestId;
  final String dueDate;
  final String billDate;
  final String billNumber;
  final String customerName;
  final String responseCode;
  final String billPeriod;

  ElectrcityBill({
    required this.billAmount,
    required this.requestId,
    required this.dueDate,
    required this.billDate,
    required this.billNumber,
    required this.customerName,
    required this.responseCode,
    required this.billPeriod,
  });
}

class Global {
  static String BiiAmount = "";
  static String BillCustomerName = "";
  static String BillDueDate = "";
  static String BillDate = "";
  static String BillNumber = "";
  static String BillID = "";
  static String billperr = "";
}

class ElectrcityBilll {
  final String errorMessage;

  ElectrcityBilll({
    required this.errorMessage,
  });
}

class Globall {
  static String errorMessage = "";
}
