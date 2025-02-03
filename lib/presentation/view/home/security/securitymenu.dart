import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/presentation/view/dashboard/security/blockcard/blockcard.dart';
import 'package:hpscb/presentation/view/dashboard/security/changepassword/changepassword.dart';
import 'package:hpscb/presentation/view/dashboard/security/generatempin/Generatempin.dart';
import 'package:hpscb/utility/theme/colors.dart';

class SecurityMenu extends StatelessWidget {
  final String titel1;
  final String titel2;
  final String titel3;

  const SecurityMenu(this.titel1, this.titel2, this.titel3, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MpinGenerate()));

           //context.push("/MpinGenerate");

            },
            child: Column(
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
                    padding: EdgeInsets.all(5.sp),
                    child: Icon(
                      Icons.pin,
                      color: AppColors.appBlueC,
                      size: 30.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                Text(
                  titel1,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePassword()));

             // context.push('/changePassword');
            },
            child: Column(
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
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.password_sharp,
                      color: AppColors.appBlueC,
                      size: 30.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                Text(
                  titel2,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp),
                ),
              ],
            ),
          ),
          SizedBox(
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AtmDeactivation()));

               // context.push('/atmaeactivation');
              },
              child: Column(
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
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.credit_score_outlined,
                        color: AppColors.appBlueC,
                        size: 30.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  Text(
                    titel3,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
