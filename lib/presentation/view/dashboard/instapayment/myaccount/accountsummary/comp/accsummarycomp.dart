import 'package:flutter/material.dart';

class AccComp extends StatelessWidget {

 final String title;
 final String description;

  const AccComp({super.key,required this.title,required this.description});  
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
          Flexible(child: Text(title)),
          Flexible(
            child: Text(description,),
          )
      
        ],),
    );
  }
}
