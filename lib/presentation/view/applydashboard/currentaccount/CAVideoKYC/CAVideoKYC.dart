// import 'package:flutter/material.dart';



// class CAVideoKYC extends StatefulWidget {

//   const CAVideoKYC({super.key});

//   @override
//   State<CAVideoKYC> createState() => _CAVideoKYCState();
// }

// class _CAVideoKYCState extends State<CAVideoKYC> {
//  final meetingNameController = TextEditingController();

//   final jitsiMeet = JitsiMeet();

//   void join() {
    
//     var options = JitsiMeetConferenceOptions(

//       serverURL: "https://meet.nscspl.in",

//       room: meetingNameController.text,

//       configOverrides: {

//         "startWithAudioMuted": true,
//         "startWithVideoMuted": true,
//         "subject" : "Saving Account Video KYC",
//         "localSubject" : "Video KYC",

//       },

//       featureFlags: {

//         "unsaferoomwarning.enabled": false,
//         "security-options.enabled": false

//       },

//       userInfo: JitsiMeetUserInfo(

//           displayName: "User",
//           email: "adityashukla@gmail.com"

//       ),
//     );

//     jitsiMeet.join(options);
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Video KYC"),
//         backgroundColor: const Color(0xFF0057C2),
//       ),                                                                                                         

//       body:Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(
//               width: 250,
//               height: 50,
//               child: TextField(
//                 controller: meetingNameController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Enter meeting name',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: SizedBox(
//                 width: 100,
//                 height: 50,
//                 child: FilledButton(
//                   onPressed: join,
//                   style: ButtonStyle(
//                     shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
//                   ),
//                   child: const Text("Join") 
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }