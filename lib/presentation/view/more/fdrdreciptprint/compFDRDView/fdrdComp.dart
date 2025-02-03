import 'package:flutter/material.dart';

class FDRDViewComp extends StatelessWidget {
  final String title;
  final String dec;

  const FDRDViewComp({super.key, required this.title, required this.dec});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), Text(dec)]),
    );
  }
}
