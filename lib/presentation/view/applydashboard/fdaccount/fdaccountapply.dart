// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';

import 'package:hpscb/presentation/view/applydashboard/savingaccount/svaccount.dart';
import 'package:hpscb/presentation/view/auth/login_view.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:quickalert/quickalert.dart';

class FDCreation extends StatefulWidget {
  const FDCreation({super.key});

  @override
  State<FDCreation> createState() => _FDCreateState();
}

class _FDCreateState extends State<FDCreation> {
  String? _selectedAccountStatus = "Yes"; // Default to "Yes"

  // Function to show an alert based on user's choice

  // Function to handle radio button selection
  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedAccountStatus = value;
    });
  }

  // Function to handle "Proceed" button press
  void _onProceedPressed() async {
    if (_selectedAccountStatus == "Yes") {
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        text:
            'Please login with your Savings Account and apply from the "Deposits and Loan" section.',
      );

      // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const LoginView();
      }));
    } else if (_selectedAccountStatus == "No") {
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        text:
            'First, open a Savings Account. After that, you can apply for an FD account.',
      );

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SVOpenAccount()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                "Term Deposits",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF0057C2),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 10.0),
                        child: Text(
                          'Are you an existing customer?',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Yes',
                                autofocus: true,
                                groupValue: _selectedAccountStatus,
                                onChanged: _handleRadioValueChange,
                              ),
                              const Text('Yes, I am an existing customer',
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'No',
                                groupValue: _selectedAccountStatus,
                                onChanged: _handleRadioValueChange,
                              ),
                              const Text('No', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            bool val = await Utils.netWorkCheck(context);

                            if (val == false) {
                              return;
                            }
                            _onProceedPressed();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0057C2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  "Proceed",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),


                      
const SizedBox(height: 10.0,),

                    ],
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
