import 'package:flutter/material.dart';
import 'package:hpscb/utility/theme/colors.dart';

// ignore: must_be_immutable
class AlertBox extends StatelessWidget {

  String title;
  String description;
  
   AlertBox({super.key,required this.title,required this.description});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.1)),
          child: AlertDialog(
            backgroundColor: AppColors.onPrimary,
                  title:  Text(
                    title,
                    style: const TextStyle(fontSize: 20,),
                  ),
                  content: Text(
                    description,
                    style: const TextStyle(fontSize: 18),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
        );
      }
    );
  }
}

class AlertBoxWithButton extends StatelessWidget {

 final String title;
 final  String description;
 final VoidCallback onTapButton;
  
   const AlertBoxWithButton({super.key,required this.title,required this.description, required this.onTapButton});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.1)),
          child: AlertDialog(
            backgroundColor: AppColors.onPrimary,
                  title:  Text(
                    title,
                    style: const TextStyle(fontSize: 16,),
                  ),
                  content: Text(
                    description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  actions: [
                    TextButton(
                      onPressed: onTapButton,
                      child: const Text(
                        'OK',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
        );
      }
    );
  }
}