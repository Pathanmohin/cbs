// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fdrfdatasave/datasave.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/loan_against/loanfd/fdloanpage.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/view/tearmandcondition/term&condition.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class FDLoanFinalPage extends StatefulWidget {
  const FDLoanFinalPage({super.key});

  @override
  State<FDLoanFinalPage> createState() => _FDLoanFinalPageState();
}

class _FDLoanFinalPageState extends State<FDLoanFinalPage> {
  AccountFetchModel? toFdValue;
  List<AccountFetchModel> listFD = <AccountFetchModel>[];

  bool value = false;

  TextEditingController odAmount = TextEditingController();

  String savAccountNo = "";

  @override
  void initState() {
    super.initState();

    odAmount.text = FDLoanSave.maxamt.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (listFD.isEmpty) {
      listFD = AppListData.SavCA;
    }

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: WillPopScope(
          onWillPop: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoanFDPage()));
            // context.pop(context);

            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Loan Against FD",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              backgroundColor: const Color(0xFF0057C2),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()));
                      // ---------------------------------------------------------------------------------------------
                      // context.go('/dashboard');
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
              iconTheme: const IconThemeData(
                color: Colors.white,
                //change your color here
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
                child: Expanded(
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
                          padding: EdgeInsets.only(
                              top: 10.0, right: 20.0, left: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Maximum OD Limit",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF002E5B)),
                              ),
                              Text(
                                "OD Expiry Date",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF002E5B)),
                              )
                            ],
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
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 5.0, left: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    FDLoanSave.maxamt.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF002E5B)),
                                  ),
                                  Text(
                                    FDLoanSave.exdate.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF002E5B)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 10.0),
                          child: Text(
                            "OD Amount Required",
                            style: TextStyle(
                                color: Color(0xFF002E5B),
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
                              controller: odAmount,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                hintText: 'Enter OD Amount',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                prefixIcon: Icon(Icons
                                    .currency_rupee), // Add your desired icon here
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 10.0),
                          child: Text(
                            "Select Disbursement Account",
                            style: TextStyle(
                                color: Color(0xFF002E5B),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 8.0, bottom: 8.0),
                          child: Container(
                            margin: const EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  CustomImages.closefd,
                                  height: 32,
                                  width: 32,
                                ),
                                // ---------------------------------------------------------------------------------------------

                                const SizedBox(
                                    width:
                                        10), // Add some space between the icon and the dropdown
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<AccountFetchModel>(
                                      dropdownColor: AppColors.onPrimary,
                                      value: toFdValue,
                                      hint: const Text(
                                        'Select Disbursement A/C',
                                        style: TextStyle(
                                          color: Color(0xFF898989),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      icon: const Icon(Icons.arrow_drop_down),
                                      isExpanded: true,
                                      items:
                                          listFD.map((AccountFetchModel obj) {
                                        return DropdownMenuItem<
                                            AccountFetchModel>(
                                          value: obj,
                                          child: Builder(builder: (context) {
                                            return MediaQuery(
                                              data: MediaQuery.of(context)
                                                  .copyWith(
                                                      textScaler:
                                                          const TextScaler
                                                              .linear(1.1)),
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
                                          toFdValue = newValue;
                                        });
                                        // Call your method here, similar to SelectedIndexChanged
                                        selectFDAccount(newValue!);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: value,
                              onChanged: (v) {
                                setState(() {
                                  value = v!;
                                });
                              },
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TermsConditionPage()));
                                },
                                child: Wrap(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          constraints:
                                              BoxConstraints(maxWidth: 250),
                                          child: Text(
                                            "I Agree to All the Declaration terms and Conditions ",
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Color(0xFF0057C2),
                                              fontSize: 16,
                                            ),
                                            maxLines:
                                                2, // Limit the text to 2 lines
                                            overflow: TextOverflow
                                                .ellipsis, // Show ... if it's too long
                                          ),
                                        ),
                                        // Text(
                                        //   "and Conditions",
                                        //   style: TextStyle(
                                        //     decoration:
                                        //         TextDecoration.underline,
                                        //     color: Color(0xFF0057C2),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        InkWell(
                          onTap: () async {
                            fianlAPICallForFDLoan();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0,
                                left: 10.0,
                                right: 10.0,
                                bottom: 10.0),
                            child: Container(
                              height: 55,
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
                                      "AVAIL NOW",
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
        ),
      );
    });

    // Row(
    //   children: [
    //     Checkbox(
    //     value: this.value,
    //     onChanged: (v){
    //      setState(() {
    //        this.value = v!;
    //      });
    //     },
    //        ),

    //        InkWell(
    //         onTap: (){
    //           Navigator.push(context, MaterialPageRoute(builder: (context)=> TermsConditionPage()));
    //         },
    //         child: Flexible(child: Text("I Agree to All the Declaration terms and Conditions.",style: TextStyle( decoration: TextDecoration.underline,color: Color(0xFF0057C2),),))),
    //   ],
    // ),

    //   InkWell(
    //  onTap: () async {

    //  fianlAPICallForFDLoan();

    //     },
    //     child: Padding(
    //       padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
    //       child: Container(
    //         height: 55,
    //         decoration: BoxDecoration(
    //           color: const Color(0xFF0057C2),
    //           borderRadius: BorderRadius.circular(10),
    //         ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  Future<void> fianlAPICallForFDLoan() async {
    if (odAmount.text == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please  Enter OD Amount",
          );
        },
      );

      return;
    }

    if (savAccountNo == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Select Disbursement Account",
          );
        },
      );

      return;
    }

    if (value == false) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Accept Terms and Condition",
          );
        },
      );

      return;
    }

    if (double.parse(odAmount.text) >
        double.parse(FDLoanSave.maxamt.toString())) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description:
                "Loan Amount Can not be more then maximum Allowed Limit",
          );
        },
      );

      return;
    }

    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
      // ---------------------------------------------------------------------------------------------

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      //String apiUrl = "rest/AccountService/odfdLoanApp";

      String apiUrl = ApiConfig.odfdLoanApp;

      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

      // String branchCode = context.read<SessionProvider>().get('branchCode');
      // String customerId = context.read<SessionProvider>().get('customerId');
      // String accountNo = context.read<SessionProvider>().get('accountNo');

      String jsonString = jsonEncode({
        "accountno": FDLoanSave.accNo.toString(),
        "savAccNo": savAccountNo,
        "fdkid": FDLoanSave.kid.toString(),
        "maxlimit": FDLoanSave.maxamt.toString(),
        "availimit": odAmount.text,
        "maturitydate": FDLoanSave.exdate.toString(),
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

      // Make POST request

      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      try {
        if (response.statusCode == 200) {
          if (response.body != "") {
            String decrypt =
                AESencryption.decryptString(response.body, ibUsrKid);

            var res = jsonDecode(decrypt);

            // ignore: unrelated_type_equality_checks

            //res["Result"].toString().toLowerCase();

            if (res["Result"].toString().toLowerCase() == "success") {
              // var data = jsonDecode(decrypt);

              Loader.hide();

              await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Loan Disbursed Successfully. Loan A/C No:-",
                    description: res["Data"].toString(),
                  );
                },
              );

              // ---------------------------------------------------------------------------------------------

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Dashboard()));

              // context.go('/dashboard');
            } else {
              Loader.hide();
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: res["Data"].toString(),
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
              description: "Unable To connect Server",
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
            description: "Unable To connect Server",
          );
        },
      );
      return;
    }
  }

  // ignore: non_constant_identifier_names
  void selectFDAccount(AccountFetchModel AccountFetchModel) {
    savAccountNo = AccountFetchModel.textValue.toString();
  }
}
