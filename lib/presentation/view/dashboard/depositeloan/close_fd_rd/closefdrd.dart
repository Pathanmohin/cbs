// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/close_fd_rd/closerd/closerrd.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/close_fd_rd/closerfd/closerfd.dart';

import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';

class CloserFDRD extends StatefulWidget {
  const CloserFDRD({super.key});

  @override
  State<CloserFDRD> createState() => _CloserFDRDState();
}

class _CloserFDRDState extends State<CloserFDRD> {
  @override
  Widget build(BuildContext context) {
    double getButtonFontSize(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      if (screenWidth > 600) {
        return 14.0; // Large screen
      } else if (screenWidth > 400) {
        return 15.0; // Medium screen
      } else {
        return 16.0; // Default size
      }
    }

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Close FD/RD",
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
            backgroundColor: AppColors.appBlueC,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);

                    //context.pop(context);
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
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const DashboardPage()));

              Navigator.pop(context);

              //   context.pop(context);

              return false;
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          bool val = await Utils.netWorkCheck(context);

                          if (val == false) {
                            return;
                          }

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CloserFD()));

                          // context.push('/closerfd');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
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

                                  Image.asset(CustomImages.fdrd),

                                  const SizedBox(width: 20),

                                  Text(
                                    "FD CLOSER",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: getButtonFontSize(context),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
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

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CloserRD()));

                          //   context.push('/closerrd');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
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

                                  Image.asset(CustomImages.fdrd),

                                  const SizedBox(width: 20),

                                  Text(
                                    "RD CLOSER",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: getButtonFontSize(context),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
}
