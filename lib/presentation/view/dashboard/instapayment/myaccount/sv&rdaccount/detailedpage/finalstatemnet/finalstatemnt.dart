// ignore_for_file: use_build_context_synchronously, avoid_unnecessary_containers, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/myaccountmodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/myaccount/sv&rdaccount/detailedpage/detailmodel.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/theme/colors.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FinalStatement extends StatefulWidget {
  const FinalStatement({super.key});
  @override
  State<StatefulWidget> createState() => _FinalStatementState();
}

class _FinalStatementState extends State<FinalStatement> {
  @override
  Widget build(BuildContext context) {
    // List
    List<FinalDetailsStatement> dataShowList = FinalStatementData.getListFinal;

    var size = MediaQuery.of(context).size;

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Details Statement",
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
            backgroundColor: const Color(0xFF0057C2),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Dashboard()));

                    //    context.go("/dashboard");
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
          body: WillPopScope(
            onWillPop: () async {
              //  Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailsPage()));
              Navigator.pop(context);

              // context.pop(context);

              return false;
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/rdnewimage.png"),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text("Details Statement",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF002E5B),
                              ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: InkWell(
                            onTap: () async {
                              await getDownloadPdf();
                            },
                            child: Container(
                                width: 100,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: const Color(0xFF0057C2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Center(
                                      child: Text("Download",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ))),
                                ))),
                      ),
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
                      Text(SVModel.accNumber,
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
                  child: ListView.separated(
                    itemCount: dataShowList.length,
                    separatorBuilder: (context, index) => const Divider(
                        height: 1.0,
                        color:
                            Colors.grey), // Adjust height and color as needed
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 10.0, bottom: 5.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(dataShowList[index].trdDate.toString()),
                                  Text(
                                    dataShowList[index].trdamt.toString(),
                                    style: TextStyle(
                                        color: dataShowList[index].color),
                                  ),
                                ],
                              ),
                              Text(dataShowList[index].narration.toString()),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> getDownloadPdf() async {
    try {
      // Initialize dates if empty

      String fromPickDate = convertDateString(FinalStatementData.startDate);
      String toPickDate = convertDateString(FinalStatementData.endDate);

      if (fromPickDate.isEmpty) {
        fromPickDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
      }
      if (toPickDate.isEmpty) {
        toPickDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
      }

      // Show password hint dialog
      bool answer = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return Builder(builder: (context) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: AlertDialog(
                    backgroundColor: AppColors.onPrimary,
                    title: const Text(
                      'Password Hints:',
                      style: TextStyle(fontSize: 18),
                    ),
                    content: const Text(
                      'To Access the Detail Account Statement, Please Provide your Customer ID as the Password.',
                      style: TextStyle(fontSize: 18),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text(
                          'OK',
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      TextButton(
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  ),
                );
              });
            },
          ) ??
          true;

      if (!answer) {
        // Fetch server details
        // String ip = ServerDetails().getIPaddress();
        // String port = ServerDetails().getPort();
        // String protocol = ServerDetails().getProtocol();

        // Get application properties (Replace these with actual implementations)
        String passbookAccount = FinalStatementData.accNo;
        // Example account number
        String userid = context.read<SessionProvider>().get('userid');
        String tokenNo = context.read<SessionProvider>().get('tokenNo');
        String sessionId = context.read<SessionProvider>().get('sessionId');

        // Construct URL

        String restUrl =
            "${ApiConfig.minidetails}getDetailStatement?accNo=$passbookAccount&fromDate=$fromPickDate&toDate=$toPickDate&sessionID=$sessionId&userID=$userid&tokenNo=$tokenNo";

        print(restUrl);

        Uri pdfUrl = Uri.parse(restUrl);

        launchUrl(
          pdfUrl,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      // Handle exceptions
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Builder(builder: (context) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.1)),
              child: AlertDialog(
                backgroundColor: AppColors.onPrimary,
                title: Text(
                  'Alert',
                  style: TextStyle(fontSize: 16.sp),
                ),
                content: Text(
                  'An error occurred: ${e.toString()}',
                  style: TextStyle(fontSize: 16.sp),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'OK',
                      style: TextStyle(fontSize: 16.sp),
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
    }
  }

  String convertDateString(String dateStr) {
    // Correct the year part by taking the last 4 digits
    String correctedYear = dateStr.substring(0, dateStr.length);

    // Parse the corrected date string to a DateTime object
    DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(correctedYear);

    // Format the DateTime object to the desired format
    String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

    return formattedDate;
  }
}
