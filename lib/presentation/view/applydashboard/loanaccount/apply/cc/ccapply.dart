import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class CCAccount extends StatefulWidget {
  const CCAccount({super.key});

  @override
  State<CCAccount> createState() => _CCAccountState();
}

class _CCAccountState extends State<CCAccount> {





  @override
  Widget build(BuildContext context) {
    return Builder(
     builder: (context) {


       return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title:  const Text("CC Account",style: TextStyle(color: Colors.white),),
            backgroundColor: const Color(0xFF0057C2),
           
             iconTheme: const IconThemeData(
            color: Colors.white,
             //change your color here
             ),
            ),
           body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [


                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 10.0, top: 15.0),
                        child: InkWell(
                          onTap: () async {
                            final List<ConnectivityResult> connectivityResult =
                                await (Connectivity().checkConnectivity());

                            if (connectivityResult
                                .contains(ConnectivityResult.none)) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Builder(builder: (context) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          textScaler:
                                              const TextScaler.linear(1.1)),
                                      child: AlertDialog(
                                        title: const Text(
                                          'Alert',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        content: const Text(
                                          'Please Check Your Internet Connection',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'OK',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                },
                              );

                              return;
                            }

                            // Navigator.push(context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const CCAccount()));
                          },
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0057C2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Apply",
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
              )
              
              
              )
              
              
              );

     }
       );
     }


}



