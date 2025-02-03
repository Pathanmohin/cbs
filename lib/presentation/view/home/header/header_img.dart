import 'package:flutter/material.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(CustomImages.headerImg),
    );
  }
}
