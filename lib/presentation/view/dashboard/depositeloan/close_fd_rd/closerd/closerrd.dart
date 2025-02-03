// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/close_fd_rd/closefdrd.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';

class CloserRD extends StatefulWidget {
  const CloserRD({super.key});

  @override
  State<StatefulWidget> createState() => _CloserRDState();
}

class _CloserRDState extends State<CloserRD> {
  AccountFetchModel? toRdValue;
  List<AccountFetchModel> listRD = <AccountFetchModel>[];

  AccountFetchModel? toSavAccount;
  List<AccountFetchModel> listSavAcclist = <AccountFetchModel>[];

  bool errorMsg = true;

  void getRDStatus(bool value) {
    setState(() {
      errorMsg = value;
    });
  }

  String accNo = "";
  String rdAcc = "";

  String ROIiiii = "";
  String CrrrentBalanceee = "";
  String ClosingBalanceee = "";
  String Interestpaiddd = "";
  String interestPayableee = "";
  String NetAmtTobePaiddd = "";
  String Penaltyyy = "";
  String chargeee = "";
  String intPayablee = "";
  String monthh = "";
  String balancee = "";
  String dayss = "";
  String tdsthistimee = "";
  String tdsDeductedd = "";

  @override
  Widget build(BuildContext context) {
 

    if (listRD.isEmpty) {
      listRD = AppListData.rd;
      listSavAcclist = AppListData.SACACC;

      if (listRD.isNotEmpty) {
        getRDStatus(false);
      }

      setState(() {});
    }

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "RD Closer Details",
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
            backgroundColor: const Color(0xFF0057C2),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Dashboard()));

                    // context.go('/dashboard');
                  },

