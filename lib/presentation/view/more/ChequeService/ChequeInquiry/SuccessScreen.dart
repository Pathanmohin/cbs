
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/view/more/ChequeService/Chequemenu.dart';

import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class chequeinquirysuccess extends StatefulWidget {
  const chequeinquirysuccess({super.key});

  @override
  State<StatefulWidget> createState() => _chequeinquirysuccess();
}

// ignore: camel_case_types
class _chequeinquirysuccess extends State<chequeinquirysuccess> {
  @override
  void initState() {
    super.initState();
    dataFound();
  }

  Future<void> dataFound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sDate = prefs.getString("SDATE") ?? '';
      status = prefs.getString("STATUS") ?? '';
      chequenumber = prefs.getString("CHEQUENO") ?? '';
      issuedate = prefs.getString("ISSUE") ?? '';
    });
  }

  String sDate = "";
  String status = "";

  String chequenumber = "";

  String issuedate = "";

  void onToAccount(String value) {}

  // ignore: non_constant_identifier_names
  void ToAccount(String item) {}

  Future<bool> _onBackPressed() async {
    // Use Future.delayed to simulate async behavior
    await Future.delayed(const Duration(milliseconds: 1));

    // Perform the navigation
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Chequemenu()),
    );

   // context.pop(context);

    // Prevent the default back button behavior
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;



    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Builder(
        builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  "Status",
                  style: TextStyle(color: Colors.white,fontSize: 16.sp),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Chequemenu()),
                    );

                   // context.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
                backgroundColor: const Color(0xFF0057C2),
                actions: [

                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: InkWell(
                      onTap: (){

                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Dashboard()),
                        );
                      
                    },
                    child: Image.asset(
                    CustomImages.home,
                    width: 24.sp,
                    height: 24.sp,
                    color: Colors.white,
                  ),

                    ),
                  ),


                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Center(
                        //     child: Image.asset(
                        //   "assets/images/ds_right.png",
                        //   width: 70,
                        // )),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 8.0, right: 20, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Your Cheque Number:",
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                chequenumber,
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 8.0, right: 20, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "On Date:",
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                issuedate,
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 8.0, right: 20, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "End Date",
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                sDate,
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 8.0, right: 20, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Status:",
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                status,
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Center(
                              child: Image.asset(
                            "assets/images/ds_right.png",
                            width: 90,
                          )),
                        ),
            
                        const Center(
                          child: Text(
                            "Thank You",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
            
                        InkWell(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Chequemenu()));

                            //context.go('/context');

                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                            child: Container(
                              height: 50.sp,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0057C2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  "FIND ANOTHER",
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
          );
        }
      ),
    );
  }

// API Code............................................................
}
