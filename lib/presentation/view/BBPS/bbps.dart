import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/presentation/view/BBPS/component/bbpscom1.dart';
import 'package:hpscb/presentation/view/BBPS/component/bbpscom2.dart';
import 'package:hpscb/presentation/view/BBPS/component/bbpscom3.dart';
import 'package:hpscb/presentation/view/BBPS/component/bbpscom4.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/titles/custom_titles.dart';

class BBPSConnect extends StatefulWidget {
  const BBPSConnect({super.key});

  @override
  State<BBPSConnect> createState() => _BBPSConnectState();
}

class _BBPSConnectState extends State<BBPSConnect> {





  @override
  Widget build(BuildContext context) {

   // CustomImages.bbpsconnect;

   Image bbpsconnect =  Image.asset(CustomImages.bbpsconnect);

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: TextScaler.linear(1.1.sp)),
        // ignore: deprecated_member_use
        child: WillPopScope(
          onWillPop: () async {
            //Navigator.pop(context);

            Navigator.push(context,MaterialPageRoute(builder: (context) => Dashboard()));

            return false;
          },
          child: Scaffold(
            //backgroundColor: Colors.white,
            backgroundColor: AppColors.onPrimary,
            appBar: AppBar(
              title: Text(
                CustomTitles.bbpsService,
                style: TextStyle(color: AppColors.onPrimary, fontSize: 16.sp),
              ),
              backgroundColor: AppColors.appBlueC,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 10.sp),
                  child: Container(
                      width: 80.sp,
                      height: 45.sp,
                      decoration: const BoxDecoration(
                          // borderRadius: BorderRadius.circular(100.0),
                          color: AppColors.appBlueC),
                      child: Image(
                        image: bbpsconnect.image,
                      )),
                ),
              ],
              leading: IconButton(
                onPressed: () {
                 // Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Dashboard()),
                  );
                },
                icon: const Icon(Icons.arrow_back),
                color: AppColors.onPrimary,
              ),
              iconTheme: const IconThemeData(
                color: AppColors.onPrimary,
                //change your color here
              ),
            ),

            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Icon(
                                Icons.bolt_rounded,
                                color: AppColors.appBlueC,
                                size: 26.sp,
                              ),
                              SizedBox(
                                width: 2.sp,
                              ),
                              Text(
                                "Recharge and Pay Bill's",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    const BbpsCom1(
                      titel1: "Mobile Recharge",
                      titel2: "Mobile PostPaid",
                      titel3: "Electricity",
                    ),
                    SizedBox(
                      height: 8.sp,
                    ),
                    const BbpsCom2(
                      titel1: "DTH",
                      titel2: "Water",
                      titel3: "FasTag",
                    ),
                    SizedBox(
                      height: 8.sp,
                    ),
                    // const BbpsCom3(
                    //   titel1: "Boardband Bill",
                    //   titel2: "Credit Card",
                    //   titel3: "Cable TV",
                    // ),
                    const BbpsCom3(
                      titel1: "LPG Booking",
                     // titel3: "Piped Gas",
                      titel2: "Credit Card",
                    ),

                    SizedBox(
                      height: 8.sp,
                    ),
                    // const BbpsCom4(
                    //   titel1: "Boardband Bill",
                    //   titel2: "Cable TV",
                    //   titel3: "Education",
                    // ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1.sp,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2.sp),
                          child: Text(
                            "Powerd By",
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: 90.sp,
                        width: 150.sp,
                        child: const Image(
                          image: AssetImage(CustomImages.bbpsorg),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
