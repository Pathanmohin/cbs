import 'package:flutter/material.dart';

class FDCal extends StatefulWidget {
  const FDCal({super.key});
  @override
  State<StatefulWidget> createState() => _FDCal();
}

class _FDCal extends State<FDCal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _monthsController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();

  double _totalAmount = 0.0;
  double _totalInterest = 0.0;

  void _calculateFD() {
    double principal = double.parse(_amountController.text);
    int years = int.parse(_yearsController.text);
    int months = int.parse(_monthsController.text);
    int days = int.parse(_daysController.text);
    double rate = double.parse(_interestController.text);

    int totalDays = (years * 365) + (months * 30) + days;
    double interest = (principal * rate * totalDays) / (365 * 100);
    double totalAmount = principal + interest;

    setState(() {
      _totalInterest = interest;
      _totalAmount = totalAmount;
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
                title: const Text(
                  "Fixed Deposit Calculator",
                  style: TextStyle(color: Colors.white),
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
                                decoration:
                                    const InputDecoration(labelText: 'Deposit Amount (₹)',
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
                                decoration:
                                    const InputDecoration(
                                      labelText: 'Tenure (Years)',
                                      prefixIcon: Icon(Icons.calendar_month)),
                                keyboardType: TextInputType.number,
                    
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter years';
                                  }
                                  return null;
                                },
                              ),
                    
                    
                              const SizedBox(width: 8),
                              TextFormField(
                                controller: _monthsController,
                                decoration: const InputDecoration(labelText: 'Months',
                                      prefixIcon: Icon(Icons.calendar_month)),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter months';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(width: 8),
                              TextFormField(
                                controller: _daysController,
                                decoration: const InputDecoration(labelText: 'Days',
                                      prefixIcon: Icon(Icons.calendar_month)),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter days';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _interestController,
                                decoration: const InputDecoration(labelText: 'Interest Rate (%)',
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
                                    _calculateFD();
                                  }
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
                              Text('Total Amount will be ₹ $_totalAmount',style: const TextStyle(color: Color(0xFF0057C2),fontWeight: FontWeight.bold ),),
                              Text('Total Interest amount will be ₹ $_totalInterest',style: const TextStyle(color: Color(0xFF0057C2),fontWeight: FontWeight.bold ),),
                            ],
                          ),
                        )),
                  ),
                ),
              )),
        );
      }
    );
  }
}
