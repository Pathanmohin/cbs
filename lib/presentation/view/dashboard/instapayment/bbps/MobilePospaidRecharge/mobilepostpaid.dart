// ignore_for_file: override_on_non_overriding_member, non_constant_identifier_names, deprecated_member_use, prefer_typing_uninitialized_variables, unused_local_variable, use_build_context_synchronously

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
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/MobilePospaidRecharge/FatchBill.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostPaid extends StatefulWidget {
  const PostPaid({super.key});

  @override
  State<StatefulWidget> createState() => _RechargemobilePostPaid();
}

class _RechargemobilePostPaid extends State<PostPaid> {
  @override
  void initState() {
    OnGeAvailableBalance();
    super.initState();
  }

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

    if (kDebugMode) {
      print('Selected value: $item');
    }
  }

  Future<bool> _onBackPressed() async {
    // Use Future.delayed to simulate async behavior
    await Future.delayed(const Duration(milliseconds: 1));

    // // Perform the navigation
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => BBPS()),
    // );

    // Prevent the default back button behavior
    Navigator.pop(context);

    //context.pop(context);

    return false;
  }

  String Message = "";
  String Alert = "";
  String AccountholderName = "";

  String amount = "";
  String fromvalue = "";
  String Name = "Mobile number";

  var toSelectedValue;
  var fromSelectedValue;

  final List<AccountFetchModel> toAccountList = AppListData.FromAccounts;

  final List<Rechargmobile> fromAccountList = <Rechargmobile>[];
  List<String> Ronaknyariya = [];

  final txtName = TextEditingController();
  final txtBeneficiry = TextEditingController();
  final txtOTP = TextEditingController();

  final txtAmount = TextEditingController();

  final txtRemark = TextEditingController();
  final txtMobileNumber = TextEditingController();
  bool balance = false;
  String Billerkid = "";

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
                "Mobile PostPaid",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              leading: IconButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => BBPS()),
                  // );

                  //   context.pop(context);
                  Navigator.pop(context);
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
                          "Select Operator",
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
                                'Select Operator',
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
                      const Visibility(
                        child: Padding(
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
                              controller: txtMobileNumber,
                              style:
                                  const TextStyle(color: AppColors.onSurface),
                              decoration: const InputDecoration(
                                hintText: "Enter Mobile Number",
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              onFieldSubmitted: (value) {},
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (fromSelectedValue == null ||
                              fromSelectedValue == "") {
                            Message = "Please Select From Account";
                            DialogboxAlert(Message);
                            return;
                          } else if (toSelectedValue == null ||
                              toSelectedValue == "") {
                            Message = "Please Select Biller";
                            DialogboxAlert(Message);
                            return;
                          } else if (txtMobileNumber.text.length > 10 ||
                              txtMobileNumber.text.trim().length < 10) {
                            Message = "Please Enter 10 digits mobile number";
                            DialogboxAlert(Message);
                            return;
                          }
                         // String Amount = txtAmount.text;
                          String AvailableBalnce = amount;

                          List<String> parts = AvailableBalnce.split('.');
                          String integerPart = parts[0]; // "-12446"
                          String decimalPart = parts[1];

                          // int numberri = int.parse(Amount);
                          // int numberrr = int.parse(integerPart);
                          // if (numberri > numberrr) {
                          //   Message = "Insufficient Balance";
                          //   DialogboxAlert(Message);
                          //   return;
                          // }
                          FetchBill();
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

  void DialogboxAlert(String message) {
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

  Future<void> OnGeAvailableBalance() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      // Loader.show(context, progressIndicator: CircularProgressIndicator());

      // API endpoint URL

      String apiUrl = ApiConfig.getbilleroperator;

      String jsonString = jsonEncode({
        "billerCat": "Mobile Postpaid",
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
          // Loader.hide();
          Map<String, dynamic> responseData = jsonDecode(response.body);

          var b = responseData["Result"].toString();
          var js = responseData["data"];
          List<dynamic> jsonResponse = jsonDecode(responseData["data"]);

          int all = 0;
          for (var config in jsonResponse) {
            //var test[] = new AccountFetchModel();

            Rechargmobile vObject = new Rechargmobile();

            vObject.biller_id = config["biller_id"];
            vObject.biller_name = config["biller_name"];

            //accounts.insert(all, vObject);
            fromAccountList.add(vObject);

            // all = all + 1;
          }
        } else {
          // Loader.hide();

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
        //  Loader.hide();

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

  Future<void> FetchBill() async {
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

      String apiUrl = ApiConfig.fetchBill;

      String jsonString = jsonEncode({
        "Billerid": toSelectedValue,
        "Circle": "",
        "mobileno": txtMobileNumber.text,
        "paramvalue": txtMobileNumber.text,
        "billercat": "Mobile Postpaid",
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
          // var a = jsonDecode(responseData["Data"].toString());
          var b = responseData["Result"].toString();
          if (responseData["Result"] == "Sucess") {
            Loader.hide();
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
            prefs.setString("CustomerMobileNumber", txtAmount.text);
            prefs.setString("CustomeName", customerName);
            prefs.setString("DueDate", DueDate);
            prefs.setString("BillDate", billDate);
            prefs.setString("BillerID", toSelectedValue);

            prefs.setString("BillNumnber", billNumber);
            prefs.setString("RequestID", requestId);
            prefs.setString("BillPeriod", billPeriod);

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => FatchBill()));

            // context.push("/fatchbill");
          } else {
            Loader.hide();
            var decryptedResult = responseData["Data"] as List<dynamic>;
            var decryptedResultt = decryptedResult[0] as Map<String, dynamic>;

            String decryptedResulttt =
                decryptedResultt["errorMessage"] as String;

            Message = decryptedResulttt;
            DialogboxAlert(Message);
            return;
          }
        } else {
          Loader.hide();
          Message = "Server Failed....!";
          DialogboxAlert(Message);
          return;
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

  Future<void> OngetBalance(String item) async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
      // String? deviceId = await PlatformDeviceId.getDeviceId;

// Password Ency.
      String md5Hash = Crypt().generateMd5("Bank@123");

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
}
