// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/view/more/certificates/comp/comp.dart';
import 'package:hpscb/presentation/view/more/certificates/model/datamodel.dart';
import 'package:hpscb/presentation/view/more/certificates/savedata/savecertificatedata.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoanFinal extends StatefulWidget {
  const LoanFinal({super.key});
  @override
  State<StatefulWidget> createState() => _LoanFinalState();
}

class _LoanFinalState extends State<LoanFinal> {
  String startDate = "";
  String endDate = "";

  var totalIntrest = 0.0;

  List<TdssetModel> getlist = [];

  @override
  Widget build(BuildContext context) {
    getlist = CertificateDataSave.getloanList;

    String customerId = context.read<SessionProvider>().get('customerId');

    var size = MediaQuery.of(context).size;

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);

            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Interest Certificate",
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(CustomImages.rdnewimage),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text("Interest Certificate View",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF002E5B),
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: InkWell(
                            onTap: () async {
                              getDownloadPdf();
                            },
                            child: Container(
                                color: const Color(0xFF0057C2),
                                child: const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Text("Download",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      )),
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
                      const Text("Customer id",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text(customerId,
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
                  itemCount: getlist.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
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
                            Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: CompCertificate(
                                  title: 'Account Number:',
                                  dec: getlist[index].accno.toString(),
                                )),
                            CompCertificate(
                                title: 'Date:',
                                dec: getlist[index].trddatee.toString()),
                            CompCertificate(
                                title: 'Amount:',
                                dec: getlist[index].trdamtt.toString()),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: CompCertificate(
                                  title: 'Dr/Cr:',
                                  dec: getlist[index].trddrcrr.toString()),
                            )
                          ],
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

  void getDownloadPdf() {
    // String ip = ServerDetails().getIPaddress();
    // String port = ServerDetails().getPort();
    // String protocol = ServerDetails().getProtocol();

    try {
      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      //  String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

      // String accountNo = context.read<SessionProvider>().get('accountNo');
      String sessionId = context.read<SessionProvider>().get('sessionId');
      // String branchCode = context.read<SessionProvider>().get('branchCode');
      String customerId = context.read<SessionProvider>().get('customerId');
      String Accountnumber = CertificateDataSave.acc.toString();
      String restUrl = "";

      if (Accountnumber == "") {
        restUrl =
            "${ApiConfig.getintrestCertificatedownload}?accNo=0&fromDate=${CertificateDataSave.endDate}&toDate=${CertificateDataSave.toDate}&sessionID=$sessionId&userID=$userid&tokenNo=$tokenNo&custid=$customerId";
      } else {
        restUrl =
            '${ApiConfig.getintrestCertificatedownload}?accNo=${CertificateDataSave.acc.toString()}&fromDate=${CertificateDataSave.endDate}&toDate=${CertificateDataSave.toDate}&sessionID=$sessionId&userID=$userid&tokenNo=$tokenNo&custid=$customerId';
      }

      if (kDebugMode) {
        print(restUrl);
      }
      Uri pdfUrl = Uri.parse(restUrl);

      launchUrl(
        pdfUrl,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Builder(builder: (context) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.1)),
              child: AlertDialog(
                backgroundColor: AppColors.onPrimary,
                title: const Text('Alert', style: TextStyle(fontSize: 18)),
                content: Text('An error occurred: ${e.toString()}',
                    style: const TextStyle(fontSize: 18)),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK', style: TextStyle(fontSize: 18)),
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
}
