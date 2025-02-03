// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/ElectricityRecharge/Electricity.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/MobilePospaidRecharge/mobilepostpaid.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/MobileRecharge/mobilerecharge.dart';

import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';

class BbpsCom1 extends StatelessWidget {
  final String titel1;

  final String titel2;

  final String titel3;

  const BbpsCom1({
    super.key,
    required this.titel1,
    required this.titel2,
    required this.titel3,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: TextScaler.linear(1.sp)),
        child: Container(
          width: size.width,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 1.sp,
                  ),
                  SizedBox(
                    width: 100.sp,
                    child: InkWell(
                      onTap: () async {
                        bool val = await Utils.netWorkCheck(context);

                        if (val == false) {
                          return;
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Recharge()));

                        //context.push('/mobilerecharge');
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: AppColors.onPrimary,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.charging_station_rounded,
                                color: AppColors.appBlueC,
                                size: 30.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6.sp,
                          ),
                          Center(
                              child: Text(titel1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp))),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 1.sp,
                  ),
                  SizedBox(
                    width: 100.sp,
                    child: InkWell(
                      onTap: () async {
                        bool val = await Utils.netWorkCheck(context);

                        if (val == false) {
                          return;
                        }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PostPaid()));
                        //  context.push('/PostPaid');
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: AppColors.onPrimary,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.receipt_long,
                                color: AppColors.appBlueC,
                                size: 30.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6.sp,
                          ),
                          Center(
                              child: Text(titel2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp))),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100.sp,
                    child: InkWell(
                      onTap: () async {
                        bool val = await Utils.netWorkCheck(context);

                        if (val == false) {
                          return;
                        }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Electricity()));

                        //  context.push('/Electricity');
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: AppColors.onPrimary,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.emoji_objects,
                                color: AppColors.appBlueC,
                                size: 30.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6.sp,
                          ),
                          Center(
                              child: Text(titel3,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
