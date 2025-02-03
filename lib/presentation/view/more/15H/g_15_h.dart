// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/more/moreoptions.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class G15H15 extends StatefulWidget {
  const G15H15({super.key});
  @override
  State<StatefulWidget> createState() => _G15H15State();
}

enum SingingCharacter { G, H, hya }

class _G15H15State extends State<G15H15> {
  SingingCharacter? _character = SingingCharacter.G;

  String selectSwitch = "15G";

  AccountFetchModel? fromSelectedValue;

  List<AccountFetchModel> fromAccountList = AppListData.fd;

  String accNumber = "";

  TextEditingController pan = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController status = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: WillPopScope(
          onWillPop: () async {
            // context.pop(context);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MoreOptions()),
            );

            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Form 15G/15H",
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
                padding: const EdgeInsets.all(20.0),
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
                        padding: EdgeInsets.only(top: 10.0, left: 20.0),
                        child: Text(
                          "Select Form Type",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          '15G',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.G,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;

                              selectSwitch = "15G";
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          '15H SEN CITIZEN',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.H,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;

                              selectSwitch = "15H SEN CITIZEN";
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          '15H(80YRS > AGE60TO)',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.hya,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                              selectSwitch = "15H(80YRS > AGE60TO)";
                            });
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 20.0),
                        child: Text(
                          "Account Number",
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
                          "Pan Card",
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
                            readOnly: true,
                            controller: pan,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: 'Pan Card',
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
                          "Date Of Birth",
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
                            controller: dob,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: 'Date Of Birth',
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
                          "Status",
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
                            controller: status,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: 'Status',
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

                          if (accNumber == "") {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Builder(builder: (context) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                        textScaler:
                                            const TextScaler.linear(1.1)),
                                    child: AlertBox(
                                      title: "Alert",
                                      description:
                                          "Please Select Account Number",
                                    ),
                                  );
                                });
                              },
                            );

                            return;
                          }

                          finalAPIForm15G15H();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 10.0, right: 10.0, bottom: 20.0),
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0057C2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Add some spacing between the icon and the text
                                  const Text(
                                    "CONTINUE",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Image.asset("assets/images/next.png"),
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

  // ignore: non_constant_identifier_names
  void onFromAccount(AccountFetchModel AccountFetchModel) {
    accNumber = AccountFetchModel.textValue.toString();

    getAllData();
  }

  Future<void> getAllData() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      //String apiUrl = "rest/AccountService/passAccDetail";

      String apiUrl = ApiConfig.passAccDetail;

      String jsonString = jsonEncode({
        "sAccno": accNumber.toString(),
      });

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonString,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      try {
        if (response.statusCode == 200) {
          if (response.body != "") {
            var res = jsonDecode(response.body);

            if (kDebugMode) {
              print(res);
            }

            // ignore: unused_local_variable
            String cusid = res["Custid"].toString();

            String dateGet = res["dob"].toString();

            DateTime dateTime = DateTime.parse(dateGet);

            dob.text = DateFormat('dd-MM-yyyy').format(dateTime);

            pan.text = res["pan"].toString();
            status.text = res["custtype"].toString().toUpperCase();

            setState(() {});

            Loader.hide();
          } else {
            Loader.hide();
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return Builder(builder: (context) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: const TextScaler.linear(1.1)),
                    child: AlertBox(
                      title: "Alert",
                      description: "Server failed..!",
                    ),
                  );
                });
              },
            );

            return;
          }
        } else {
          Loader.hide();
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return Builder(builder: (context) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.1)),
                  child: AlertBox(
                    title: "Alert",
                    description: "Unable to Connect to the Server",
                  ),
                );
              });
            },
          );

          return;
        }
      } catch (e) {
        Loader.hide();
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return Builder(builder: (context) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.1)),
                child: AlertBox(
                  title: "Alert",
                  description: "Unable to Connect to the Server",
                ),
              );
            });
          },
        );

        return;
      }
    } catch (e) {
      Loader.hide();
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Builder(builder: (context) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.1)),
              child: AlertBox(
                title: "Alert",
                description: "Unable to Connect to the Server",
              ),
            );
          });
        },
      );

      return;
    }
  }

  Future<void> finalAPIForm15G15H() async {
    String selectButton = "";

    if (selectSwitch == "15G") {
      selectButton = "3";
    } else if (selectSwitch == "15H SEN CITIZEN") {
      selectButton = "3";
    } else if (selectSwitch == "15H(80YRS > AGE60TO)") {
      selectButton = "1";
    }

    try {
      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      //  String apiUrl = "rest/AccountService/submission15GH";

      String apiUrl = ApiConfig.submission15GH;

      String jsonString = jsonEncode({
        "formType": selectButton,
        "sAccno": accNumber.toString(),
      });

      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

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
          if (response.body != "") {
            String dencrypted =
                AESencryption.decryptString(response.body, ibUsrKid);

            var data = jsonDecode(dencrypted);

            if (kDebugMode) {
              print(dencrypted);
            }

            Loader.hide();

            if (data["availabledata"] != null) {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: data["availabledata"].toString(),
                  );
                },
              );

              accNumber = "";
              dob.text = "";
              pan.text = "";
              status.text = "";

              AccountFetchModel? setData;

              fromSelectedValue = setData;

              return;
            } else {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Builder(builder: (context) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(textScaler: const TextScaler.linear(1.1)),
                      child: AlertBox(
                        title: "Success",
                        description: "Your Request have send Successfully",
                      ),
                    );
                  });
                },
              );

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MoreOptions()));

              // context.pop(context);
            }
          } else {
            Loader.hide();
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return Builder(builder: (context) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: const TextScaler.linear(1.1)),
                    child: AlertBox(
                      title: "Alert",
                      description: "Server is not responding..!",
                    ),
                  );
                });
              },
            );

            return;
          }
        } else {
          Loader.hide();
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return Builder(builder: (context) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.1)),
                  child: AlertBox(
                    title: "Alert",
                    description: "Server failed..!",
                  ),
                );
              });
            },
          );

          return;
        }
      } catch (e) {
        Loader.hide();
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return Builder(builder: (context) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.1)),
                child: AlertBox(
                  title: "Alert",
                  description: "Unable to Connect to the Server",
                ),
              );
            });
          },
        );

        return;
      }
    } catch (e) {
      Loader.hide();
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Builder(builder: (context) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.1)),
              child: AlertBox(
                title: "Alert",
                description: "Unable to Connect to the Server",
              ),
            );
          });
        },
      );

      return;
    }
  }
}
