import 'package:flutter/material.dart';

class ResponsiveHelper {

  BuildContext context;
  double? screenWidth;
  double? screenHeight;

  ResponsiveHelper(this.context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  double getIconSize() {
    return screenWidth! * 0.08; // Customize based on your preference
  }

  double getTextSize() {
    return screenWidth! * 0.045; // Customize based on your preference
  }
}


// Impl.  Code Way..........................................................................

//  Widget build(BuildContext context) {
//     ResponsiveHelper helper = ResponsiveHelper(context);

//     return Scaffold(
//       appBar: AppBar(title: Text('Responsive UI Example')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.home, size: helper.getIconSize()),
//             SizedBox(height: 20),
//             Text(
//               'Responsive Text',
//               style: TextStyle(fontSize: helper.getTextSize()),
//             ),
//           ],
//         ),
//       ),
//     );
//   }