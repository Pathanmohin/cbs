import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/close_fd_rd/closefdrd.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/createfdrd.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/loan_against/loanagainstfd.dart';
import 'package:hpscb/utility/theme/colors.dart';

class DepositsMenu extends StatelessWidget {
  final String titel1;

  final String titel2;

  final String titel3;

  const DepositsMenu(this.titel1, this.titel2, this.titel3, {super.key});

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
                  MaterialPageRoute(builder: (context) => const CreateFDRD()));
                     
                     //context.push('/createfDRD');

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
                      Icons.savings,
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
          SizedBox(
            width: 110,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoanAgainstFD()));

                //context.push('/loanagainstFD');
                
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
                        Icons.real_estate_agent,
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
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CloserFDRD()));

             // context.push('/closerfdrd');
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
                      Icons.subtitles_rounded,
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
        ],
      ),
    );
  }
}
