// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, deprecated_member_use, unused_local_variable, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/models/rechargemodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/BBPS/bbps.dart';
import 'package:hpscb/presentation/view/appdrawer/drawer.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/LPG_Booking/LPG_FetchBill.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LPG extends StatefulWidget {
  const LPG({super.key});

  @override
  State<StatefulWidget> createState() => _LPGBooking();
}

class UpperCaseTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class _LPGBooking extends State<LPG> {
  @override
  void initState() {
    GetLPGBillers();
    super.initState();
  }

  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtMobileNumber = TextEditingController();

  bool BalanceVisible = false;
  bool BillerNmae = false;
  String Billerkid = "";
  String BILLERID = "";
  String BILLERNAME = "";
  String AMOUNTENTER = "";
  String AccountBalance = "";
  String accountnumber = "";
  String RequestID = "";
  String BillAMOUNT = "";
  String bileriddd = "";
  String billerNamee = "";
  // bool BalanceVisible = false;
  // bool BillerNmae = false;
  String consumerName = "";

  String Customename = "";
  var ronak;
  List<LPGInfo> LPGInfoList = [];

  void onToAccount(String value) {
    OngetBalance(value);
    BalanceVisible = true;
  }

  void ToAccount(String item) {
    // Handle the selection change
    GetLPGBillerName();
    BillerNmae = true;
  }

  Future<bool> _onBackPressed() async {
    // Use Future.delayed to simulate async behavior
    await Future.delayed(const Duration(milliseconds: 1));

    // Perform the navigation
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BBPSConnect()),
    );

    // context.pop(context);

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

  var FromAccountNumber;
  var getBillerss;
  String getBillers = "";
  var GasBillerName;

  final List<AccountFetchModel> toAccountList = AppListData.FromAccounts;

  final List<Rechargmobile> fromAccountList = <Rechargmobile>[];

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
                "LPG Booking",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BBPSConnect()),
                  );

                 // Navigator.pop(context);

                  //
                  //  context.pop(context);
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
                              value: FromAccountNumber,
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
                                  FromAccountNumber = newValue!;
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
                          "Biller Name",
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
                            child: DropdownButton<Rechargmobile>(
                              dropdownColor: AppColors.onPrimary,
                              value: getBillerss,
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
                                return DropdownMenuItem<Rechargmobile>(
                                  value: obj,
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
                                  getBillerss = newValue!;
                                });
                                getBillers = newValue!.biller_id.toString();
                                billerNamee = newValue.biller_name.toString();

                                ToAccount(getBillers);
                              },
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: BillerNmae,
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
                        visible: BillerNmae,
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
                              inputFormatters: <TextInputFormatter>[
                                UpperCaseTextInputFormatter(),
                              ],
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
                          if (FromAccountNumber == null ||
                              FromAccountNumber == "") {
                            Message = "Please Select From Account";
                          await  DialogboxAlert(Message);
                            return;
                          } else if (getBillers == "") {
                            Message = "Please Select Biller";
                         await   DialogboxAlert(Message);
                            return;
                          } else if (txtAmount.text == "") {
                            Message = "Please Enter $Name";
                          await  DialogboxAlert(Message);
                            return;
                          }

                          //     Navigator.push(
                          //      context,
                          //       MaterialPageRoute(
                          // builder: (contex) =>
                          //     LPG_Fatch()));

                          OnLPGFatchBill();
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
                                "Fetch Bill",
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

  Future<void> GetLPGBillers() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      // Loader.show(context, progressIndicator: CircularProgressIndicator());

      // API endpoint URL
      String apiUrl = ApiConfig.getbilleroperator;
      //String apiUrl = "rest/AccountService/Getbilleroperator";

      String jsonString = jsonEncode({
        "billerCat": "LPG Gas",
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
          var Result = responseData["Result"].toString();
          var Dataall = responseData["data"];

          if (responseData["Result"].toString() == "Success") {
            List<dynamic> jsonResponse = jsonDecode(responseData["data"]);

            int all = 0;
            for (var config in jsonResponse) {
              Rechargmobile vObject = Rechargmobile();

              vObject.biller_id = config["biller_id"];
              vObject.biller_name = config["biller_name"];

              fromAccountList.add(vObject);
            }
          } else {
            Message = responseData["Message"].toString();
         await   DialogboxAlert(Message);
            return;
          }
        } else {
          // Loader.hide();
          Message = "Issue with Internet, Please try after few minutes";
        await  DialogboxAlert(Message);
          return;
        }
      } catch (error) {
        //  Loader.hide();

        Message = "Unable to Connect to the Server";
     await   DialogboxAlert(Message);
        return;
      }
    } catch (e) {
      Message = "Unable to Connect to the Server";
    await  DialogboxAlert(Message);
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
      // String apiUrl = "rest/AccountService/GetAccountBalance";

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

  Future<void> GetLPGBillerName() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
      // String? deviceId = await PlatformDeviceId.getDeviceId;

// Password Ency.
      // String md5Hash = Crypt().generateMd5("Bank@123");

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      // API endpoint URL

      String apiUrl = ApiConfig.billereducationvali;
      // String apiUrl = "rest/BBPSService/billereducationvali";

      String jsonString = jsonEncode({
        "billerId": getBillers,
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
          Loader.hide();
          Map<String, dynamic> responseData = jsonDecode(response.body);

          List<dynamic> paramNameList =
              jsonDecode(responseData["paramname"].toString());

          String? selectedParamName;
          for (var param in paramNameList) {
            if (param["paramName"] == "Registered Contact Number" ||
                param["paramName"] == "Mobile Number" ||
                param["paramName"] == "LPG_ID or Contact Number") {
              selectedParamName = param["paramName"];
              break; // Stop once the first match is found  LPG_ID or Contact Number
            }
          }
          setState(() {
            // txtAmount.text = a.toString();
            Name = selectedParamName ??
                'Neither Registered Contact Number nor Mobile Number found';
          });
        } else {
          Loader.hide();
          Message = "Server Failed....!";
       await   DialogboxAlert(Message);
          return;
        }
      } catch (error) {
        Loader.hide();
        Message = "Server Failed....!";
       await DialogboxAlert(Message);
        return;
      }
    } catch (e) {
      Loader.hide();
      Message = "Unable to Connect to the Server";
    await  DialogboxAlert(Message);
      return;
    }
  }

  Future<void> OnLPGFatchBill() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
      // String? deviceId = await PlatformDeviceId.getDeviceId;
      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