//-----------------------------------------------------------------------------------

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
                  const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
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
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "Select RD Account",
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
//-----------------------------------------------------------------------------------

                              Image.asset(
                                CustomImages.closefd,
                                height: 32,
                                width: 32,
                              ),

                              const SizedBox(
                                  width:
                                      10), // Add some space between the icon and the dropdown
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<AccountFetchModel>(
                                    dropdownColor: AppColors.onPrimary,
                                    value: toRdValue,
                                    hint: const Text(
                                      'Select RD Account',
                                      style: TextStyle(
                                        color: Color(0xFF898989),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    icon: const Icon(Icons.arrow_drop_down),
                                    isExpanded: true,
                                    items: listRD.map((AccountFetchModel obj) {
                                      return DropdownMenuItem<
                                          AccountFetchModel>(
                                        value: obj,
                                        child: Builder(builder: (context) {
                                          return MediaQuery(
                                            data: MediaQuery.of(context)
                                                .copyWith(
                                                    textScaler:
                                                        const TextScaler.linear(
                                                            1.1)),
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
                                        toRdValue = newValue;
                                      });
                                      // Call your method here, similar to SelectedIndexChanged
                                      selectRDAccount(newValue!);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: errorMsg,
                        child: const Padding(
                          padding: EdgeInsets.only(
                              top: 2.0, right: 20.0, left: 20.0),
                          child: Text(
                            "RD Account Not Found",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.red),
                          ),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Interest Paid",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF002E5B)),
                            ),
                            Text(
                              "Net Amount Paid",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ROIiiii,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF002E5B)),
                                ),
                                Text(
                                  CrrrentBalanceee,
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
                        padding:
                            EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Charge",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF002E5B)),
                            ),
                            Text(
                              "Year",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ClosingBalanceee,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF002E5B)),
                                ),
                                Text(
                                  Interestpaiddd,
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
                        padding:
                            EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Penalty",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF002E5B)),
                            ),
                            Text(
                              "Noo Flate Dep",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  interestPayableee,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF002E5B)),
                                ),
                                Text(
                                  NetAmtTobePaiddd,
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
                        padding:
                            EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Current Balance",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF002E5B)),
                            ),
                            Text(
                              "ROI",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Penaltyyy,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF002E5B)),
                                ),
                                Text(
                                  chargeee,
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
                        padding:
                            EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Interest Payable",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF002E5B)),
                            ),
                            Text(
                              "Month",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  intPayablee,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF002E5B)),
                                ),
                                Text(
                                  monthh,
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
                        padding:
                            EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Balance",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF002E5B)),
                            ),
                            Text(
                              "Days",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  balancee,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF002E5B)),
                                ),
                                Text(
                                  dayss,
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
                        padding:
                            EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TDS This Time",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF002E5B)),
                            ),
                            Text(
                              "TDS Deducted",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tdsthistimee,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF002E5B)),
                                ),
                                Text(
                                  tdsDeductedd,
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
                          "Select Saving Account",
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
                              //-----------------------------------------------------------------------------------
                              Image.asset(
                                CustomImages.closefd,
                                height: 32,
                                width: 32,
                              ),

                              const SizedBox(
                                  width:
                                      10), // Add some space between the icon and the dropdown
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<AccountFetchModel>(
                                    dropdownColor: AppColors.onPrimary,
                                    value: toSavAccount,
                                    hint: const Text(
                                      'Select Saving A/C',
                                      style: TextStyle(
                                        color: Color(0xFF898989),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    icon: const Icon(Icons.arrow_drop_down),
                                    isExpanded: true,
                                    items: listSavAcclist
                                        .map((AccountFetchModel obj) {
                                      return DropdownMenuItem<
                                          AccountFetchModel>(
                                        value: obj,
                                        child: Builder(builder: (context) {
                                          return MediaQuery(
                                            data: MediaQuery.of(context)
                                                .copyWith(
                                                    textScaler:
                                                        const TextScaler.linear(
                                                            1.1)),
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
                                        toSavAccount = newValue;
                                      });
                                      // Call your method here, similar to SelectedIndexChanged
                                      selectSAAccount(newValue!);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
//-----------------------------------------------------------------------------------
                          bool val = await Utils.netWorkCheck(context);

                          if (val == false) {
                            return;
                          }

                          getFinalAPIRes();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
                          child: Container(
                            height: 50,
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
                                    "CLOSE RD",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<void> GetDetailRd() async {

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
//-----------------------------------------------------------------------------------


      //   String apiUrl = "rest/AccountService/preclosureRd";

      String apiUrl = ApiConfig.preclosureRd;

      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

      //String accountNo = context.read<SessionProvider>().get('accountNo');
      //String sessionId = context.read<SessionProvider>().get('sessionId');

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "tokenNo": tokenNo,
        "userID": userid,
      };

      String jsonString = jsonEncode(
          {"accountno": rdAcc, "requestype": "c", "savaccountno": "0"});

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
            var getData = response.body;

            String Dencrypted = AESencryption.decryptString(getData, ibUsrKid);

            var res = jsonDecode(Dencrypted);

            if (res["Result"].toString().toLowerCase() == "success") {
              //  showList = false;
              //  ll.clear();

              var dataget = jsonDecode(res["Data"]);

              var data = dataget[0];

              ROIiiii = data["intpaid"];

              CrrrentBalanceee = data["netAmtPaid"];

              ClosingBalanceee = data["charge"];

              Interestpaiddd = data["year"];

              interestPayableee = data["penalty"];

              NetAmtTobePaiddd = data["nooflateDep"];

              Penaltyyy = data["curBalance"];
              chargeee = data["roi"];

              intPayablee = data["intPayable"];
              monthh = data["month"];

              balancee = data["balance"];
              dayss = data["days"];

              tdsthistimee = data["tdsthistime"];
              tdsDeductedd = data["tdsDeducted"];

              Loader.hide();

              setState(() {});
            } else if (res["Result"].toString().toLowerCase() == "fail") {
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

  void selectRDAccount(AccountFetchModel AccountFetchModel) {
    rdAcc = AccountFetchModel.textValue.toString();

    GetDetailRd();
  }

  Future<void> getFinalAPIRes() async {
    if (rdAcc.isEmpty) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "RD Account Not Available",
          );
        },
      );
      return;
    }

    if (rdAcc == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Select RD Account",
          );
        },
      );
      return;
    }

    if (accNo == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Select Saving Account",
          );
        },
      );
      return;
    }

    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
//-----------------------------------------------------------------------------------
      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      //   String apiUrl = "rest/AccountService/preclosureRd";

      String apiUrl = ApiConfig.preclosureRd;

      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

      //  String apiUrl = "rest/AccountService/preclosureRd";

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "tokenNo": tokenNo,
        "userID": userid,
      };

      String jsonString = jsonEncode(
          {"accountno": rdAcc, "savaccountno": accNo, "requestype": "v"});

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
            var data = response.body.toString();

            String Dencrypted = AESencryption.decryptString(data, ibUsrKid);

            var res = jsonDecode(Dencrypted);

            if (res["Result"].toString().toLowerCase() == "success") {
              Loader.hide();
              await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Success",
                    description: res["Data"].toString(),
                  );
                },
              );
//-----------------------------------------------------------------------------------
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Dashboard()));

             // Navigator.pop(context);

              // context.pop(context);
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

  void selectSAAccount(AccountFetchModel AccountFetchModel) {
    accNo = AccountFetchModel.textValue.toString();
  }
}
