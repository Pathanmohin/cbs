import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class RDCal extends StatefulWidget {
  const RDCal({super.key});
  @override
  State<StatefulWidget> createState() => _RDCalState();
}

class _RDCalState extends State<RDCal>{
 final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _monthsController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();

  double _totalAmount = 0.0;
  double _totalInterest = 0.0;

  void _calculateRD() {
    double principal = double.parse(_amountController.text);
    int years = int.parse(_yearsController.text);
    int months = int.parse(_monthsController.text);
    double rate = double.parse(_interestController.text);

    int totalMonths = (years * 12) + months;
    double monthlyInterestRate = rate / 12 / 100;
    double maturityAmount = 0;
    for (int i = 0; i < totalMonths; i++) {
      maturityAmount += principal * pow((1 + monthlyInterestRate), i + 1);
    }

    setState(() {
      _totalAmount = maturityAmount;
      _totalInterest = maturityAmount - (principal * totalMonths);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MediaQuery(
           data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title:   Text(
                  "Recurring Deposit Calculator",
                  style: TextStyle(color: Colors.white,fontSize: 16.sp),
                ),
                backgroundColor: const Color(0xFF0057C2),
          
                iconTheme: const IconThemeData(
                  color: Colors.white,
                  //change your color here
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _amountController,
                              decoration: const InputDecoration(
                                  labelText: 'Monthly Deposit Amount (₹ 500 - 5Cr)',
                                  prefixIcon: Icon(Icons.currency_rupee)),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a deposit amount';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _yearsController,
                              decoration: const InputDecoration(
                                  labelText: 'Tenure (1-20 Years)',
                                  prefixIcon: Icon(Icons.calendar_month)),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter years';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _monthsController,
                              decoration: const InputDecoration(
                                  labelText: 'Tenure (1-12 Months)',
                                  prefixIcon: Icon(Icons.calendar_month)),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter months';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _interestController,
                              decoration: const InputDecoration(
                                  labelText: 'Interest Rate (6-18%)',
                                  prefixIcon: Icon(Icons.percent)),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter an interest rate';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  _calculateRD();
                                }
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
                                      "Calculate",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Total Amount will be ₹ ${_totalAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  color: Color(0xFF0057C2),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Total Interest amount will be ₹ ${_totalInterest.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  color: Color(0xFF0057C2),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
        );
      }
    );
  }
}