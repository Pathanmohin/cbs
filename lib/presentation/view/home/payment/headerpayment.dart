import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/utility/theme/colors.dart';

class HeaderPayment extends StatelessWidget {
  final String title;
  final String subTitle;
  const HeaderPayment(this.title, this.subTitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(Icons.account_balance_wallet,
                size: 30.sp, color: AppColors.appBlueC),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
              Text(
                subTitle,
                style: TextStyle(fontSize: 10.sp),
              )
            ],
          )
        ],
      ),
    );
  }
}