// Password Ency.
      //     String md5Hash = Crypt().generateMd5("Bank@123");

      String apiUrl = ApiConfig.lPGfetchbill;
      // String apiUrl = "rest/BBPSService/LPGfetchbill";

      String jsonString = jsonEncode({
        "Billerid": getBillers,
        "Circle": "",
        "mobileno": txtAmount.text,
        "paramvalue": txtAmount.text,
        "billercat": "LPG Gas",
        "ParamName": Name,
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
            var decryptedResult = responseData["Data"];

            Map<String, dynamic> billData =
                responseData["Data"][0]; // Accessing the first object in 'Data'

            // Storing requestId and billDate
            RequestID = billData["requestId"];
            Customename = billData["billDate"];

            consumerName = Customename.toString();

            // billAmount is double, so store it as double and convert to string
            double billamountApi = billData["billAmount"];
            BillAMOUNT = billamountApi.toString(); // Convert double to string

            final prefs = await SharedPreferences.getInstance();

            prefs.setString("BillerID", getBillers.toString());
            prefs.setString("consumerno", txtAmount.text);
            prefs.setString("AccountBalance", amount);
            prefs.setString("AccountNUMber", FromAccountNumber);
            prefs.setString("Billername", billerNamee.toString());
            prefs.setString("BillAMOUNT", BillAMOUNT.toString());
            prefs.setString("RequestID", RequestID.toString());

            prefs.setString("consmasjabd", consumerName.toString());

            Navigator.push(
                context, MaterialPageRoute(builder: (contex) => LPG_Fatch()));

            //  context.push('/LPG_Fatch');
          } else {
            Loader.hide();

            var decryptedResult = responseData["Data"] as List<dynamic>;
            var decryptedResultt = decryptedResult[0] as Map<String, dynamic>;

            String decryptedResulttt =
                decryptedResultt["errorMessage"] as String;

            Message = decryptedResulttt;
          await  DialogboxAlert(Message);
            return;
            // }
          }
        } else {
          Loader.hide();

          Message = "Server Failed....!";
        await  DialogboxAlert(Message);
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
    await  DialogboxAlert(Message);
      return;
    }
  }
}

class LPGInfo {
  String infoName;
  String description;

  LPGInfo({required this.infoName, required this.description});

  factory LPGInfo.fromJson(Map<String, dynamic> json) {
    return LPGInfo(
      infoName: json['infoName'],
      description: json['description'],
    );
  }
}
