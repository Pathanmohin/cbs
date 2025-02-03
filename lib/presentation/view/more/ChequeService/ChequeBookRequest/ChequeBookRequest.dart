// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/view/more/ChequeService/ChequeBookRequest/SuccessfullyScreen.dart';
import 'package:hpscb/presentation/view/more/ChequeService/Chequemenu.dart';

import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChequeBookRequest extends StatefulWidget {
  const ChequeBookRequest({super.key});

  @override
  State<StatefulWidget> createState() => _Chequebookrequest();
}

class _Chequebookrequest extends State<ChequeBookRequest> {
  List<Simple> fromAccount = [
    Simple(
      countryId: '1',
      label: '10',
   
    ),
    Simple(
      countryId: '2',
      label: '25',

    ),
    Simple(
      countryId: '2',
      label: '50',

    ),
    Simple(
      countryId: '2',
      label: '100',
 
    ),
    // Add more accounts as needed
  ];
  void onToAccount(String value) {}

  void ToAccount(String item) {}

  Future<bool> _onBackPressed() async {
    // Use Future.delayed to simulate async behavior
    await Future.delayed(const Duration(milliseconds: 1));

    // Perform the navigation
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Chequemenu()),
    );

    //context.pop(context);

    // Prevent the default back button behavior
    return false;
  }

  var toSelectedValue;
  var fromSelectedValue;

  String Message = "";

  final List<AccountFetchModel> toAccountList = AppListData.FromAccounts;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // ignore: deprecated_member_use
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
                "Cheque Book Request",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              leading: IconButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Chequemenu()),
                  // );

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Chequemenu()),
                  );
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
                        MaterialPageRoute(
                            builder: (context) => const Dashboard()),
                      );
                    },
                    child: Image.asset(
                      CustomImages.home,
                      width: 24.sp,
                      height: 24.sp,
                      color: Colors.white,
                    ),
                  ),
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

                                onToAccount(newValue!);
                              },
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "Cheque Number",
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
                                'Select Number Of Cheque Leaves',
                                style: TextStyle(
                                  color: Color(0xFF898989),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              isExpanded: true,
                              items: fromAccount.map((Simple obj) {
                                return DropdownMenuItem<String>(
                                  value: obj.label,
                                  child: Builder(builder: (context) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          textScaler:
                                              const TextScaler.linear(1.1)),
                                      child: Text(
                                        obj.label,
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

                                // if (toSelectedValue == "Mobile Number") {
                                //   setState(() {
                                //     showMobileField = true;
                                //     showMobile = false;
                                //   });
                                // } else {
                                //   setState(() {
                                //     showMobile = true;
                                //     showMobileField = false;
                                //   });
                                // }
                                // Call your method here, similar to SelectedIndexChanged
                                //onFromAccount(newValue);
                                fromSelectedValue(newValue);
                                // onToAccount(newValue!);
                              },
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
                          OnSubmit();
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
                                "SUBMIT",
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

  Dialgbox(String MESSAGE) async {
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

  DialogboxAlert(String message) async {
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

  Future<void> OnSubmit() async {
    if (fromSelectedValue == null || fromSelectedValue == "") {
      String AlertMessagee = "Please Select Account Number";
      await Dialgbox(AlertMessagee);
      return;
    }
    if (toSelectedValue == null || toSelectedValue == "") {
      String AlertMessage = "Please Select Number Of Cheque Book";
      await Dialgbox(AlertMessage);
      return;
    }

// Password Ency.
    // String md5Hash = Crypt().generateMd5(password);
    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    // API endpoint URL

    //String apiUrl = "rest/AccountService/issueChequeToAccNo";
    String apiUrl = ApiConfig.issueChequeToAccNo;

    String jsonString = jsonEncode({
      "accountNo": fromSelectedValue,
      "formquantity": toSelectedValue,
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

        if (responseData["availabledata"].toString() == "Success") {
          Loader.hide();

          List<dynamic> trends = [];
          trends.add(responseData);

          for (var item in trends) {
            var uniqueid = item['availabledata1'];

            final prefs = await SharedPreferences.getInstance();

            prefs.setString("uniqueid", uniqueid);

            //  print('Data: $uniqueid');
            // Assign uniqueid to your global variable or handle it accordingly
          }

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const successfullyChequeBook()),
          );

          // context.push('/successfullyChequeBook');
        } else {
          Loader.hide();
          Message = responseData["availabledata"].toString();
          await Dialgbox(Message);
          return;
        }
      } else {
        Loader.hide();
        Message = response.statusCode.toString();
        await Dialgbox(Message);
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
