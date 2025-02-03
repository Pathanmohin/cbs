// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/presentation/view/appdrawer/faq/faq.dart';
import 'package:hpscb/presentation/view/appdrawer/profileview/profileview.dart';
import 'package:hpscb/presentation/view/appdrawer/profileview/safty_tips.dart';
import 'package:hpscb/presentation/view/auth/login_view.dart';

import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/domain/entities/logindatasave.dart';
import 'package:hpscb/presentation/viewmodel/drawerprovider/drawer_viewmodel.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class DrawerView extends StatelessWidget {
  DrawerView({super.key});

  String cusName = AppInfoLogin.cusName;

  String Message = "";

  String CustomerName = "";
  String Accountnumber = "";

  String ACTNAME = "";

  String BranchName = "";

  String IFSCCODE = "";

  String Addresss = "";

  String Address1 = "";

  String City = "";

  String MobileNumber = "";

  String EmailId = "";
  String Pannumber = "";

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.1)),
        child: Drawer(
          width: 250.sp,
          backgroundColor: AppColors.onPrimary,
          child: Consumer<DrawerViewModel>(
            builder: (context, viewModel, child) {
              return Stack(
                children: [
                  // Main content in the drawer as a scrollable ListView
                  ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                width: 180.sp,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(CustomImages.dralogo),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4.sp,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Welcome $cusName",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.home),
                        title: Text(
                          'Home',
                          style: TextStyle(
                              fontSize: 15.sp, color: AppColors.onSecondary),
                        ),
                        onTap: () {
                          viewModel.onHomeSelected();

                          // context.pop("/dashboard");

                          Navigator.pop(context);

                          //Navigator.of(context).push('/home');

                          // Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(
                          'Profile View',
                          style: TextStyle(
                              fontSize: 15.sp, color: AppColors.onSecondary),
                        ),
                        onTap: () {
                          // viewModel.onLogout();
                          // Navigator.pop(context);

                          GetProfileDeatils(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.question_answer),
                        title: Text(
                          'FAQ',
                          style: TextStyle(
                              fontSize: 15.sp, color: AppColors.onSecondary),
                        ),
                        onTap: () async {
                          // viewModel.onLogout();
                          // Navigator.pop(context);

                          bool val = await Utils.netWorkCheck(context);

                          if (val == false) {
                            return;
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FAQ()));
                          // context.push('/FAQ');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.tips_and_updates_rounded),
                        title: Text(
                          'Safty Tips',
                          style: TextStyle(
                              fontSize: 15.sp, color: AppColors.onSecondary),
                        ),
                        onTap: () async {
                          // viewModel.onLogout();
                          // Navigator.pop(context);

                          bool val = await Utils.netWorkCheck(context);

                          if (val == false) {
                            return;
                          }

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SafetyTipsScreenView()));

                          //context.push("/SafetyTipsScreenView");
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 15.sp, color: AppColors.onSecondary),
                        ),
                        onTap: () async {
                          // context.pop(context);

                          Navigator.pop(context);

                          await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Builder(builder: (context) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                        textScaler:
                                            const TextScaler.linear(1.1)),
                                    child: AlertDialog(
                                      backgroundColor: AppColors.onPrimary,
                                      title: const Text(
                                        'Logout',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      content: const Text(
                                        "Do you want to Logout?",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            'No',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            //context.go('/login');

                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginView()));
                                          },
                                          child: const Text(
                                            'Yes',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              });
                        },
                      ),
                    ],
                  ),

                  // Positioned app version at the bottom
                  Positioned(
                    bottom:
                        16.0, // Position the text slightly above the bottom edge
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      child: Text(
                        'App Ver. 3.5',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.onSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }

  Future<void> GetProfileDeatils(BuildContext context) async {
// Password Ency.
    // String md5Hash = Crypt().generateMd5(password);
    // Loader.show(context, progressIndicator: CircularProgressIndicator());

    // API endpoint URL

    String apiUrl = ApiConfig.profiledata;

    String accountNo = context.read<SessionProvider>().get('accountNo');

    String jsonString = jsonEncode({
      "Accno": accountNo,
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
        List<dynamic> jsonResponse = jsonDecode(response.body);
        Map<String, dynamic> billData = jsonResponse[0];
        CustomerName = billData["cust_ename"];
        Accountnumber = billData["acc_no"];
        ACTNAME = billData["act_ename"];
        BranchName = billData["brn_ename"];
        IFSCCODE = billData["brn_ifsc"];
        Addresss = billData["adr_ehno"];
        Address1 = billData["adr_ehdtl"];
        City = billData["adr_ecity"];
        MobileNumber = billData["adr_mobile"];
        EmailId = billData["adr_emailid"];
        Pannumber = billData["iac_panno"];
        // ignore: prefer_interpolation_to_compose_strings
        Pannumber = "XXXXXX" + Pannumber.substring(6, 10);

        final prefs = await SharedPreferences.getInstance();
        prefs.setString("CustomerName", CustomerName);
        prefs.setString("Accountnumber", Accountnumber);
        prefs.setString("ACTNAME", ACTNAME);
        prefs.setString("BranchName", BranchName);
        prefs.setString("IFSCCODE", IFSCCODE);
        prefs.setString("Addresss", Addresss.trim());
        prefs.setString("Address1", Address1.trim());
        prefs.setString("City", City.trim());
        prefs.setString("MobileNumber", MobileNumber);
        prefs.setString("EmailId", EmailId);
        prefs.setString("Pannumber", Pannumber);

        //context.push('/profileView');

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfileView()));
      } else {
        // Loader.hide();
        Message = response.statusCode.toString();
        Dialgbox(Message, context);
        return;
      }
    } catch (error) {
      // Loader.hide();
      Message = error.toString();
      Dialgbox(Message, context);
      return;
    }
  }

  void Dialgbox(String MESSAGE, BuildContext context) {
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
