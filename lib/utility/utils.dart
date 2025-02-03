import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hpscb/utility/theme/colors.dart';

class Utils {
// For call This :--[ Utils.toastMessage("No Internet Connection"); ]

  static toastMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: AppColors.onSurface,
        textColor: AppColors.onPrimary,
        toastLength: Toast.LENGTH_LONG);
  }

  static Future<bool> netWorkCheck(BuildContext context) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: AppColors.onPrimary,
              title: Text(
                'Alert',
                style: TextStyle(fontSize: 16.sp),
              ),
              content: Text(
                'Please Check Your Internet Connection',
                style: TextStyle(fontSize: 14.sp),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ],
            );
          });

      return false;
    }

  return true;

  }


  static alertBox(String title,String msg, BuildContext build, VoidCallback? onSelectOk) {
    Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.1)),
        child: AlertDialog(
          backgroundColor: AppColors.onPrimary,
          title: Text(
            title,
            style: TextStyle(fontSize: 16.sp),
          ),
          content: Text(
            msg,
            style: TextStyle(fontSize: 16.sp),
          ),
          actions: [
            TextButton(
              onPressed: onSelectOk,
              child: Text(
                'Ok',
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          ],
        ),
      );
    });
  }
}
