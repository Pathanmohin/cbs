// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, use_build_context_synchronously, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/models/withinbankquick.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/banktransfer/selftransfer/selfaccountshow.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SelfTransfer extends StatefulWidget {
  const SelfTransfer({super.key});

  @override
  State<StatefulWidget> createState() => SelfTransferState();
}

class SelfTransferState extends State<SelfTransfer> {
  AccountFetchModel? toSelectedValue;
  var fromSelectedValue;

  String amount = "";

  String fromvalue = "";
  String toValue = "";

  bool _isVisible = false;

  void _toggleVisibility(bool val) {
    setState(() {
      _isVisible = val;
    });
  }

  TextEditingController am = TextEditingController();
  TextEditingController remark = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool _SetAmount = true;

  void _SetAmountVisibility(bool val) {
    setState(() {
      _SetAmount = val;
    });
  }

  bool _showOTPField = false;

  void _showOTPVisibility(bool val) {
    setState(() {
      _showOTPField = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<AccountFetchModel> toAccountList = AppListData.Allacc;

    List<AccountFetchModel> fromAccountList = AppListData.fromAccountList;

    var size = MediaQuery.of(context).size;

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title:  Text(
              "Self Linked Accounts",
              style: TextStyle(color: AppColors.onPrimary, fontSize: 16.sp),
            ),
            backgroundColor: const Color(0xFF0057C2),
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
                            items: fromAccountList.map((AccountFetchModel obj) {
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
                                fromSelectedValue = newValue;
                              });
                              // Call your method here, similar to SelectedIndexChanged
                              onFromAccount(newValue!);
                            },
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _isVisible,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, bottom: 10.0, left: 10.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Available Balance : ",
                                style: TextStyle(
                                    color: Color(0xFF0057C2),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            Text(
                              "\u{20B9} $amount",
                              style: const TextStyle(
                                  color: Color(0xFF0057C2),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        "To Account",
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
                          child: DropdownButton<AccountFetchModel>(
                            dropdownColor: AppColors.onPrimary,
                            value: toSelectedValue,
                            hint: const Text(
                              'To Account',
                              style: TextStyle(
                                color: Color(0xFF898989),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            icon: const Icon(Icons.arrow_drop_down),
                            isExpanded: true,
                            items: toAccountList.map((AccountFetchModel obj) {
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
                                toSelectedValue = newValue;
                              });

                              String? accType = newValue?.accountType;
                              String? accNo = newValue?.textValue;

                              // Call your method here, similar to SelectedIndexChanged
                              onToAccount(accNo, accType);
                            },
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
                        child: TextField(
                          controller: am,
                          enabled: _SetAmount,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                              hintText: "Enter your amount"),
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
                        child: TextField(
                          controller: remark,
                          decoration: const InputDecoration(
                            hintText: "Remark",
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (fromvalue == "") {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Builder(builder: (context) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(
                                      textScaler: const TextScaler.linear(1.1)),
                                  child: AlertDialog(
                                    backgroundColor: AppColors.onPrimary,
                                    title: const Text(
                                      'Alert',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    content: const Text(
                                      "Please Select From Account",
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

                          return;
                        } else if (toValue == "") {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Builder(builder: (context) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(
                                      textScaler: const TextScaler.linear(1.1)),
                                  child: AlertDialog(
                                    backgroundColor: AppColors.onPrimary,
                                    title: const Text(
                                      'Alert',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    content: const Text(
                                      "Please Select To Account",
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

                          return;
                        } else if (toValue == fromvalue) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Builder(builder: (context) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(
                                      textScaler: const TextScaler.linear(1.1)),
                                  child: AlertDialog(
                                    backgroundColor: AppColors.onPrimary,
                                    title: const Text(
                                      'Alert',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    content: const Text(
                                      "Same Account number cannot be debit and credit at a time..!",
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

                          return;
                        } else if (am.text == "") {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Builder(builder: (context) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(
                                      textScaler: const TextScaler.linear(1.1)),
                                  child: AlertDialog(
                                    backgroundColor: AppColors.onPrimary,
                                    title: const Text(
                                      'Alert',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    content: const Text(
                                      "Please enter amount",
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

                          return;
                        } else if (remark.text == "") {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Builder(builder: (context) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(
                                      textScaler: const TextScaler.linear(1.1)),
                                  child: AlertDialog(
                                    backgroundColor: AppColors.onPrimary,
                                    title: const Text(
                                      'Alert',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    content: const Text(
                                      "Please enter remark",
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
                          return;
                        }

                         otpController.text= "";
                        getOTP();

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
                      visible: _showOTPField,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Center(
                            child: Text(
                          "Enter the OTP",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    Visibility(
                      visible: _showOTPField,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                              hintText: "Please Enter OTP"),
                        ),
                      ),
                    ),


                    Visibility(
                      visible: _showOTPField,
                      child: InkWell(
                        onTap: () async {

                          if (otpController.text == "" ||
                              otpController.text == null) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Builder(builder: (context) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                        textScaler:
                                            const TextScaler.linear(1.1)),
                                    child: AlertDialog(
                                      backgroundColor: AppColors.onPrimary,
                                      title: const Text(
                                        'Alert',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      content: const Text(
                                        "Please enter OTP",
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

                            return;
                          }else if (otpController.text.length < 6 ){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Builder(builder: (context) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                        textScaler:
                                        const TextScaler.linear(1.1)),
                                    child: AlertDialog(
                                      backgroundColor: AppColors.onPrimary,
                                      title: const Text(
                                        'Alert',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      content: const Text(
                                        "Please Enter 6 Digit OTP",
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

                            return;

                          }

                          OnProcessClicked();
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
    OnGeAvailableBalance(item);
    _toggleVisibility(true);

    setState(() {
      fromvalue = item;
    });
  }

  void onToAccount(String? accNo, String? accType) {
    setState(() {
      toValue = accNo!;
    });

    if (accType == "RD Account") {
      getAmount(accNo);
      _SetAmountVisibility(false);
    } else {
      am.text = "";
      _SetAmountVisibility(true);
    }
  }

  Future<void> OnGeAvailableBalance(String item) async {
    try {
      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      // API endpoint URL

      //String apiUrl = "/rest/AccountService/GetAccountBalance";

      String apiUrl = ApiConfig.getAccountBalance;

      String jsonString = jsonEncode({
        "AccNo": item,
      });

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

      // Convert data to JSON

      // String encrypted =
      //     AESencryption.encryptString(jsonString, Constants.AESENCRYPTIONKEY);

      // final parameters = <String, dynamic>{
      //   "data": jsonString,
      // };

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
          //var data = jsonDecode(response.body);
          // Map<String, dynamic> jsonData = jsonDecode(response.body);
          var a = jsonDecode(responseData["Data"].toString());
          var b = responseData["Result"].toString();
          setState(() {
            amount = a.toString();
          });
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

// API Code............................................................

  Future<void> getAmount(String? value) async {
    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    //String apiUrl ="rest/AccountService/RDinstallmentdetails";

    String apiUrl = ApiConfig.rDinstallmentdetails;

    FromAccountRDDetails userInput = FromAccountRDDetails(
      Accno: value,
    );

    String jsonString = jsonEncode(userInput.toJson());

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonString,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode == 200) {
        Loader.hide();

        var data = response.body;

        if (data == "") {
          return;
        } else {
          // Decode the JSON response into a PaymentInfo object
          Map<String, dynamic> jsonMap = jsonDecode(data);
          PaymentInfo paymentInfo = PaymentInfo.fromJson(jsonMap);

          am.text = paymentInfo.installmentAmount;

          // Print the decoded values
          if (kDebugMode) {
            print('Year: ${paymentInfo.year}');
          }
          if (kDebugMode) {
            print('Month: ${paymentInfo.month}');
          }
          if (kDebugMode) {
            print('Days: ${paymentInfo.days}');
          }
          if (kDebugMode) {
            print('Period: ${paymentInfo.period}');
          }
          if (kDebugMode) {
            print('Installment Amount: ${paymentInfo.installmentAmount}');
          }
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

  Future<void> getOTP() async {
    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    //  String apiUrl = "$protocol$ip$port/rest/AccountService/sendOTP";

    String apiUrl = ApiConfig.sendOTP;

    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');
    String mobileNo = context.read<SessionProvider>().get('mobileNo');

    String sessionId = context.read<SessionProvider>().get('sessionId');

    OtpAccount userInput = OtpAccount(
        beneficiaryAccNo: toValue,
        userID: userid,
        purpose: "Fund Transfer",
        mobile: mobileNo,
        sessionID: sessionId);

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
      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      if (response.statusCode == 200) {
        Loader.hide();

        var data = jsonDecode(response.body);

        String decryptedResult =
            AESencryption.decryptString(data["Data"], ibUsrKid);

        var d = jsonDecode(decryptedResult);

        if (d["authorise"] == "success") {
          _showOTPVisibility(true);
          otpController.text = "";
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
                      "Please try again",
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

        //print("OTP data:" + decryptedResult);
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

  bool getValid(String value) {
    String valueCheck = value.toLowerCase();

    String d = "InSufficient Balance";

    if (valueCheck == d.toLowerCase()) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> OnProcessClicked() async {


    if (am.text == null || am.text == "") {
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
                    "Please enter Amount",
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
      return;
    } else if (remark.text == null) {
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
                    "Please enter Remark",
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
      return;
    } else if (otpController.text == null) {
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
                    "Please enter OTP",
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

      return;
    }

    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // String apiUrl = "rest/AccountService/fundTransferwithinBank";

    String apiUrl = ApiConfig.fundTransferwithinBank;

    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');
    String sessionId = context.read<SessionProvider>().get('sessionId');

    ProcessOTPSelf userInput = ProcessOTPSelf(
        beneficiaryAccNo: toValue,
        userID: userid,
        accNo: fromvalue,
        transferAmt: am.text,
        OTP: otpController.text,
        Remark: remark.text + "~ MB-SELF",
        sessionID: sessionId,
        latitude: prefs.getString('latitude').toString(),
        longitude: prefs.getString('longitude').toString(),
        address: prefs.getString('address').toString());

    String jsonString = jsonEncode(userInput.toJson());

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "tokenNo": tokenNo,
      "userID": userid,
    };

    String encrypted = AESencryption.encryptString(jsonString, ibUsrKid);

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

        if (response.body != "") {
          if (data["Result"] == "Success") {
            String decryptedResult =
                AESencryption.decryptString(data["Data"], ibUsrKid);

            var res = jsonDecode(decryptedResult);

            if (res["result"] == "success") {
              Loader.hide();

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
                            'Congratulations!!!!!!!!',
                            style: TextStyle(fontSize: 18),
                          ),
                          content: Text(
                            "Transaction Successfully Processed with ID:- ${res["transactionID"]}",
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
                  });

              ShowSelfData.RefId = res["transactionID"];
              ShowSelfData.Mode = "Self Account Transfer";
              ShowSelfData.ToAccount = toValue;
              ShowSelfData.Amount = am.text;
              ShowSelfData.FromAccount = fromvalue;

              var now = DateTime.now();

              String DateToday = "${now.day}-${now.month}-${now.year}";

              ShowSelfData.Date = DateToday;
              ShowSelfData.Remark = remark.text;

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SelfAccountShow()));
            } else if (res["result"].toString().toLowerCase() == "failure" &&
                res["transactionID"] == "-1" &&
                getValid(res["Error"])) {
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
                            'Alert!!!!!!!!',
                            style: TextStyle(fontSize: 18),
                          ),
                          content: Text(
                            "Transaction Failed,Error Message- ${res["Error"]}",
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
                  });

              otpController.text = "";
              return;
            } else if (res["result"].toString().toLowerCase() == "failure" &&
                res["Error"].toString().toLowerCase() ==
                    "OTP Mismatch".toLowerCase()) {
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
                            'Alert!!!!!!!!',
                            style: TextStyle(fontSize: 18),
                          ),
                          content: Text(
                            "Transaction Failed,Error Message- ${res["Error"]}",
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
                  });

              otpController.text = "";
              return;
            } else if (res["result"].toString().toLowerCase() == "failure" &&
                res["transactionID"] == "-1") {
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
                            'Alert!!!!!!!!',
                            style: TextStyle(fontSize: 18),
                          ),
                          content: Text(
                            "Transaction Failed,Error Message- ${res["Error"]}",
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
                  });

              otpController.text = "";
              return;
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
                            "Transaction Failed..!",
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
              otpController.text = "";
              return;
            }
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
                        content: Text(
                          "${data["Message"]}",
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
                });

            return;
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
                        "Server is not responding..!",
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

          return;
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
                      "Server is not responding..!",
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
        return;
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
          });
    }
  }
}
