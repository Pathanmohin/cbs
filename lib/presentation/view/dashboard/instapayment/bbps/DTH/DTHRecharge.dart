// ignore_for_file: non_constant_identifier_names, unused_local_variable, use_build_context_synchronously, unused_element, deprecated_member_use, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/config/constants.dart';
import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/models/rechargemodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/BBPS/bbps.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/DTH/SuccessfulltyScreen.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DTHRecharhemobile extends StatefulWidget {
  const DTHRecharhemobile({super.key});

  @override
  State<StatefulWidget> createState() => _DTHrecharge();
}

class _DTHrecharge extends State<DTHRecharhemobile> {
  @override
  void initState() {
    //OnGeAvailableBalance();
    GetBiller();
    super.initState();
  }

  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtenteramount = TextEditingController();

  TextEditingController txtMobileNumber = TextEditingController();
  bool balance = false;
  bool biller = false;
  bool Amount = false;
  bool amPay = false;
  String Billerkid = "";

  String billAmount = "";
  String billDate = "";
  String billNumber = "";
  String RequestID="";

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
                "DTH Recharge",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BBPSConnect()),
                  );

                  // Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              backgroundColor: const Color(0xFF0057C2),
              // actions: [
              //   GestureDetector(
              //     child: Container(
              //       color: Colors.white,
              //       height: 80,
              //       child: Padding(
              //         padding: const EdgeInsets.all(20),
              //         child: Image.asset(
              //           'assets/images/BBPS_Logo.png',
              //         ),
              //       ),
              //     ),
              //   ),
              // ],
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
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],

                              onChanged: (val){
                               
                                setState(() {
                                   amPay = false;
                                });
                              },

                              controller: txtAmount,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: Name,
                              ),
                            ),
                          ),
                        ),
                      ),

                         InkWell(
                        onTap: () async {

                          if (Name == "Customer Id" &&
                              txtAmount.text.length < 10) {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertBox(
                                  title: "Alert",
                                  description:
                                      "Please Enter Correct Customer Id",
                                );
                              },
                            );

                            return;
                          } else if (Name == "Mobile Number" &&
                              txtAmount.text.length < 10) {
                            await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertBox(
                                    title: "Alert",
                                    description:
                                        "Please Enter Correct Customer Id",
                                  );
                                });

                                return;
                          }

                          await FetchBill();
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


                      Visibility(
                        visible: amPay,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 10.0),
                          child: Text(
                            "Amount",
                            style: TextStyle(
                                color: Color(0xFF0057C2),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: amPay,
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
                              controller: txtenteramount,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "Enter Amount",
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: amPay,
                        child: InkWell(
                          onTap: () async {


                             if (fromSelectedValue == null ||
                              fromSelectedValue == "") {
                            Message = "Please Select From Account";
                           await DialogboxAlert(Message);
                            return;
                          } else if (toSelectedValue == null ||
                              toSelectedValue == "") {
                            Message = "Please Select Biller Name";
                           await DialogboxAlert(Message);
                            return;
                          } else if (txtAmount.text == "") {
                            Message = "Please Enter $Name";
                           await DialogboxAlert(Message);
                            return;
                          } else if (txtenteramount.text == "") {
                            Message = "Please Enter Amount";
                           await DialogboxAlert(Message);
                            return;
                          }

                          OnSubmitButton();
                        
                            // if (Name == "Customer Id" &&
                            //     txtAmount.text.length < 10) {
                            //   await showDialog(
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return AlertBox(
                            //         title: "Alert",
                            //         description:
                            //             "Please Enter Correct Customer Id",
                            //       );
                            //     },
                            //   );
                        
                            //   return;
                            // } else if (Name == "Mobile Number" &&
                            //     txtAmount.text.length < 10) {
                            //   await showDialog(
                            //       context: context,
                            //       builder: (BuildContext context) {
                            //         return AlertBox(
                            //           title: "Alert",
                            //           description:
                            //               "Please Enter Correct Customer Id",
                            //         );
                            //       });
                        
                            //       return;
                            // }
                        
                            // await FetchBill();
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
                                  "Pay",
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
      }),
    );
  }

  void onFromAccount(String item) {
    if (kDebugMode) {
      print('Selected value: $item');
    }
  }

  Dialgbox(String MESSAGE) async {
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

  Future<void> GetBiller() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      // Loader.show(context, progressIndicator: CircularProgressIndicator());

      // API endpoint URL

      //  String apiUrl = "rest/AccountService/Getbilleroperator";

      String apiUrl = ApiConfig.getbilleroperator;

      String jsonString = jsonEncode({
        "billerCat": "DTH",
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

  Future<void> OngetBalance(String item) async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
      // String? deviceId = await PlatformDeviceId.getDeviceId;

// Password Ency.
      //  String md5Hash = Crypt().generateMd5("Bank@123");

      //Loader.show(context, progressIndicator: CircularProgressIndicator());

      // API endpoint URL

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

  Future<void> GetBillerName() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
      // String? deviceId = await PlatformDeviceId.getDeviceId;

// Password Ency.
      String md5Hash = Crypt().generateMd5("Bank@123");

      //Loader.show(context, progressIndicator: CircularProgressIndicator());

      // API endpoint URL

      // String apiUrl = "rest/BBPSService/billervalidate";
      String apiUrl = ApiConfig.billervalidate;

      String jsonString = jsonEncode({
        "billerId": toSelectedValue,
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

  Future<void> _checkLatency() async {
    final stopwatch = Stopwatch()..start();

    try {
      var response = await http.get(Uri.parse('https://www.google.com/'));

      print(response.statusCode);

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
      // String? deviceId = await PlatformDeviceId.getDeviceId;

// Password Ency.
      String md5Hash = Crypt().generateMd5("Bank@123");

      //Loader.show(context, progressIndicator: CircularProgressIndicator());

      // API endpoint URL

      //   String apiUrl = "rest/BBPSService/PostpaidBillpay";
     // "http://183.83.177.224:7086/rest/BBPSService/PostpaidBillpay"


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
        //"customerMobile": txtAmount.text,
        "amount": txtenteramount.text,
        "billerId": toSelectedValue,
        "custConvFee": "",
        "ip": "",
        "customeraccountnumber": "",
        "Remark": "",
        "Custid": customerId,
        "userid": userid,
        "accNo": fromSelectedValue,
        "email": "",
        "date": "",
        "vendorId": "",
        "activityId": "",
        "mode": "",
        "type": "DTH",
        "custRole": "",
        "brnCode": branchCode,
        "mobile": "",
        "IFSC": branchIFSC.trim(),
        "paymentMode": "Internet Banking",
        "requestId": RequestID,
        "dueDate": "NA",
        "billDate": billDate,
        "billNumber": billNumber,
        "customerName": "NA",
        "billPeriod": "NA",
        "Paramvalue": txtAmount.text,
        "billAmount": txtenteramount.text,
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
          if (responseData["Result"] == "Sucess") {
            var decryptedResult = responseData["Data"];

            Map<String, dynamic> billData = responseData["Data"][0];

            String RespCustomerName = billData["RespCustomerName"].toString();
            String RespDueDate = billData["RespDueDate"].toString();
            String RespBillDate = billData["RespBillDate"].toString();
            String RespAmount = billData["RespAmount"].toString();
            String responseCode = billData["responseCode"].toString();
            String txnRespType = billData["txnRespType"].toString().trim();
            String responseReason = billData["responseReason"].toString();
            String RespBillNumber = billData["RespBillNumber"].toString();
            String txnRefId = billData["txnRefId"].toString();
            String approvalRefNumber = billData["approvalRefNumber"].toString();
            String RespBillPeriod = billData["RespBillPeriod"].toString();
            String CustConvFee = billData["CustConvFee"].toString();
            String RequestID = billData["requestId"].toString();

            DateFormat originalFormat = DateFormat('yyyy-MM-dd');
            DateFormat targetFormat = DateFormat('dd-MM-yyyy');

            DateTime originalDate = originalFormat.parse(RespDueDate);
            String RESPONSDUEDATE = targetFormat.format(originalDate);

            DateTime originalDatee = originalFormat.parse(RespBillDate);
            String RESPONSEBILLDATE = targetFormat.format(originalDatee);

            // String dob =
            //     DateFormat('yyyy-MM-dd').format(RespDueDate.toString());
            // String dob = DateFormat('yyyy-MM-dd').format(RespBillDate);

            final prefs = await SharedPreferences.getInstance();

            prefs.setString("RespCustomerName", RespCustomerName);
            prefs.setString("RespDueDate", RESPONSDUEDATE);
            prefs.setString("RespBillDate", RESPONSEBILLDATE);
            prefs.setString("RespAmount", RespAmount);
            prefs.setString("responseCode", responseCode);
            prefs.setString("txnRespType", txnRespType);
            prefs.setString("responseReason", responseReason);
            prefs.setString("RespBillNumber", RespBillNumber);
            prefs.setString("txnRefId", txnRefId);
            prefs.setString("approvalRefNumber", approvalRefNumber);
            prefs.setString("RespBillPeriod", RespBillPeriod);
            prefs.setString("CustConvFee", CustConvFee);
            prefs.setString("RequestID", RequestID);

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const DTHSuccessfully()));

            // context.push('/DTHSuccessfully');
          } else {
            var decryptedResult = responseData["Data"] as List<dynamic>;
            var decryptedResultt = decryptedResult[0] as Map<String, dynamic>;

            String decryptedResulttt =
                decryptedResultt["errorMessage"] as String;

            Message = decryptedResulttt;
         await   DialogboxAlert(Message);
            return;
          }
        } else {
          Message = "Server Failed....!";
        await  DialogboxAlert(Message);
          return;
        }
      } catch (error) {
        Message = "Server Failed....!";
      await  DialogboxAlert(Message);
        return;
      }
    } catch (e) {
      Message = "Unable to Connect to the Server";
     await DialogboxAlert(Message);
      return;
    }
  }

  Future<void> FetchBill() async {

  setState(() {
    amPay = false;
  });

    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
      // String? deviceId = await PlatformDeviceId.getDeviceId;

// Password Ency.
      String md5Hash = Crypt().generateMd5("Bank@123");

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      // API endpoint URL

      // String apiUrl = "rest/BBPSService/fetchbillvalidate";

      String apiUrl = ApiConfig.fetchbillvalidate;

      String jsonString = jsonEncode({
        "Billerid": toSelectedValue,
        "Circle": "",
        "paramvalue": txtAmount.text,
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
          // encoding: Encoding.getByName('utf-8'),
        );

        // Check if request was successful
        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = jsonDecode(response.body);
          //var data = jsonDecode(response.body);
          // Map<String, dynamic> jsonData = jsonDecode(response.body);
          // var a = jsonDecode(responseData["Data"].toString());
          var b = responseData["Result"].toString();
          if (responseData["Result"] == "Sucess") {
            Loader.hide();

            Map<String, dynamic> billData = responseData["Data"][0];

            String billAmount = billData["billAmount"].toString();
            String billDate = billData["billDate"].toString();
            String billNumber = billData["billNumber"].toString();
            RequestID = billData["Requestid"].toString();

            if (billAmount == "Successful") {
              amPay = true;
              setState(() {
                
              });
            }

          } else {
            Loader.hide();
            var decryptedResult = responseData["Data"] as List<dynamic>;
            var decryptedResultt = decryptedResult[0] as Map<String, dynamic>;

            String decryptedResulttt =
                decryptedResultt["errorMessage"] as String;

            Message = decryptedResulttt;

            await DialogboxAlert(Message);

            txtAmount.clear();
            return;
          }
        } else {
          Loader.hide();
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
      Loader.hide();
      Message = "Unable to Connect to the Server";
      await DialogboxAlert(Message);
      return;
    }
  }
}

class BillPayRequest {
  final String RespCustomerNamee;
  final String RespDueDatee;
  final String RespBillDatee;
  final String RespAmountt;
  final String responseCodee;
  final String txnRespTypee;
  final String responseReasonn;
  final String requestIdd;
  final String RespBillNumberr;
  final String txnRefIdd;
  final String approvalRefNumberr;
  final String RespBillPeriodd;
  final String CustConvFeee;

  BillPayRequest({
    required this.RespCustomerNamee,
    required this.RespDueDatee,
    required this.RespBillDatee,
    required this.RespAmountt,
    required this.responseCodee,
    required this.txnRespTypee,
    required this.responseReasonn,
    required this.requestIdd,
    required this.RespBillNumberr,
    required this.txnRefIdd,
    required this.approvalRefNumberr,
    required this.RespBillPeriodd,
    required this.CustConvFeee,
  });
}
