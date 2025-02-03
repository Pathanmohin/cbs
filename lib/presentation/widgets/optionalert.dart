import 'package:flutter/material.dart';
import 'package:hpscb/utility/theme/colors.dart';

class OptionAlertView extends StatelessWidget {

final String title;
final String msg;
final VoidCallback? onSelectNo;
final VoidCallback? onSelectYes;

const OptionAlertView({super.key, required this.title, required this.msg, this.onSelectNo, this.onSelectYes});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.1)),
        child: AlertDialog(
          backgroundColor: AppColors.onPrimary,
          title: Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          content: Text(
            msg,
            style: const TextStyle(fontSize: 18),
          ),
          actions: [

            TextButton(
              onPressed: onSelectNo,
              child: const Text(
                'No',
                style: TextStyle(fontSize: 18),
              ),
            ),

            TextButton(
              onPressed: onSelectYes,
              child: const Text(
                'Yes',
                style: TextStyle(fontSize: 18),
              ),


            ),
          ],
        ),
      );
    });
  }
}
