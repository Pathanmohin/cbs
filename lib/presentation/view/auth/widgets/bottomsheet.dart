// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/presentation/view/applydashboard/applyaccount.dart';
import 'package:hpscb/presentation/view/applydashboard/model/applymodel.dart';
import 'package:hpscb/presentation/view/applydashboard/savedata/savedata.dart';
import 'package:hpscb/presentation/viewmodel/contectus_viewmodel.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

List<AccountDetails> getApplyDetailsList = [];
List<AccountDetailsFirst> listFirstPage = [];

class BottomSheetShow extends StatelessWidget {
  const BottomSheetShow({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<ContactusViewmodel>(context);

    return Container(
      height: 70.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: AppColors.onPrimary,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2.sp,
            blurRadius: 5.sp,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () async {
                bool val = await Utils.netWorkCheck(context);

                if (val == false) {
                  return;
                }

                Map<String, String> headers = {
                  'Content-Type': 'application/x-www-form-urlencoded',
                  // Add any additional headers if needed
                };
                final parameters = <String, dynamic>{
                  "": "",
                };

                authViewModel.contactus(parameters, headers, context);
              },
              child: SizedBox(
                width: 100,
                child: Column(
                  children: [
                    Icon(
                      Icons.phone_in_talk,
                      size: 30.sp,
                      color: AppColors.appBlueC,
                    ),
                    const Center(
                      child: Text(
                        "Contact Us",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                bool val = await Utils.netWorkCheck(context);

                if (val == false) {
                  return;
                }
               // getApplyDetails(context);
             await applyURlGet(context);
              },
              child: SizedBox(
                width: 100,
                child: Column(
                  children: [
                    Icon(
                      Icons.real_estate_agent,
                      size: 30.sp,
                      color: AppColors.appBlueC,
                    ),
                    const Center(
                      child: Text(
                        "Apply Now",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> applyURlGet( BuildContext context) async{
      try {
  
        // Construct URL

        String restUrl = "https://hpscb.com/enquiry-form";

        Uri pdfUrl = Uri.parse(restUrl);

        launchUrl(
          pdfUrl,
          mode: LaunchMode.externalApplication,
        );
      
    } catch (e) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "An error occurred: ${e.toString()}",
          );
        },
      );
    }
  }

  Future<void> getApplyDetails(BuildContext context) async {
    try {
      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      //String apiUrl = "rest/AccountService/accOpeningDetails";

      String apiUrl = ApiConfig.accOpeningDetails;

      String jsonString = jsonEncode({"typeDetails": ""});

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
          var res = jsonDecode(response.body);

          if (res["Result"].toString().toLowerCase() == "success") {
            if (res["Data"] != null ||
                res["Data"] != [] ||
                res["Data"] != "[]") {
              listFirstPage.clear();

              var data = jsonDecode(res["Data"]);

              for (int i = 0; i < data.length - 1; i++) {
                var getRes = data[i];

                AccountDetailsFirst vObject = AccountDetailsFirst();

                vObject.mbacctypekid = getRes["mbacctype_kid"];
                vObject.mbacctypename = getRes["mb_acctypename"].toString();
                vObject.mbdetail = getRes["mb_detail"].toString().trim();

                listFirstPage.add(vObject);
              }

              SaveDataApply.getFirstList = listFirstPage;

              Loader.hide();

              //Config.sessionStop = true;

              //  Navigator.push(context, MaterialPageRoute(builder: (context) => const ExploreMore()));

              //  Navigator.push(context, MaterialPageRoute(builder: (context) => const ApplyAccount()));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ApplyAccount()));
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
}
