// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, unused_local_variable

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/presentation/view/dashboard/payments/manage_beneficiary/addPayee/addpayee.dart';
import 'package:hpscb/presentation/view/dashboard/payments/manage_beneficiary/deletepayee/deletepayee.dart';
import 'package:hpscb/presentation/view/dashboard/payments/manage_beneficiary/model.dart';
import 'package:hpscb/presentation/view/dashboard/payments/manage_beneficiary/selfpayee/confirmpayee.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Manage extends StatefulWidget {
  const Manage({super.key});

  @override
  State<StatefulWidget> createState() => _ManageBenficiry();
}

class _ManageBenficiry extends State<Manage> {
  String Message = "";
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //  final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        // ignore: deprecated_member_use
        child: WillPopScope(
          onWillPop: () async {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
            // context.go('/dashboard');
            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                "Manage Beneficiary",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              backgroundColor: const Color(0xFF0057C2),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Dashboard()));
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
              leading: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Dashboard()));
                    // context.go('/dashboard');
                  },
                  icon: const Icon(Icons.arrow_back)),
              iconTheme: const IconThemeData(
                color: Colors.white,
                //change your color here
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20.0),
                    child: Container(
                        width: size.width,
                        height: 300,
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
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/wallet_to_bank_icon.png",
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 50,
                                    width: screenWidth * 0.70,
                                    color: const Color(0xFF0057C2),
                                    child: const Center(
                                        child: Text(
                                      "MANAGE BENEFICIARY",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 20.0),
                              child: Center(
                                  child: SizedBox(
                                width: 350,
                                height: 2,
                                child: Center(
                                    child: Container(
                                  color: Colors.black26,
                                )),
                              )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: InkWell(
                                onTap: () async {
                                  bool val = await Utils.netWorkCheck(context);

                                  if (val == false) {
                                    return;
                                  }
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddPayee()));

                                  // context.push('/AddPayee');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/images/hand_clicking_icon.png",
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        "ADD PAYEE",
                                        style: TextStyle(
                                            color: Color(0xFF0057C2),
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: InkWell(
                                onTap: () async {
                                  bool val = await Utils.netWorkCheck(context);

                                  if (val == false) {
                                    return;
                                  }
                                  FetchSelfAccounts();
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => ConfirmPayPage(js:JS)));
                                },
                                // ignore: avoid_unnecessary_containers
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/images/money_transactions_icon.png",
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      const Text("CONFIRM PAYEE",
                                          style: TextStyle(
                                              color: Color(0xFF0057C2),
                                              fontSize: 16)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: InkWell(
                                onTap: () async {
                                  bool val = await Utils.netWorkCheck(context);

                                  if (val == false) {
                                    return;
                                  }
                                  Deletepaye();
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => Deletepayee()));
                                },
                                // ignore: avoid_unnecessary_containers
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/images/money_transactions_icon.png",
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      const Text("PAYEE LIST",
                                          style: TextStyle(
                                              color: Color(0xFF0057C2),
                                              fontSize: 16)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<void> FetchSelfAccounts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    //String apiUrl = "rest/AccountService/fetchPayeeForConfirm";

    String apiUrl = ApiConfig.fetchPayeeForConfirm;

    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');
    String sessionId = context.read<SessionProvider>().get('sessionId');

    String jsonString = jsonEncode({
      "sessionID": sessionId,
      "userID": userid,
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

    try {
      // Make POST request
      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      // Check if request was successful
      if (response.statusCode == 200) {
        Loader.hide();
        Map<String, dynamic> responseData = jsonDecode(response.body);
        var a = responseData["Data"].toString();
        var b = responseData["Result"].toString();
        var data = AESencryption.decryptString(a, ibUsrKid);

        if (kDebugMode) {
          print(data);
        }

        var js = jsonDecode(data);

        List<dynamic> jsonResponse = jsonDecode(data);
        //List<week> trends = jsonResponse.map((e) => week.fromjson(e)).toList();

        var pendingMessages = (json.decode(data) as List)
            .map((i) => PendingMessage.fromJson(i))
            .toList();

        prefs.setString('PendingMessage', data);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ConfirmPayPage(
              pendingMessages: pendingMessages,
            ),
          ),
        );
      } else {
        Loader.hide();
        Message = "Server Failed....!";
        Dialgbox(Message);
      }
    } catch (error) {
      Loader.hide();
      Message = "Unable to Connect to the Server";
      Dialgbox(Message);
    }
  }

  Future<void> Deletepaye() async {
   // SharedPreferences prefs = await SharedPreferences.getInstance();

    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    

    //String apiUrl = "rest/AccountService/fetchPayeeForConfirm";

    String apiUrl = ApiConfig.fetchPayee;

    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');
    String sessionId = context.read<SessionProvider>().get('sessionId');

    String jsonString = jsonEncode({
      "mode" : "forDel",
      "sessionID": sessionId,
      "userID": userid,
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

    try {
      // Make POST request
      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      // Check if request was successful
      if (response.statusCode == 200) {
        Loader.hide();
        Map<String, dynamic> responseData = jsonDecode(response.body);
        var a = responseData["Data"].toString();
        var b = responseData["Result"].toString();
        var data = AESencryption.decryptString(a, ibUsrKid);

        if (kDebugMode) {
          print(data);
        }

        var js = jsonDecode(data);

        List<dynamic> jsonResponse = jsonDecode(data);
        //List<week> trends = jsonResponse.map((e) => week.fromjson(e)).toList();

        var pendingMessages = (json.decode(data) as List)
            .map((i) => Pending.fromJson(i))
            .toList();

        //prefs.setString('Pending', data);

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => Deletepayee()));

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Deletepayee(Pendingg: pendingMessages),
          ),
        );
      } else {
        Loader.hide();
        Message = "Server Failed....!";
       await Dialgbox(Message);
      }
    } catch (error) {
      Loader.hide();
      Message = "Unable to Connect to the Server";
     await Dialgbox(Message);
    }
  }

   Dialgbox(String MESSAGE) async{
   await showDialog(
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
                MESSAGE,
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
      },
    );
  }
}
