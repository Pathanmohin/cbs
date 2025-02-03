import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ShowCompSelf extends StatelessWidget {

  String title;
  String valueComp;

   ShowCompSelf({super.key,required this.title,required this.valueComp});
  
  
  @override
  Widget build(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.only(right: 20,bottom: 10),
       child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
       
        children: [
          Text(title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
          const SizedBox(width: 10,),
          Text(valueComp,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
        ],
       ),
     );
  }
}
