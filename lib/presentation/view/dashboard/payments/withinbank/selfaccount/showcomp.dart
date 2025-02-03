import 'package:flutter/material.dart';

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
          Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
          SizedBox(width: 10,),
          Text(valueComp,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
        ],
       ),
     );
  }
}
