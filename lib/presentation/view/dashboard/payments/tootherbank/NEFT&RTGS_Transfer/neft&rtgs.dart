// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/data/models/withinbankquick.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/banktransfer/ToOtherBank/toothertransfer.dart';
import 'package:hpscb/presentation/view/dashboard/payments/tootherbank/IMPS/imps.dart';
import 'package:hpscb/presentation/view/dashboard/payments/tootherbank/tootherbank.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/utility/utils.dart';

class NEFTRTGS extends StatefulWidget {
  const NEFTRTGS({super.key});

  @override
  State<StatefulWidget> createState() => _NEFTRTGSState();
}

class _NEFTRTGSState extends State<NEFTRTGS> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{

 Navigator.push(context,MaterialPageRoute(builder: (context) => const ToOtherBankIMPS()));
return false;
      },
      child: Builder(builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text(
                  "NEFT & RTGS Transfer",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                backgroundColor: const Color(0xFF0057C2),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Dashboard()));
                      },
                      child: Image.asset(
                        "assets/images/dashlogo.png",
                        width: 24.sp,
                        height: 24.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
                iconTheme: const IconThemeData(
                  color: Colors.white,
                  //change your color here
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 200,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          bool val = await Utils.netWorkCheck(context);
      
                          if (val == false) {
                            return;
                          }
                          SaveGlobalTitleIMNFRT.title = "NEFT Transfer";
      
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => IMPS()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0057C2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "NEFT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          bool val = await Utils.netWorkCheck(context);
      
                          if (val == false) {
                            return;
                          }
      
                          SaveGlobalTitleIMNFRT.title = "RTGS Transfer";
      
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => IMPS()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0057C2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "RTGS",
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
              )),
        );
      }),
    );
  }
}
