import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hpscb/presentation/view/auth/login_view.dart';
import 'package:hpscb/presentation/viewmodel/loginbanner_viewmodel.dart';

import 'package:hpscb/presentation/viewmodel/splashprovider/splash_provider.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   // Hide the status bar
  //   //SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  //   SystemChrome.setEnabledSystemUIMode(
  //   SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  // }

  // @override
  // void dispose() {
  //   // Optionally, revert to the default system UI mode when this screen is disposed
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();

    showbanner(context);

    Timer(
        const Duration(seconds: 2),
        () => 
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const LoginView())));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // return Consumer<SplashProvider>(
    //   builder: (context, splashProvider, child) {
    //     if (!splashProvider.isLoading) {

    //       Future.microtask( () async
    //       {
    //          // ignore: use_build_context_synchronously
    //          //context.go('/login');

    //          // ignore: use_build_context_synchronously
    //          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginView()));

    //          });

    //     }
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.1)),
        child: Scaffold(
          body: Center(
            child: Image.asset(
              width: size.width,
              CustomImages.splashImg,
              fit: BoxFit.fill,
            ),
          ),
        ),
      );
    });
  }


  
  Future<void> showbanner(BuildContext context) async {
    final bannerViewModel =
        Provider.of<LoginbannerViewmodel>(context, listen: false);

    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');

    formatter.format(now);

    //Loader.show(context, progressIndicator: CircularProgressIndicator());

    // String apiUrl = ApiConfig.banLogin;

    String jsonString = jsonEncode({
      "curentDate": "2025-03-03",
    });

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
    };

    await bannerViewModel.loginbanner(jsonString, headers, context);
  }
  
}


