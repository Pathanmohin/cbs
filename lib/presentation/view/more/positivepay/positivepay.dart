// ignore_for_file: prefer_final_fields, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PositivePay extends StatefulWidget {
  const PositivePay({super.key});

  @override
  State<StatefulWidget> createState() => _PositivePayState();
}

class _PositivePayState extends State<PositivePay> {
  AccountFetchModel? fromSelectedValue;

  List<AccountFetchModel> fromAccountList = [];

  String accNumber = "";

  TextEditingController cheque = TextEditingController();
  TextEditingController paying = TextEditingController();
  TextEditingController amount = TextEditingController();

  DateTime _selectedStartDate = DateTime.now();

  TextEditingController _dateStartController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateStartController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());

  fromAccountList = AppListData.Sav;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    Future<void> _selectStartDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedStartDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101),
      );

      if (picked != null) {
        setState(() {
          _selectedStartDate = picked;

          _dateStartController.text =
              DateFormat('dd-MM-yyyy').format(_selectedStartDate);
        });
      }
    }

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        // ignore: deprecated_member_use
        child: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);

            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Positive Pay",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              backgroundColor: const Color(0xFF0057C2),
              iconTheme: const IconThemeData(
                color: Colors.white,
                //change your color here
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, left: 8.0),
                        child: Text(
                          "Select Account Number",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, right: 8.0),
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
                              items:
                                  fromAccountList.map((AccountFetchModel obj) {
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
                                  fromSelectedValue = newValue;
                                });
                                // Call your method here, similar to SelectedIndexChanged
                                onFromAccount(newValue!);
                              },
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 20.0),
                        child: Text(
                          "Cheque Number",
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
                            controller: cheque,
                            inputFormatters: [
                                        LengthLimitingTextInputFormatter(9),
                                      
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],         
                            style:  const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: 'Enter Cheque Number',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 20.0),
                        child: Text(
                          "Paying Name",
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
                            keyboardType: TextInputType.text,
                            controller: paying,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: 'Enter Paying Name',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 20.0),
                        child: Text(
                          "Amount",
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
                            controller: amount,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: 'Enter Amount',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 20.0),
                        child: Text(
                          "Cheque Date",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                          child: SizedBox(
                            width: size.width * 0.9,
                            child: TextField(
                              readOnly: true,
                              controller: _dateStartController,
                              onTap: () => _selectStartDate(context),
                              decoration: const InputDecoration(
                                labelText: 'Cheque Date',
                                prefixIcon: Icon(Icons.calendar_today),
                              ),
                            ),
                          )),
                      InkWell(
                        onTap: () async {
                          callAPiFinal();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 10.0, right: 10.0, bottom: 20.0),
                          child: Container(
                            height: 50.sp,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0057C2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Add some spacing between the icon and the text
                                  Text(
                                    "PROCEED",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
        ),
      );
    });
  }

  // Select Account Number

  // ignore: non_constant_identifier_names
  void onFromAccount(AccountFetchModel AccountFetchModel) {
    accNumber = AccountFetchModel.textValue.toString();
  }

  Future<void> callAPiFinal() async {
    if (accNumber == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Select Account Number",
          );
        },
      );

      return;
    } else if (cheque.text == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Cheque Number",
          );
        },
      );

      return;
    } else if (paying.text == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Payee Name",
          );
        },
      );

      return;
    } else if (amount.text.toString() == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Amount",
          );
        },
      );

      return;
    } else {
      // DateTime datetime = DateTime.parse( _dateStartController.text);

      // String date = DateFormat('yyyy/MM/dd').format(datetime);

      String date = _dateStartController.text;

      // Parse the original date string
      DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(date);

      // Format the parsed date to the desired format
      String formattedDate = DateFormat("yyyy-MM-dd").format(parsedDate);

      //  "22-07-2024"

      getResponse(formattedDate);
    }
  }

  Future<void> getResponse(String date) async {

          Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();


      // String apiUrl =
      //     "rest/AccountService/positivePayConfirmation";

      String apiUrl = ApiConfig.positivePayConfirmation;

      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

      String jsonString = jsonEncode({
        "acc": accNumber.toString(),
        "chqno": cheque.text,
        "payeename": paying.text,
        "amount": amount.text.toString(),
        "chqdate": date,
      });

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "tokenNo": tokenNo,
        "userID": userid,
      };

      String encrypted = AESencryption.encryptString(jsonString, ibUsrKid);

      final parameters = <String, dynamic>{
        "data": encrypted,
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      try {
        if (response.statusCode == 200) {
          // ignore: unnecessary_null_comparison
          if (response.body != "" || response.body != null) {
            String dencrypted =
                AESencryption.decryptString(response.body, ibUsrKid);

            var res = jsonDecode(dencrypted);

            if (res["Result"].toString().toLowerCase() == "success") {
              Loader.hide();
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Success",
                    description: res["message"].toString(),
                  );
                },
              );

              return;
            } else {
              Loader.hide();
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: res["message"].toString(),
                  );
                },
              );

              return;
            }
          } else {
            Loader.hide();
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertBox(
                  title: "Alert",
                  description: "Server is not responding..!",
                );
              },
            );

            return;
          }
        } else {
          Loader.hide();
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: "Alert",
                description: "Server failed..!",
              );
            },
          );

          return;
        }
      } catch (e) {
        Loader.hide();
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertBox(
              title: "Alert",
              description: "Unable to Connect to the Server",
            );
          },
        );

        return;
      }
    } catch (e) {
      Loader.hide();
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Unable to Connect to the Server",
          );
        },
      );

      return;
    }
  }
}
