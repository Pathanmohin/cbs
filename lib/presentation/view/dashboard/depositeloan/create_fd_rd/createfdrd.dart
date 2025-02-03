// ignore_for_file: deprecated_member_use, use_build_context_synchronously, unused_local_variable

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fd/fd.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fdintrate/fdintrestrate.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fdrdmodel/model.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fdrfdatasave/datasave.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/rd/rdcreate.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CreateFDRD extends StatefulWidget {
  const CreateFDRD({super.key});

  @override
  State<CreateFDRD> createState() => _CreateFDRDState();
}

class _CreateFDRDState extends State<CreateFDRD> {
 List<FDOpening> fdlistS = <FDOpening>[];
  List<FDOpening> rdlistS = <FDOpening>[];

  List<InterestRate> interestList = <InterestRate>[];

  @override
  void initState() {
    super.initState();
     saftyTipssss(); // Uncomment if needed
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
        return false; // Prevent default back navigation
      },
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.1, // Adjust text scaling
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Create FD/RD",
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
            backgroundColor: const Color(0xFF0057C2),
            iconTheme: const IconThemeData(
              color: Colors.white, // Change icon color
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildButton(
                      context,
                      label: "FIXED DEPOSIT",
                      onTap: () async {
                        bool isConnected = await Utils.netWorkCheck(context);
                        if (isConnected) Onscheme();
                      },
                    ),
                    _buildButton(
                      context,
                      label: "RECURRING DEPOSIT",
                      onTap: () async {
                        bool isConnected = await Utils.netWorkCheck(context);
                        if (isConnected) OnRDscheme();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: InkWell(
                        onTap: () {
                          getIntrestRate();
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: const Text(
                            "View FD Interest Rate",
                            style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 19,
                              decoration: TextDecoration.underline,
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
  }

  Widget _buildButton(BuildContext context,
      {required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Container(
          height: 50.sp,
          decoration: BoxDecoration(
            color: const Color(0xFF0057C2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  CustomImages.fdrdcreate,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
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
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> Onscheme() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());
      // ---------------------------------------------------------------------------------------------

      // String apiUrl = "rest/AccountService/fetchFDScheme";

      String apiUrl = ApiConfig.fetchFDScheme;

      String jsonString = jsonEncode({
        "fdRd": "F",
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
          // ignore: unnecessary_null_comparison
          if (response.body != null) {
            var res = jsonDecode(response.body);

            if (res["Result"] == "Success") {
              fdlistS.clear();

              var decryptedResult = res["Data"];

              var data = json.decode(decryptedResult);

              for (int i = 0; i < data.length; i++) {
                FDOpening vObject = FDOpening();

                var getdata = data[i];

                vObject.mStateID = getdata["sch_code"];
                vObject.mStateName = getdata["sch_ename"];
                vObject.mStateCode = getdata["sch_kid"];
                vObject.timeperoid = getdata["fpr_ipp"];
                vObject.Defactkidfd = getdata["DefActKid"];

                fdlistS.add(vObject);
              }

              Loader.hide();

              FDList.fdlistS = fdlistS;
              // ---------------------------------------------------------------------------------------------

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FDCreate()));

//context.push('/fdcreate');
            } else {
              Loader.hide();

              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: res["Message"].toString(),
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

  // ignore: non_constant_identifier_names
  Future<void> OnRDscheme() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());
      // ---------------------------------------------------------------------------------------------

      // String apiUrl = "rest/AccountService/fetchFDScheme";

      String apiUrl = ApiConfig.fetchFDScheme;

      String jsonString = jsonEncode({
        "fdRd": "R",
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
          // ignore: unnecessary_null_comparison
          if (response.body != null) {
            var res = jsonDecode(response.body);

            if (res["Result"] == "Success") {
              rdlistS.clear();

              var decryptedResult = res["Data"];

              var data = json.decode(decryptedResult);

              for (int i = 0; i < data.length; i++) {
                FDOpening vObject = FDOpening();

                var getdata = data[i];

                vObject.mStateID = getdata["sch_code"];
                vObject.mStateName = getdata["sch_ename"];
                vObject.mStateCode = getdata["sch_kid"];
                vObject.timeperoid = getdata["fpr_ipp"];
                vObject.Defactkidfd = getdata["DefActKid"];

                rdlistS.add(vObject);
              }

              Loader.hide();

              FDList.rdListS = rdlistS;
              // ---------------------------------------------------------------------------------------------

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RDCreate()));

              // context.push('/rdCreate');
            } else {
              Loader.hide();

              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: res["Message"].toString(),
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

  Future<void> getIntrestRate() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      //  String apiUrl =  "rest/AccountService/getonlineintrestrate";
      // ---------------------------------------------------------------------------------------------

      String apiUrl = ApiConfig.getonlineintrestrate;

      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

      // String branchCode = context.read<SessionProvider>().get('branchCode');
      String customerId = context.read<SessionProvider>().get('customerId');
      String accountNo = context.read<SessionProvider>().get('accountNo');

      String jsonString = jsonEncode({
        "custID": customerId,
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
            var data = jsonDecode(response.body);

            if (data["Result"].toString().toLowerCase() == "success") {
              var res = jsonDecode(data["Data"]);

              for (int i = 0; i < res.length; i++) {
                InterestRate vObject = InterestRate();

                var getList = res[i];

                vObject.fdintRoiii = getList["fdintroi"].toString();
                vObject.fdprdLdaysss = getList["fdprdlprd"].toString();
                vObject.fdprdUdaysss = getList["fdprduprd"].toString();

                interestList.add(vObject);
              }

              IntRateList.intListShow = interestList;

              // ---------------------------------------------------------------------------------------------
              Loader.hide();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FDInterestRate()));

              // context.push('/fdIntersetRate');
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

  Future<void> saftyTipssss() async {
    // String ip = ServerDetails().getIPaddress();
    // String port = ServerDetails().getPort();
    // String protocol = ServerDetails().getProtocol();
    //Loader.show(context, progressIndicator: CircularProgressIndicator());
    // ---------------------------------------------------------------------------------------------

    //String apiUrl = "rest/AccountService/fetchSafetytips";

    String apiUrl = ApiConfig.fetchSafetytips;

    String jsonString = jsonEncode({
      "category": "FD&RD",
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
        Map<String, dynamic> responseData = jsonDecode(response.body);

        // Access the first item in the list and its safety_remark field
        var data = jsonDecode(responseData["Data"].toString());

        // Access the first item in the list and its safety_remark field
        var safetyRemark = data[0]["safety_remark"];
        var safetyKid = data[0]["safety_kid"];
        var safetyCategory = data[0]["safety_category"];

        // Show the response data in a popup
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return Builder(builder: (context) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.1)),
                child: AlertDialog(
                  backgroundColor: AppColors.onPrimary,
                  title: const Text("Safty Information"),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        // ---------------------------------------------------------------------------------------------

                        ListTile(
                          leading: Image.asset(
                            'assets/images/logo1.png', // Replace with an appropriate AnyDesk logo
                            height: 40,
                          ),
                          title: const Text("HPSCB"),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "FD&RD Related Safty Tips:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          safetyRemark,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        'OK',
                        style: TextStyle(fontSize: 17, color: Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            });
          },
        );
      } else {
        if (kDebugMode) {
          print('Failed to get response');
        }
      }
    } catch (error) {
      // Loader.hide();

      return;
    }
  }
}
