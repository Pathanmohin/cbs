// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/loan_against/loanfd/fdloanpage.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';

import 'package:hpscb/utility/icon_image/custom_images.dart';

class LoanAgainstFD extends StatefulWidget {
  const LoanAgainstFD({super.key});

  @override
  State<LoanAgainstFD> createState() => _LoanAgainstFDState();
}

class _LoanAgainstFDState extends State<LoanAgainstFD> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: WillPopScope(
          onWillPop: () async {
           // Navigator.pop(context);

                                Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()));

            //  context.pop(context);

            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Loan Against FD",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
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
                      //------------------------------------------------------------------------------

                      // context.go('/dashboard');
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
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoanFDPage()));
                          //------------------------------------------------------------------------------

                          // context.push('/loanFDPage');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0057C2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Add some spacing between the icon and the text

                                  Image.asset(CustomImages.fdloanicon),
                                  //------------------------------------------------------------------------------
                                  const SizedBox(width: 20),

                                  const Text(
                                    "LOAN AGAINST FD",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
}
