import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/utility/theme/colors.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4.0),
        Center(
          child: Text(
            'Welcome to HPSCB',
            style: TextStyle(
              fontSize: 18.sp,
              color: AppColors.appBlueC,
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Center(
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
