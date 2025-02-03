// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/liendatamodel.dart';
import 'package:hpscb/data/models/moreline.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/view/more/fdrdreciptprint/compFDRDView/fdrdComp.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FDView extends StatefulWidget {
  const FDView({super.key});

  @override
  State<FDView> createState() => _FDViewState();
}

class _FDViewState extends State<FDView> {
  @override
  Widget build(BuildContext context) {
    List<FdReceipt> dataShowList = SavaDataMore.fdListForView;

    var size = MediaQuery.of(context).size;

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        // ignore: deprecated_member_use
        child: WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop();
            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "FD Receipt",
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
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20.0),
                  child: Row(
                    children: [
                      Image.asset(CustomImages.rdnewimage),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text("FD Receipt View",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF002E5B),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Account Number",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text(SavaDataMore.accNoFDRe,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                  child: Center(
                      child: SizedBox(
                    width: size.width,
                    height: 2,
                    child: Center(
                        child: Container(
                      color: Colors.black26,
                    )),
                  )),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: dataShowList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FDRDViewComp(
                                title: 'Scheme Name:',
                                dec: dataShowList[index]
                                    .schcode
                                    .toString()
                                    .trim(),
                              ),
                              FDRDViewComp(
                                title: 'Serial No:',
                                dec: dataShowList[index]
                                    .fdistrsrno
                                    .toString()
                                    .trim(),
                              ),
                              FDRDViewComp(
                                title: 'Series:',
                                dec: dataShowList[index]
                                    .fdiseries
                                    .toString()
                                    .trim(),
                              ),
                              FDRDViewComp(
                                title: 'Date:',
                                dec: dataShowList[index]
                                    .fdidate
                                    .toString()
                                    .trim(),
                              ),
                              FDRDViewComp(
                                title: 'Amount:',
                                dec: dataShowList[index]
                                    .fdiamount
                                    .toString()
                                    .trim(),
                              ),
                              FDRDViewComp(
                                title: 'Int. Paid Amt:',
                                dec: dataShowList[index]
                                    .fdiintpaid
                                    .toString()
                                    .trim(),
                              ),
                              FDRDViewComp(
                                title: 'Maturity Date:',
                                dec: dataShowList[index]
                                    .fdimdate
                                    .toString()
                                    .trim(),
                              ),
                              FDRDViewComp(
                                title: 'Interest:',
                                dec: dataShowList[index]
                                    .fdiint
                                    .toString()
                                    .trim(),
                              ),
                              FDRDViewComp(
                                title: 'Maturity Amount:',
                                dec: dataShowList[index]
                                    .fdimamount
                                    .toString()
                                    .trim(),
                              ),
                              FDRDViewComp(
                                title: 'FD.TDS Amt:',
                                dec: dataShowList[index]
                                    .fditdsamt
                                    .toString()
                                    .trim(),
                              ),
                              InkWell(
                                onTap: () async {
                                  getDownloadPdf(
                                      dataShowList[index]
                                          .fdistrsrno
                                          .toString()
                                          .trim(),
                                      context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0,
                                      left: 10.0,
                                      right: 10.0,
                                      bottom: 10.0),
                                  child: Container(
                                    height: 50.sp,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0057C2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Download",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
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
                    );
                  },
                )),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> getDownloadPdf(String fdiseries, BuildContext context) async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

      // String apiUrl = "rest/AccountService/getFdseriescheck";

      String apiUrl = ApiConfig.getFdseriescheck;

      String jsonString =
          jsonEncode({"acc": SavaDataMore.accNoFDRe, "strno": fdiseries});

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

      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      try {
        if (response.statusCode == 200) {
          if (response.body != null || response.body == "") {
            // ignore: non_constant_identifier_names
            String Dencrypted =
                AESencryption.decryptString(response.body, ibUsrKid);

            var res = json.decode(Dencrypted);

            if (res["Result"].toString().toLowerCase() == "fail") {
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
                        description: res["Data"].toString(),
                      ),
                    );
                  });
                },
              );
            } else {
              Loader.hide();

              String userid = context.read<SessionProvider>().get('userid');
              String tokenNo = context.read<SessionProvider>().get('tokenNo');
              String sessionId =
                  context.read<SessionProvider>().get('sessionId');
              //String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

              String restUrl =
                  "${ApiConfig.getfdReceiptdownload}?acc=${SavaDataMore.accNoFDRe}&strno=$fdiseries&sessionID=$sessionId&userID=$userid&tokenNo=$tokenNo";

              Uri pdfUrl = Uri.parse(restUrl);

              launchUrl(
                pdfUrl,
                mode: LaunchMode.externalApplication,
              );
            }
          } else {
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
          }
        } else {
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
    }
  }
}
