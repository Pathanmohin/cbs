import 'package:flutter/material.dart';

class CompCertificate extends StatelessWidget { 
  
  final String title;
  final String dec;

  const CompCertificate({super.key, required this.title, required this.dec});

  

   @override
  Widget build(BuildContext context) {
    return  Padding(
            padding: const EdgeInsets.only(left: 8.0,right:8.0),
            child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,             
             children: [ 
            Text(title),
             Text(dec),
            ]),
             );
  }
}
