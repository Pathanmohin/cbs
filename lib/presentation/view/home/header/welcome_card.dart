import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/domain/entities/logindatasave.dart';

// ignore: must_be_immutable
class WelcomeCard extends StatelessWidget {
   WelcomeCard({super.key});

  String cusName = AppInfoLogin.cusName;
  String lastSeenTime = AppInfoLogin.lastLogin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome $cusName",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
          const SizedBox(height: 5.0,),
          Text(
            lastSeenTime,
            style: TextStyle( fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
