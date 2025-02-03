// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables, non_constant_identifier_names, deprecated_member_use

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/view/more/ChequeService/ChequeInquiry/SuccessScreen.dart';
import 'package:hpscb/presentation/view/more/ChequeService/Chequemenu.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChequeBookinquiry extends StatefulWidget {
  const ChequeBookinquiry({super.key});

  @override
  State<StatefulWidget> createState() => _Chequebookinquiry();
}

class _Chequebookinquiry extends State<ChequeBookinquiry> {
  @override
  void initState() {
    super.initState();
  }

  void onToAccount(String value) {}


  void ToAccount(String item) {}

  Future<bool> _onBackPressed() async {
    // Use Future.delayed to simulate async behavior
    await Future.delayed(const Duration(milliseconds: 1));

    // // Perform the navigation
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Chequemenu()),
    );

    //context.pop(context);

    // Prevent the default back button behavior
    return false;
  }

  TextEditingController txtChequenumber = TextEditingController();

  var toSelectedValue;
  var fromSelectedValue;
  String SDATE = "";
  String STATUS = "";
  String CHEQUENO = "";
  String ISSUE = "";
  String Message = "";

  final List<AccountFetchModel> toAccountList = AppListData.FromAccounts;

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
                "Cheque Book Inquiry",
                style: TextStyle(color: Colors.white,fontSize: 16.sp),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Chequemenu()),
                  );

//context.pop(context);

                },
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              backgroundColor: const Color(0xFF0057C2),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Dashboard()),
                      );
                     // context.go('/dashboard');
                      
                    },
                    child: Image.asset(
                    CustomImages.home,
                    width: 24.sp,
                    height: 24.sp,
                    color: Colors.white,
                  ),),
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
                          "Account Number",
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
                                'Select Account Number',
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
                                  child: Builder(
                                    builder: (context) {
                                      return MediaQuery(
                                            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.1)),
                                        child: Text(
                                          "${obj.textValue}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    }
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  fromSelectedValue = newValue!;
                                });

                                onToAccount(newValue!);
                              },
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 5.0, left: 10.0),
                        child: Text(
                          "Cheque No",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, right: 8.0),
                        child: SizedBox(
                          height: 52,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: txtChequenumber,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: 'Enter Cheque No',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
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
                          OnChequeBookinquiry();
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
                                "FIND STATUS",
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
   await showDialog(
    barrierDismissible: false,
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

  Future<void> OnChequeBookinquiry() async {
    if (fromSelectedValue == null || fromSelectedValue == "") {
      String AlertMessagee = "Please Select Account Number";
   await   Dialgbox(AlertMessagee);
      return;
    }
    // ignore: unnecessary_null_comparison
    if (txtChequenumber.text == null || txtChequenumber.text.toString() == "") {
      String AlertMessagee = "Please Enter Cheque Number";
    await  Dialgbox(AlertMessagee);
      return;
    }


// Password Ency.
    // String md5Hash = Crypt().generateMd5(password);
    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    // API endpoint URL

    //String apiUrl = "rest/AccountService/statusCheque";

    String apiUrl = ApiConfig.statusCheque;

    String jsonString = jsonEncode({
      "accountno": fromSelectedValue,
      "chequeNo": txtChequenumber.text,

      // "accountno": "34510101620",
      // "chequeNo": "983626",
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
        // Map<String, dynamic> responseData = jsonDecode(response.body);

        var responseData = jsonDecode(response.body);

        if (responseData['error'] != null) {
          Loader.hide();
          // _showAlert(responseData['error'].toString());

          Message = responseData['error'].toString();
        await  Dialgbox(Message);
          return;
        } else {
          Loader.hide();
          List<dynamic> trends = [];
          trends.add(responseData);

          for (var item in trends) {
            var issue = item['sIssuedOn'];
            var date = item['sDate'];
            var status = item['sStatus'];
            var chequeNo = item['schqNo'];
            SDATE = date;
            STATUS = status;
            CHEQUENO = chequeNo;
            ISSUE = issue;

            if (kDebugMode) {
              print('Data: $issue, $date, $status, $chequeNo');
            }
          }

          final prefs = await SharedPreferences.getInstance();

          prefs.setString("SDATE", SDATE);
          prefs.setString("STATUS", STATUS);
          prefs.setString("CHEQUENO", CHEQUENO);
          prefs.setString("ISSUE", ISSUE);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const chequeinquirysuccess()),
          );

//context.push('/chequeinquirysuccess');

        }
      } else {
        Loader.hide();
        Message = "Unable to Connect to the Server";
      await  Dialgbox(Message);
        return;
      }
    } catch (error) {
      Loader.hide();
      Message = error.toString();
     await Dialgbox(Message);
      return;
    }
  }
}
