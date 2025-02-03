// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/banktransfer/ToOtherBank/toothertransfer.dart';
import 'package:hpscb/presentation/view/dashboard/payments/manage_beneficiary/manage_beneficiary.dart';
import 'package:hpscb/presentation/view/dashboard/payments/tootherbank/tootherbank.dart';
import 'package:hpscb/presentation/view/dashboard/payments/withinbank/withinbank.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';

class PaymentMenu extends StatelessWidget {
  final String titel1;

  final String titel2;

  final String titel3;

  const PaymentMenu(this.titel1, this.titel2, this.titel3, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () async {
              bool val = await Utils.netWorkCheck(context);

              if (val == false) {
                return;
              }

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const WithIn()));
            },
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
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
                    padding: EdgeInsets.all(5.sp),
                    child: Icon(
                      Icons.account_balance,
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
            onTap: () async {
              bool val = await Utils.netWorkCheck(context);

              if (val == false) {
                return;
              }

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ToOtherBankIMPS()));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 4.sp, right: 2.sp),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
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
                      padding: EdgeInsets.all(5.sp),
                      child: Icon(
                        Icons.other_houses,
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
            onTap: () async {
              bool val = await Utils.netWorkCheck(context);

              if (val == false) {
                return;
              }

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Manage()));
            },
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
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
                    padding: EdgeInsets.all(5.sp),
                    child: Icon(
                      Icons.manage_accounts,
                      color: AppColors.appBlueC,
                      size: 30.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.sp,
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
