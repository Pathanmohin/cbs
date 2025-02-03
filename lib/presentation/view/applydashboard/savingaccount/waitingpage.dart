import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/presentation/view/applydashboard/savingaccount/saveverifydata.dart';
import 'package:hpscb/presentation/view/auth/login_view.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:http/http.dart' as http;


class WaitPage extends StatefulWidget {

  const WaitPage({super.key});

  @override
  State<WaitPage> createState() => _WaitPageState();
}

class _WaitPageState extends State<WaitPage> {
   int _remainingTime = 600; // 10 minutes in seconds
  int _apiCallCount = 0;
  Timer? _timer;
  bool _kycLinkAvailable = false;
  // ignore: unused_field
  String? _kycLink;

  int _counter = 0;

  @override
  void initState() {


    super.initState();

    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;
      });

      if (_remainingTime % 60 == 0 && _apiCallCount < 5) {
        fetchKYCLink();
        _apiCallCount++;
      }

      if (_remainingTime <= 0 && !_kycLinkAvailable) {
        timer.cancel();
        showTimeOverAlert();
      }
    });
  }

Future<void> fetchKYCLink() async {
//Loader.show(context,progressIndicator: const CircularProgressIndicator());
      
    try {


String apiUrl = ApiConfig.getKYCUrl;

    var jsonReq =  jsonEncode(<String, String>{
        'kycid': KYCINCode.kycCode,
        });

          Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonReq,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      if(response.statusCode == 200){

        //Loader.hide();
        var data = jsonDecode(response.body);

        if(data.isEmpty){
          return;
        }else{
              print(data);

        if(data['Result'].toString().toLowerCase() == "success"){


        await showDialog(
          barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertBox( 
                title: "Success",
                description: data["message"],
              );
            },
          );

         // KYCINCode.kycCode = data["DATA"].toString();

         String link = data["kycUrl"].toString();

            setState(() {
          _kycLinkAvailable = true;
          _kycLink = link; // Simulate a KYC link from response
          _counter++;
        });
        _timer?.cancel(); // Stop timer if link is found

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => const WaitPage()));


        }else{
          Loader.hide();
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: "Alert",
                description: data["message"],
              );
            },
          );

          return;
        }
        }

        

      }else{
        

       Loader.hide();
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: "Alert",
                description: "Unable to Connect to the Server",
              );
            },
          );

          return;
        }
      

       
    } catch (e) {

          Loader.hide();
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertBox(
              title: "Alert",
              description: "Unable to Connect to the Server",
            );
          },
        );

        return;
      
    }

    
  }





  void showTimeOverAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Time Over'),
          content: const Text('Please try again later.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Exit the waiting screen
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String get formattedTime {
    int minutes = (_remainingTime / 60).floor();
    int seconds = _remainingTime % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {

        if(_counter == 1){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const LoginView()));
          
    } 
    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Waiting for Video KYC',
      style: TextStyle(color: Colors.white),),
      backgroundColor: const Color(0xFF0057C2),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Time remaining: $formattedTime',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            _kycLinkAvailable
                ? Column(
                    children: [
                      const Text(
                        'KYC link is now available!',
                        style: TextStyle(color: Colors.green, fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Open or process the KYC link here
                        },
                        child: const Text('Proceed to KYC'),
                      ),
                    ],
                  )
                : const Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text(
                        'Waiting for KYC link...',
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    ],
                  ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: _processComplete ? () {
            //     // Handle the "Processed" button action here
            //   } : null,
            //   child: Text('Processed'),
            // ),
          ],
        ),
      ),
    );
  }
}
