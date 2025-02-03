// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/presentation/view/applydashboard/savingaccount/saveverifydata.dart';
import 'package:hpscb/presentation/view/applydashboard/savingaccount/waitingpage.dart';
import 'package:hpscb/presentation/view/auth/login_view.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:http/http.dart' as http;

class SVFinalRes extends StatefulWidget {
  const SVFinalRes({super.key});

  @override
  State<SVFinalRes> createState() => _SVFinalResState();
}

class _SVFinalResState extends State<SVFinalRes> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title:  Text(
                "Unauthorised ID",
                style: TextStyle(color: Colors.white,fontSize: 16.sp),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFF0057C2),
              iconTheme: const IconThemeData(
                color: Colors.white,
                //change your color here
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 200,
                          width: 200,
                          child:
                              Image.asset('assets/images/sucessfullysv.png')),
                      const Padding(
                        padding:
                            EdgeInsets.only(left: 15.0, bottom: 10.0),
                        child: Flexible(
                          child: Text(
                            "Your savings account application has been submitted. Please complete your video KYC.",
                            style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Customer Id:",
                              style: TextStyle(
                                color: Color(0xFF898989),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              FinelDataRes.customerid,
                              style: const TextStyle(
                                color: Color(0xFF898989),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Account No:",
                              style: TextStyle(
                                color: Color(0xFF898989),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              FinelDataRes.accountNo,
                              style: const TextStyle(
                                color: Color(0xFF898989),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {

                        initiateKYC();

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const WaitPage()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0057C2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Request for Video KYC",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),


                      InkWell(
                        onTap: () async {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()));
                          //context.go('/login');

                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0057C2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Back to Home",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
  
  Future<void> initiateKYC() async{

 Loader.show(context,progressIndicator: const CircularProgressIndicator());
      
    try {

      DateTime current_date = DateTime.now();

String apiUrl = ApiConfig.initiateKYC;

    var jsonReq =  jsonEncode(<String, String>{
        'custId': FinelDataRes.customerid,
        'fullName': AadhaarcardVerifyuser.full_name,
        'mobileNumber': AccOpenStart.phoneNumber,
        'accountType': 'Saving',
        'currentTimestamp':current_date.toIso8601String(),
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

        Loader.hide();
        var data = jsonDecode(response.body);
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

          KYCINCode.kycCode = data["DATA"].toString();

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const WaitPage()));


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
}



