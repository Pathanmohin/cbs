// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/presentation/view/more/ChequeService/Chequemenu.dart';
import 'package:hpscb/presentation/view/more/certificates/certificates.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';

class CompMenu1 extends StatelessWidget {
  final String titel1;
  final String subtitle;

  final String titel2;

  final String titel3;

  const CompMenu1({
    super.key,
    required this.titel1,
    required this.subtitle,
    required this.titel2,
    required this.titel3,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sp),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3.sp),
            spreadRadius: 2.sp,
            blurRadius: 5.sp,
            offset: Offset(0.sp, 2.sp),
          ),
        ],
      ),
      child: Padding(
        padding:
            EdgeInsets.only(left: 8.sp, right: 8.sp, top: 10.sp, bottom: 10.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100.sp,
              child: InkWell(
                onTap: () async {
                  bool val = await Utils.netWorkCheck(context);

                  if (val == false) {
                    return;
                  }

                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Builder(builder: (context) {
                        return MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                              textScaler: const TextScaler.linear(1.1)),
                          child: AlertBox(
                            title: "Alert",
                            description: "Work in progress.......",
                          ),
                        );
                      });
                    },
                  );

                  return;
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: AppColors.onPrimary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1.sp),
                            spreadRadius: 2.sp,
                            blurRadius: 7.sp,
                            offset: Offset(0.sp, 3.sp),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Icon(
                          Icons.volunteer_activism,
                          color: AppColors.appBlueC,
                          size: 30.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6.sp,
                    ),
                    Text(titel1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10.sp)),
                    Text(subtitle,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10.sp)),
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

                 // context.push('/Certificates');

                                   Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Certificates()));


                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: AppColors.onPrimary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1.sp),
                            spreadRadius: 2.sp,
                            blurRadius: 7.sp,
                            offset: Offset(0.sp, 3.sp),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Icon(
                          Icons.badge,
                          color: AppColors.appBlueC,
                          size: 30.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6.sp,
                    ),
                    Text(titel2,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10.sp)),
                    Text("",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10.sp)),
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


                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Chequemenu()));


                  //context.push('/Chequemenu');

                  
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: AppColors.onPrimary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1.sp),
                            spreadRadius: 2.sp,
                            blurRadius: 7.sp,
                            offset: Offset(0.sp, 3.sp),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Icon(
                          Icons.subtitles_rounded,
                          color: AppColors.appBlueC,
                          size: 30.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6.sp,
                    ),
                    Text(titel3,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10.sp)),
                    Text("",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10.sp)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
