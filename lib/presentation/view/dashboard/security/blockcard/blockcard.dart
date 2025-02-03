// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AtmDeactivation extends StatefulWidget {
  const AtmDeactivation({super.key});

  @override
  State<AtmDeactivation> createState() => _AtmDeactivationState();
}

class _AtmDeactivationState extends State<AtmDeactivation> {
  var fromSelectedValue;

  String? fromSelectedAcc;

  List<AccountFetchModel> fromAccountList = <AccountFetchModel>[];

  @override
  Widget build(BuildContext context) {
    fromAccountList = AppListData.FromAccounts;

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        // ignore: deprecated_member_use
        child: WillPopScope(
          onWillPop: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Dashboard()));
            return true;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "ATM",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              backgroundColor: AppColors.appBlueC,
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Dashboard()),
                  );

                  //context.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()));

                      //context.pop(context);
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
                    const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
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
                              items:
                                  fromAccountList.map((AccountFetchModel obj) {
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

                                onFromAccount(newValue!);
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 10.0),
                        child: InkWell(
                          onTap: () async {
                            bool val = await Utils.netWorkCheck(context);

                            if (val == false) {
                              return;
                            }

                            blockCardAPI();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
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
        ),
      );
    });
  }

  Future<void> blockCardAPI() async {
    if (fromSelectedAcc == "" || fromSelectedAcc == null) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Select From Account.",
          );
        },
      );

      return;
    }

    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      String apiUrl = ApiConfig.blockcard;

      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

      String branchCode = context.read<SessionProvider>().get('branchCode');
      String customerId = context.read<SessionProvider>().get('customerId');

      String jsonString = jsonEncode({
        "accountNo": branchCode + "-" + fromSelectedAcc.toString(),
        "userid": customerId,
      });

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
            var res = jsonDecode(response.body);

            if (res["Result"].toString().toLowerCase() == "success") {
              String Dencrypted =
                  AESencryption.decryptString(res["Data"], ibUsrKid);

              print(Dencrypted);

              var getMsg = jsonDecode(Dencrypted);

              if (getMsg.toString() == "Y") {
                Loader.hide();
                await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertBox(
                      title: "Congratulations",
                      description: "ATM Deactivated Successfully",
                    );
                  },
                );

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Dashboard()));

                return;
              } else {
                Loader.hide();

                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertBox(
                      title: "Alert",
                      description: "ATM Already Deactivated",
                    );
                  },
                );

                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => BlockCard()));

                return;
              }
            } else if (res["Result"].toString().toLowerCase() == "failure") {
              Loader.hide();
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: res["Message"],
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

  void onFromAccount(String value) {
    fromSelectedAcc = value;
  }
}
