// ignore_for_file: unused_local_variable, use_build_context_synchronously, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class SafetyTipsScreenView extends StatefulWidget {
  const SafetyTipsScreenView({super.key});
  @override
  State<StatefulWidget> createState() => SafetyTipsScreen();
}

class SafetyTipsScreen extends State<SafetyTipsScreenView> {
  @override
  void initState() {
    super.initState();

   // saftyTipssss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onPrimary,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Dashboard()),
            );

           // context.go("/dashboard");

          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title:  Text(
          'Safety Tips',
          style: TextStyle(color: Colors.white,fontSize: 16.sp),
        ),
        backgroundColor: const Color(0xFF0057C2),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () async {
              await _createAndSharePdf();
            },
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.1)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Image.asset(
                    'assets/images/logo1.png',
                    width: 80,
                    height: 80,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Mobile Banking related safety tips',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.appBlueC),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 20),
                    child: Text(
                      'Login Related related safety tips:',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.appBlueC),
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildBulletPoint(
                      'Create strong passwords that combine upper and lower case letters, numbers, and symbols.'),
                  buildBulletPoint(
                      'Always log out of your accounts when you are finished, especially on shared or public devices.'),
                  buildBulletPoint(
                      'USB Debugging Enabled We have detected USB Debugging mode is on. Please Switch it off.'),
                  buildBulletPoint(
                      'Suspicious Apps on your device.Remote access apps installed on your device can be used to steal the app information.'),
                  const SizedBox(height: 20),
                  const Text(
                    'Transaction Related Safety Tips:',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.appBlueC),
                  ),
                  const SizedBox(height: 10),
                  buildSubBulletPoint(
                      'Never Share OTP Password PIN and User Accounts Deatils Anyone.'),
                  buildSubBulletPoint(
                      'Always log out of your banking app after completing transactions.'),
                  buildSubBulletPoint(
                      'Always download banking apps from official app stores Avoid using third-party apps for mobile banking.'),
                  buildBulletPoint(
                      'Set daily transaction limits for your accounts to minimize losses in case of fraud.'),
                  const SizedBox(height: 20),
                  const Text(
                    'Bill Payments Related  Safety Tips ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.appBlueC),
                  ),
                  buildSubBulletPoint('Use Trusted Payment Methods.'),
                  buildSubBulletPoint('Use Virtual Cards for Online Payments.'),
                  buildBulletPoint(
                      'Use passwords, PINs, and biometric security features to protect the devices you use for bill payments.'),
                  buildBulletPoint('Double-Check Payment Amounts.'),
                  const SizedBox(height: 20),
                  const Text(
                    'FD RD Related Safety Tips:',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.appBlueC),
                  ),
                  buildBulletPoint(
                      'Only invest in FDs and RDs with well-established banks or financial institutions.'),
                  buildBulletPoint('Cross-Check Interest Rates.'),
                  buildBulletPoint(
                      'If you choose to auto-renew your FD or RD, keep track of maturity dates and verify renewal terms.'),
                  buildBulletPoint(
                      'Ensure your FD and RD accounts have the correct nominee details updated.'),
                  buildBulletPoint(
                      'Read the terms and conditions carefully to ensure there are no hidden charges or fees associated with your FD or RD accounts.'),
                ],
              ),
            ),
          );
        }
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 80,
            right: 16,
            child: FloatingActionButton(
              onPressed: () async {
                await _createAndSharePdf();
              },
              backgroundColor: const Color(0xFF0057C2),
              tooltip: 'Share PDF',
              child: const Icon(
                Icons.share,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () async {
                const url =
                    'https://play.google.com/store/apps/details?id=com.nscspl.mbanking';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url),
                      mode: LaunchMode.externalApplication);
                } else {
                  if (kDebugMode) {
                    print('Could not launch $url');
                  }
                }
              },
              backgroundColor: const Color(0xFF0057C2),
              tooltip: 'Open URL',
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 20)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSubBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 18)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _createAndSharePdf() async {
    final pdf = pw.Document(); // Create a new PDF document instance

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Mobile Banking Related Safety Tips',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'With Mobile Banking, your banking and financial transactions are at your fingertips. Here are some precautions for safe and secure mobile banking:',
              style: const pw.TextStyle(fontSize: 12),
            ),
            pw.SizedBox(height: 10),
            _buildPdfBulletPoint(
                'Set up a Pin/password to access the handset menu on your mobile phone.'),
            _buildPdfBulletPoint(
                'Register for SMS alerts to keep track of your banking transactions.'),
            _buildPdfBulletPoint(
                'Delete junk message and chain messages regularly.'),
            _buildPdfSubBulletPoint(
                'If you have to share your mobile with anyone else, clear the browsing history and cache.'),
            _buildPdfSubBulletPoint(
                'Block your mobile banking applications by contacting your bank.'),
            _buildPdfSubBulletPoint(
                'Do not store confidential information such as card numbers, CVV, or PINs.'),
            _buildPdfBulletPoint(
                'Install an effective mobile anti-malware/antivirus software.'),
            _buildPdfBulletPoint(
                'Keep your mobile’s operating system and applications updated with the latest security patches.'),
            _buildPdfBulletPoint(
                'Password-protect your mobile device to protect against unauthorized access.'),
            _buildPdfBulletPoint(
                'Turn off wireless device services like Wi-Fi, Bluetooth, and GPS when not in use.'),
            _buildPdfBulletPoint(
                'Avoid using unsecured Wi-Fi, public, or shared networks.'),
            _buildPdfBulletPoint(
                'Do not use "jailbroken" or "rooted" devices for online banking.'),
            _buildPdfBulletPoint(
                'Only download apps from official app stores.'),
            _buildPdfBulletPoint(
                'Never disclose personal information or online banking credentials via e-mail or text message.'),
            _buildPdfBulletPoint(
                'Log out from online mobile banking after completing your transactions.'),
            _buildPdfBulletPoint(
                'Be careful of shoulder surfers in public places.'),
            _buildPdfBulletPoint(
                'Always check for valid Encryption Certificates on websites before providing sensitive information.'),
            pw.SizedBox(height: 20),
            pw.Text(
              'SIM SWAP related safety tips:',
              style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
            ),
            _buildPdfSubBulletPoint(
                'Do not forward any message to your service provider till the new SIM is in your possession.'),
            _buildPdfSubBulletPoint(
                'Service provider will never ask for your 20-digit SIM number over call or SMS.'),
            _buildPdfSubBulletPoint(
                'Be vigilant and stay aware of your cellphone’s network connectivity status.'),
            _buildPdfSubBulletPoint(
                'Do not switch off your cellphone if you receive numerous annoying calls; contact your service provider.'),
            _buildPdfSubBulletPoint(
                'Register for Alerts when there is any activity on your bank account related to SIM change requests.'),
          ],
        ),
      ),
    );

    await _saveAndSharePdf(pdf);
  }

  pw.Widget _buildPdfBulletPoint(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Bullet(
        text: text,
        style: const pw.TextStyle(fontSize: 10),
      ),
    );
  }

  pw.Widget _buildPdfSubBulletPoint(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(left: 10),
      child: pw.Bullet(
        text: text,
        style: const pw.TextStyle(fontSize: 10),
      ),
    );
  }

  Future<void> _saveAndSharePdf(pw.Document pdf) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/Safety_Tips.pdf');
      await file.writeAsBytes(await pdf.save()); // Save the PDF
      await Share.shareXFiles([XFile(file.path)],
          text: 'Safety Tips PDF'); // Share the PDF
    } catch (e) {
      if (kDebugMode) {
        print('Error sharing file: $e');
      }
    }
  }

  Future<void> saftyTipssss() async {
    // String ip = ServerDetails().getIPaddress();
    // String port = ServerDetails().getPort();
    // String protocol = ServerDetails().getProtocol();
    //Loader.show(context, progressIndicator: CircularProgressIndicator());

    // String apiUrl = "$protocol$ip$port/rest/AccountService/fetchSafetytips";

    String apiUrl = ApiConfig.fetchSafetytips;

    String jsonString = jsonEncode({
      "category": "",
    });

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
    };

    final parameters = <String, dynamic>{
      "data": jsonString,
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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: AppColors.onPrimary,
              title: const Text("Safety Information"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    ListTile(
                      leading: Image.asset(
                        'assets/images/logo1.png', // Replace with an appropriate AnyDesk logo
                        height: 40,
                      ),
                      title: const Text("HPSCB"),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Safety Tips:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
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
