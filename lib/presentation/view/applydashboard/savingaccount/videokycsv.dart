import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SVVideoKYC extends StatefulWidget {

  const SVVideoKYC({super.key});

  @override
  State<SVVideoKYC> createState() => _SVVideoKYCState();
}

class _SVVideoKYCState extends State<SVVideoKYC> {

  final meetingNameController = TextEditingController();
  // final jitsiMeet = JitsiMeet();

  // Function to launch URL in the browser
  Future<void> _launchMeetingURL(String roomName) async {
    final url = "https://meet.nscspl.in/$roomName";

           Uri pdfUrl = Uri.parse(url);

        launchUrl(pdfUrl,mode: LaunchMode.externalApplication,);
  }

  // Function to join the meeting
  // void join() {
  //   var roomName = meetingNameController.text;
  //   if (roomName.isNotEmpty) {
  //     _launchMeetingURL(roomName); // Launch the meeting in the browser
  //   }

  //   var options = JitsiMeetConferenceOptions(
  //     serverURL: "https://meet.nscspl.in",
  //     room: roomName,
  //     configOverrides: {
  //       "startWithAudioMuted": true,
  //       "startWithVideoMuted": true,
  //       "subject": "Saving Account Video KYC",
  //       "localSubject": "Video KYC",
  //     },
  //     featureFlags: {
  //       "unsaferoomwarning.enabled": false,
  //       "security-options.enabled": false,
  //     },
  //     userInfo: JitsiMeetUserInfo(
  //       displayName: "User",
  //       email: "adityashukla@gmail.com",
  //     ),
  //   );

  //   jitsiMeet.join(options);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video KYC"),
        backgroundColor: const Color(0xFF0057C2),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 250,
              height: 50,
              child: TextField(
                controller: meetingNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter meeting name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SizedBox(
                width: 100,
                height: 50,
                child: FilledButton(
                  onPressed: (){

                    _launchMeetingURL(meetingNameController.text);

                  },
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                  ),
                  child: const Text("Join"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}