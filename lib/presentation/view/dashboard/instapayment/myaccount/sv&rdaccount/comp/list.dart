import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListShow extends StatelessWidget { 
  
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
          itemCount: 10,
          itemBuilder: (context, position) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      
                      children: [ 
                      Text("08 May 2026"),
                      Text("- "+"\u{20B9}"+"32432",style: TextStyle(color: Colors.red),)
                    ]),
                    Text("To 58575765766 aditya")
                  ],
                ),
              ),
            );
          },
        );
  }
}
