// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/withinbankquick.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/banktransfer/selftransfer/showcomp.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class SelfAccountShow extends StatefulWidget {
  const SelfAccountShow({super.key});

  @override
  State<StatefulWidget> createState() => _SelfAccountShowState();
}

class _SelfAccountShowState extends State<SelfAccountShow> {
  Future<bool> _onWillPop() async {
    return false;
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Builder(builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Summary",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              backgroundColor: const Color(0xFF0057C2),
              automaticallyImplyLeading: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()));

                      // context.go("/dashboard");
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
                    const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
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
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Transfer Successful",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.green),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0, left: 20),
                        child: ShowCompSelf(
                            title: "Reference ID : ",
                            valueComp: ShowSelfData.RefId),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0, left: 20.0),
                        child: ShowCompSelf(
                            title: "Mode : ", valueComp: ShowSelfData.Mode),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0, left: 20.0),
                        child: ShowCompSelf(
                            title: "Account : ",
                            valueComp: ShowSelfData.ToAccount),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0, left: 20.0),
                        child: ShowCompSelf(
                            title: "Amount : ", valueComp: ShowSelfData.Amount),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0, left: 20.0),
                        child: ShowCompSelf(
                            title: "From Account : ",
                            valueComp: ShowSelfData.FromAccount),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0, left: 20.0),
                        child: ShowCompSelf(
                            title: "Date : ", valueComp: ShowSelfData.Date),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0, left: 20.0),
                        child: ShowCompSelf(
                            title: "Remark : ", valueComp: ShowSelfData.Remark),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          await downloadPDF();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 50.sp,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0057C2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Download Receipt",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      isLoading
                          ? const CircularProgressIndicator()
                          : InkWell(
                              onTap: () async {
                                await sharePDF();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  height: 50.sp,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0057C2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Share Receipt",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard()));

                          //context.go('/dashboard');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 50.sp,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0057C2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Back To Home",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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

  // API CODE

  Future<void> downloadPDF() async {
    String refID = ShowSelfData.RefId;
    String Mode = ShowSelfData.Mode;
    String ToAccount = ShowSelfData.ToAccount;

    String lastFourDigits = ToAccount.substring(ToAccount.length - 4);
    String maskingToAccount = "XXXX-XXXX-$lastFourDigits";

    String Amount = ShowSelfData.Amount;

    String FromAccount = ShowSelfData.FromAccount;
    String lastFourDigitsFrom = FromAccount.substring(FromAccount.length - 4);
    String maskingFromAccount = "XXXX-XXXX-$lastFourDigitsFrom";

    String Date = ShowSelfData.Date;
    String Remark = ShowSelfData.Remark;

    // String ip = ServerDetails().getIPaddress();
    // String port = ServerDetails().getPort();
    // String protocol = ServerDetails().getProtocol();

    try {
      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      // String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

      // String branchCode = context.read<SessionProvider>().get('branchCode');
      // String customerId = context.read<SessionProvider>().get('customerId');
      //String accountNo = context.read<SessionProvider>().get('accountNo');

      String RestUrl =
          '${ApiConfig.transectionRiciptDownload}?RefrenceID=$refID&Mode=$Mode&toaccount=$maskingToAccount&Amount=$Amount&FromAccount=$maskingFromAccount&on=$Date&Remark=$Remark&userID=$userid&tokenNo=$tokenNo';

      Uri pdfUrl = Uri.parse(RestUrl);

      launchUrl(
        pdfUrl,
        mode: LaunchMode.externalApplication,
      );

      // await launchUrl(pdfUrl);
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
                  title: const Text(
                    'Alert',
                    style: TextStyle(fontSize: 18),
                  ),
                  content: Text(
                    "$e",
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
          });
      if (kDebugMode) {
        print('Exception: $e');
      }
      // Optionally, display an alert or handle the error as needed
    }
  }

  Future<void> sharePDF() async {
    setState(() {
      isLoading = true;
    });

    String refID = ShowSelfData.RefId;
    String Mode = ShowSelfData.Mode;

    String ToAccount = ShowSelfData.ToAccount;
    String lastFourDigits = ToAccount.substring(ToAccount.length - 4);
    String maskingToAccount = "XXXX-XXXX-$lastFourDigits";

    String Amount = ShowSelfData.Amount;

    String FromAccount = ShowSelfData.FromAccount;
    String lastFourDigitsFrom = FromAccount.substring(FromAccount.length - 4);
    String maskingFromAccount = "XXXX-XXXX-$lastFourDigitsFrom";

    String Date = ShowSelfData.Date;
    String Remark = ShowSelfData.Remark;

    // String ip = ServerDetails().getIPaddress();
    // String port = ServerDetails().getPort();
    // String protocol = ServerDetails().getProtocol();

    try {
      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');

      String RestUrl =
          '${ApiConfig.transectionRiciptDownload}?RefrenceID=$refID'
          '&Mode=$Mode'
          '&toaccount=$maskingToAccount'
          '&Amount=$Amount'
          '&FromAccount=$maskingFromAccount'
          '&on=$Date'
          '&Remark=$Remark'
          '&userID=$userid'
          '&tokenNo=$tokenNo';



      final response = await http.get(Uri.parse(RestUrl));

      if (response.statusCode == 200) {
        // Get the temporary directory
        final directory = await getTemporaryDirectory();

        // Create a file path for the PDF
        final filePath = '${directory.path}/self_account.pdf';
        // Write the PDF to the file
        final file = File(filePath);

        File fileShare = await file.writeAsBytes(response.bodyBytes);

        // Share the PDF
        Share.shareXFiles([XFile(fileShare.path)], text: 'Check out this PDF!');
      } else {
        throw Exception('Failed to load PDF');
      }
    } catch (e) {
      showDialog(
          // ignore: use_build_context_synchronously
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
                    "$e",
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
          });

      if (kDebugMode) {
        print(e);
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
