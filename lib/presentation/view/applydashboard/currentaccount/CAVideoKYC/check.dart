// import 'package:flutter/material.dart';
// import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

// class CheckData extends StatefulWidget {

// String val;

//    CheckData( {super.key,required this.val});

//   @override
//   State<CheckData> createState() => _CheckDataState(val);
// }

// class _CheckDataState extends State<CheckData> {

// String val;

//   _CheckDataState(this.val);


//   void join() {

//   var jitsiMeet = JitsiMeet();


//  var options = JitsiMeetConferenceOptions(

//       serverURL: "https://meet.nscspl.in/${val}",
      
//       room: "",
//       configOverrides: {
//         "startWithAudioMuted": false,
//         "startWithVideoMuted": false,
//         "subject" : "Jitsi with Flutter",
//       },

//       featureFlags: {
//         "unsaferoomwarning.enabled": false
//       },
//       userInfo: JitsiMeetUserInfo(
//           displayName: "Aditya",
//           email: "adityashukla0612@gmail.com"
//       ),
//     );

// print(options);
//     jitsiMeet.join(options);
// }

// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     join();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }