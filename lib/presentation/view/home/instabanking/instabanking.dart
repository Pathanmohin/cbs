import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/presentation/view/home/instabanking/headerinsta.dart';
import 'package:hpscb/presentation/view/home/instabanking/instamenu.dart';
import 'package:hpscb/utility/theme/colors.dart';

class InstaBanking extends StatelessWidget {
  final String title;
  final String subTitle;

  final String titel1;

  final String titel2;

  final String titel3;


   const InstaBanking(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.titel1,
      required this.titel2,
      required this.titel3});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.onPrimary,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InstaHeader(title, subTitle),
                         SizedBox(
              height: 10.sp,
            ),
            Instamenu(titel1, titel2, titel3),
                         SizedBox(
              height: 10.sp,
            ),
          ],
        ),
      ),
    );
  }
}
