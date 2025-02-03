import 'package:flutter/material.dart';
import 'package:hpscb/presentation/view/auth/login_view.dart';

import 'package:timelines_plus/timelines_plus.dart';

class AppStatus extends StatefulWidget {
  const AppStatus({super.key});

  @override
  State<AppStatus> createState() => _AppStatusState();
}

class _AppStatusState extends State<AppStatus> {

  final List<String> steps = [
    "Fill Out Application",
    "Identity Verification",
    "Upload Documents",
    "Await Approval",
    "Account Activation"
  ];

  final int currentStep = 2; // Update dynamically based on the user's progress

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MediaQuery(
        data:
            MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.1)),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Application Status",
              style: TextStyle(color: Colors.white),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF0057C2),
            actions: [
              
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );

                  //context.go('/login');


                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Image.asset(
                    'assets/images/home.png',
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(width: 5.0,),
            ],
          ),
          body: FixedTimeline.tileBuilder(
            theme: TimelineThemeData(
              nodePosition: 0.1,
              color: Colors.blue,
              indicatorTheme: const IndicatorThemeData(
                size: 25,
                color: Colors.blueAccent,
              ),
            ),
            builder: TimelineTileBuilder.connected(
              connectionDirection: ConnectionDirection.before,
              itemCount: steps.length,
              contentsBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  steps[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: index == currentStep
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: index <= currentStep ? Colors.black : Colors.grey,
                  ),
                ),
              ),
              indicatorBuilder: (context, index) => DotIndicator(
                color: index <= currentStep ? Colors.green : Colors.grey,
              ),
              connectorBuilder: (context, index, type) {
                return SizedBox(
                  height: 20.0,
                  child: SolidLineConnector(
                    color: index < currentStep ? Colors.green : Colors.grey,
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
