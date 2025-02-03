// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, use_build_context_synchronously, constant_identifier_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fdrdmodel/model.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fdrfdatasave/datasave.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/rd/nominee/rdnominee.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RDCreate extends StatefulWidget {
  const RDCreate({super.key});

  @override
  State<StatefulWidget> createState() => _RDCreateState();
}

enum Groceries { First, Third, Five, Other }

class _RDCreateState extends State<RDCreate> {
  List<FDOpening> fdlistS = FDList.rdListS;

  List<FDSGLCODE> fdsglCode = <FDSGLCODE>[];

  List<AccountFetchModel> accFdListSACACC = AppListData.SACACC;

  AccountFetchModel? accValueFd;

  String? dayIntM;

  // ignore: unused_field, prefer_final_fields
  DateTime _selectedStartDate = DateTime.now();

  final TextEditingController amount = TextEditingController();
  final TextEditingController maRate = TextEditingController();
  final TextEditingController maAmount = TextEditingController();
  final TextEditingController maDate = TextEditingController();

  // ignore: unused_field
  final TextEditingController _dateStartController = TextEditingController();

  @override
  void initState() {
    relationGet();
    super.initState();
  }

  FDOpening? fdValue;

  Groceries? _groceryItem;
  Groceries? _groceryItem1;

  String? mStateNameGet;
  String? ActkidGet;
  String? ActcodeGet;
  String? TimeperoidGet;
  String? DefactkidfdGet;

  String? sglcode;

  //amount hide

  bool _hideAmounttext = false;

// String for time period condition.......
  String timePSet = "";

  // Other Select option
  bool dateSelect = false;

  void _setOtherOptionDate(bool value) {
    setState(() {
      dateSelect = value;
    });
  }

// Check Debit account selected or not

  String debitNumber = "";

  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
      if (kDebugMode) {
        print('Switch Button is ON');
      }
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      if (kDebugMode) {
        print('Switch Button is OFF');
      }
    }
  }

  void handleInput(String v) {
    setState(() {
      _groceryItem = _groceryItem1;
      maAmount.text = "";
      maDate.text = "";
      maRate.text = "";
    });
  }

  String? selectedYear;
  String? selectMonth;
  String? selectDay;

// Amount

  String? amGetCheck;

  // check scheme blank or not

  String scheme = "";

//Hide Day and Month when year >= 10

  bool _showDDMM = true;

  void _hideDDMM(bool value) {
    setState(() {
      _showDDMM = value;
    });
  }

  var _sizeYearBox = 100.0;

  void _setSizeYearBox(var value) {
    _sizeYearBox = value;
  }

  String otherDay = "0";
  String otherMonth = "0";
  String otherYear = "0";

  String dayofMonth = "";

  List<NomineeListName> nomineeName = <NomineeListName>[];

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    List<String> day = [
      "0",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "11",
      "12",
      "13",
      "14",
      "15",
      "16",
      "17",
      "18",
      "19",
      "20",
      "21",
      "22",
      "23",
      "24",
      "25",
      "26",
      "27",
      "28",
      "29",
      "30"
    ];
    List<String> month = [
      "0",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "11",
      "12"
    ];
    List<String> years = [
      "0",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10"
    ]; // Generates list [0, 1, 2, ..., 10]

    List<String> daysInt = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "11",
      "12",
      "13",
      "14",
      "15",
      "16",
      "17",
      "18",
      "19",
      "20",
      "21",
      "22",
      "23",
      "24",
      "25",
      "26",
      "27",
      "28",
      "29",
      "30",
      "31"
    ];

    // Future<void> _selectStartDate(BuildContext context) async {
    //   final DateTime? picked = await showDatePicker(
    //     context: context,
    //     initialDate: _selectedStartDate,
    //     firstDate: DateTime(1900),
    //     lastDate: DateTime(2101),
    //   );

    //   if (picked != null) {
    //     setState(() {
    //       _selectedStartDate = picked;

    //       _dateStartController.text =
    //           DateFormat('dd-MM-yyyy').format(_selectedStartDate);
    //     });
    //   }
    // }

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        // ignore: deprecated_member_use
        child: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);

            // context.pop(context);
            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "RD Opening",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              backgroundColor: const Color(0xFF0057C2),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Dashboard()));
                      //   context.go('/dashboard');
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
                padding: const EdgeInsets.all(8.0),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "Select RD Scheme",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<FDOpening>(
                              dropdownColor: AppColors.onPrimary,
                              value: fdValue,
                              hint: const Text(
                                'Select RD Scheme',
                                style: TextStyle(
                                  color: Color(0xFF898989),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              isExpanded: true,
                              items: fdlistS.map((FDOpening obj) {
                                return DropdownMenuItem<FDOpening>(
                                  value: obj,
                                  child: Builder(builder: (context) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          textScaler:
                                              const TextScaler.linear(1.1)),
                                      child: Text(
                                        "${obj.mStateName}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  fdValue = newValue;
                                  scheme = newValue!.mStateName.toString();
                                });
                                // Call your method here, similar to SelectedIndexChanged
                                onAccountScheme(newValue!);
                              },
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "RD Amount",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, right: 8.0),
                        child: SizedBox(
                          height: 52,
                          child: TextField(
                            controller: amount,
                            enabled: _hideAmounttext,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: handleInput,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: 'Enter RD Amount',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                          ),
                        ),
                      ),
                      //
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10.0, bottom: 8),
                        child: Text(
                          "Time Period",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              RadioListTile<Groceries>(
                                value: Groceries.First,
                                groupValue: _groceryItem,
                                onChanged: (Groceries? value) {
                                  if (scheme.toString().isEmpty) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertBox(
                                          title: "Alert",
                                          description: "Please select scheme",
                                        );
                                      },
                                    );
                                    return;
                                  }

                                  if (amount.text != "") {
                                    int amountVal = int.parse(amount.text);

                                    if (amountVal < 10) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertBox(
                                            title: "Alert",
                                            description:
                                                "Minimum amount of Deposit Rs.10",
                                          );
                                        },
                                      );
                                      return;
                                    }
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertBox(
                                          title: "Alert",
                                          description: "Please Enter Amount",
                                        );
                                      },
                                    );
                                    return;
                                  }

                                  setState(() {
                                    _groceryItem = value;

                                    timePSet = "1";

                                    otherMonth = "0";
                                    otherYear = "1";
                                  });

                                  if (dateSelect == true) {
                                    _setOtherOptionDate(false);
                                  }

                                  String month = "0";
                                  String year = "1";
                                  getInterestCal(month, year);
                                },
                                title: const Text('1 Years'),
                              ),
                              RadioListTile<Groceries>(
                                value: Groceries.Third,
                                groupValue: _groceryItem,
                                onChanged: (Groceries? value) {
                                  if (scheme.toString().isEmpty) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertBox(
                                          title: "Alert",
                                          description: "Please select scheme",
                                        );
                                      },
                                    );
                                    return;
                                  }

                                  if (amount.text != "") {
                                    int amountVal = int.parse(amount.text);

                                    if (amountVal < 10) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertBox(
                                            title: "Alert",
                                            description:
                                                "Minimum amount of Deposit Rs.10",
                                          );
                                        },
                                      );
                                      return;
                                    }
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertBox(
                                          title: "Alert",
                                          description: "Please Enter Amount",
                                        );
                                      },
                                    );
                                    return;
                                  }

                                  setState(() {
                                    _groceryItem = value;
                                    timePSet = "3";

                                    otherMonth = "0";
                                    otherYear = "3";
                                  });

                                  if (dateSelect == true) {
                                    _setOtherOptionDate(false);
                                  }

                                  String month = "0";
                                  String year = "3";
                                  getInterestCal(month, year);
                                },
                                title: const Text('3 Years'),
                              ),
                              RadioListTile<Groceries>(
                                value: Groceries.Five,
                                groupValue: _groceryItem,
                                onChanged: (Groceries? value) {
                                  if (scheme.toString().isEmpty) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertBox(
                                          title: "Alert",
                                          description: "Please select scheme",
                                        );
                                      },
                                    );
                                    return;
                                  }

                                  if (amount.text != "") {
                                    int amountVal = int.parse(amount.text);

                                    if (amountVal < 10) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertBox(
                                            title: "Alert",
                                            description:
                                                "Minimum amount of Deposit Rs.10",
                                          );
                                        },
                                      );
                                      return;
                                    }
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertBox(
                                          title: "Alert",
                                          description: "Please Enter Amount",
                                        );
                                      },
                                    );
                                    return;
                                  }

                                  setState(() {
                                    _groceryItem = value;
                                    timePSet = "5";

                                    otherMonth = "0";
                                    otherYear = "5";
                                  });

                                  if (dateSelect == true) {
                                    _setOtherOptionDate(false);
                                  }

                                  String month = "0";
                                  String year = "5";
                                  getInterestCal(month, year);
                                },
                                title: const Text('5 Years'),
                              ),
                              RadioListTile<Groceries>(
                                value: Groceries.Other,
                                groupValue: _groceryItem,
                                onChanged: (Groceries? value) {
                                  if (scheme.toString().isEmpty) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertBox(
                                          title: "Alert",
                                          description: "Please select scheme",
                                        );
                                      },
                                    );
                                    return;
                                  }

                                  if (amount.text != "") {
                                    int amountVal = int.parse(amount.text);

                                    if (amountVal < 10) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertBox(
                                            title: "Alert",
                                            description:
                                                "Minimum amount of Deposit Rs.10",
                                          );
                                        },
                                      );
                                      return;
                                    }
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertBox(
                                          title: "Alert",
                                          description: "Please Enter Amount",
                                        );
                                      },
                                    );
                                    return;
                                  }

                                  setState(() {
                                    String? data;

                                    selectedYear = data;
                                    selectMonth = data;

                                    otherMonth = "0";
                                    otherYear = "0";

                                    _hideDDMM(true);
                                    _setSizeYearBox(100.0);

                                    _groceryItem = value;

                                    timePSet = "Other";

                                    maAmount.text = "";
                                    maDate.text = "";
                                    maRate.text = "";
                                  });

                                  if (dateSelect == false) {
                                    _setOtherOptionDate(true);
                                  }
                                },
                                title: const Text('Other'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: dateSelect,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 10.0),
                          child: Text(
                            "Select Tenure of your Choice",
                            style: TextStyle(
                                color: Color(0xFF0057C2),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: dateSelect,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 20.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text("Years"),
                                    Container(
                                      width: _sizeYearBox,
                                      margin: const EdgeInsets.only(top: 5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String?>(
                                          dropdownColor: AppColors.onPrimary,
                                          value: selectedYear,
                                          hint: const Text(
                                            'Year',
                                            style: TextStyle(
                                              color: Color(0xFF898989),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          isExpanded: true,
                                          items: years.map((String? year) {
                                            return DropdownMenuItem<String?>(
                                              value: year,
                                              child:
                                                  Builder(builder: (context) {
                                                return MediaQuery(
                                                  data: MediaQuery.of(context)
                                                      .copyWith(
                                                          textScaler:
                                                              const TextScaler
                                                                  .linear(1.1)),
                                                  child: Text(
                                                    "$year",
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                );
                                              }),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedYear = newValue!;

                                              String yearOther =
                                                  selectedYear.toString();
                                              int conVal = int.parse(yearOther);

                                              if (conVal == 10) {
                                                _hideDDMM(false);

                                                _setSizeYearBox(200.0);

                                                String? data;

                                                selectMonth = data;
                                                selectDay = data;

                                                otherYear = yearOther;

                                                otherMonth = "0";
                                              } else {
                                                _hideDDMM(true);

                                                otherYear = yearOther;

                                                _setSizeYearBox(100.0);
                                              }
                                            });

                                            getInterestCal(
                                                otherMonth, otherYear);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: _showDDMM,
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      const Text("Months"),
                                      Container(
                                        width: 100,
                                        margin: const EdgeInsets.only(top: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String?>(
                                            dropdownColor: AppColors.onPrimary,
                                            value: selectMonth,
                                            hint: const Text(
                                              'Month',
                                              style: TextStyle(
                                                color: Color(0xFF898989),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            isExpanded: true,
                                            items: month.map((String? month) {
                                              return DropdownMenuItem<String?>(
                                                value: month,
                                                enabled: _showDDMM,
                                                child:
                                                    Builder(builder: (context) {
                                                  return MediaQuery(
                                                    data: MediaQuery.of(context)
                                                        .copyWith(
                                                            textScaler:
                                                                const TextScaler
                                                                    .linear(
                                                                    1.1)),
                                                    child: Text(
                                                      "$month",
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectMonth = newValue!;
                                                otherMonth =
                                                    selectMonth.toString();
                                              });
                                              // Call your method here, similar to SelectedIndexChanged
                                              //   onAccountScheme(newValue!);

                                              getInterestCal(
                                                  otherMonth, otherYear);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 5.0),
                        child: Text("Period of Deposit 6 Month - 120 Month"),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0, left: 10.0),
                        child: Text(
                          "Interest Rate",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, right: 8.0),
                        child: SizedBox(
                          height: 52,
                          child: TextField(
                            controller: maRate,
                            enabled: false,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: 'Interest Rate',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "Maturity Amount",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, right: 8.0),
                        child: SizedBox(
                          height: 52,
                          child: TextField(
                            controller: maAmount,
                            enabled: false,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: 'Maturity Amount',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "Maturity Date",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, right: 8.0),
                        child: SizedBox(
                          height: 52,
                          child: TextField(
                            controller: maDate,
                            enabled: false,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: 'Maturity Date',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "Select Debit Account Number",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<AccountFetchModel>(
                              dropdownColor: AppColors.onPrimary,
                              value: accValueFd,
                              hint: const Text(
                                'Select Debit Account Number',
                                style: TextStyle(
                                  color: Color(0xFF898989),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              isExpanded: true,
                              items:
                                  accFdListSACACC.map((AccountFetchModel obj) {
                                return DropdownMenuItem<AccountFetchModel>(
                                  value: obj,
                                  child: Builder(builder: (context) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          textScaler:
                                              const TextScaler.linear(1.1)),
                                      child: Text(
                                        "${obj.textValue}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  accValueFd = newValue;
                                });

                                // Call your method here, similar to SelectedIndexChanged
                                onFromAccount(newValue!);
                              },
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "Day of Month when installment to be Debited",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              dropdownColor: AppColors.onPrimary,
                              value: dayIntM,
                              hint: const Text(
                                'Select Day',
                                style: TextStyle(
                                  color: Color(0xFF898989),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              isExpanded: true,
                              items: daysInt.map((String day) {
                                return DropdownMenuItem<String>(
                                  value: day,
                                  child: Builder(builder: (context) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          textScaler:
                                              const TextScaler.linear(1.1)),
                                      child: Text(
                                        day.toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  dayIntM = newValue;
                                });

                                // Call your method here, similar to SelectedIndexChanged
                                onDayOFMonthAccount(newValue!);
                              },
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await AddNomineeDetails(amount.text.toString());
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
                                "ADD NOMINEE",
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

  void onAccountScheme(FDOpening fdOpening) {
    String mStateName = fdOpening.mStateName.toString();
    String Actkid = fdOpening.mStateCode.toString();
    String Actcode = fdOpening.mStateID.toString();
    String Timeperoid = fdOpening.timeperoid.toString();
    String Defactkidfd = fdOpening.Defactkidfd.toString();

    setState(() {
      mStateNameGet = mStateName;
      ActkidGet = Actkid;
      ActcodeGet = Actcode;
      TimeperoidGet = Timeperoid;
      DefactkidfdGet = Defactkidfd;
    });

    OnSchemeCode();

    setState(() {
      _hideAmounttext = true;
    });
  }

// Account select.....................................................................

  void onFromAccount(AccountFetchModel AccountFetchModel) {
    debitNumber = AccountFetchModel.textValue.toString();

    amGetCheck = AccountFetchModel.availbalance.toString();
  }

// Get Code

  Future<void> OnSchemeCode() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
//------------------------------------------------------------------------------------------------------
      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      // String apiUrl =
      //     "/rest/AccountService/fetchsglcodebyschcode";

      String apiUrl = ApiConfig.fetchsglcodebyschcode;

      String jsonString = jsonEncode({
        "Defactkid": DefactkidfdGet,
      });

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonString,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      try {
        if (response.statusCode == 200) {
          if (response.body != null || response.body == "") {
            var res = jsonDecode(response.body);

            if (res["Result"] == "Success") {
              var decryptedResult = res["Data"];

              var data = json.decode(decryptedResult);

              for (int i = 0; i < data.length; i++) {
                FDSGLCODE vObject = FDSGLCODE();

                var getdata = data[i];

                vObject.sglcode = getdata["sglcode"];
                vObject.actname = getdata["actname"];

                sglcode = vObject.sglcode;

                fdsglCode.add(vObject);
              }

              Loader.hide();
            } else {
              Loader.hide();

              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: res["Message"].toString(),
                  );
                },
              );
              return;
            }
          } else {
            Loader.hide();

            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertBox(
                  title: "Alert",
                  description: "Server is not responding..!",
                );
              },
            );
            return;
          }
        } else {
          Loader.hide();
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: "Alert",
                description: "Server failed..!",
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
              description: "Unable To connect Server",
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
            description: "Unable To connect Server",
          );
        },
      );
      return;
    }
  }

  // API for get Interest Amount

  Future<void> getInterestCal(String month, year) async {
    String? durationY;
    String? durationM;

    durationM = month;
    durationY = year;

    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
//------------------------------------------------------------------------------------------------------
      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      // String apiUrl =
      //     "rest/AccountService/CalculateRdintrest";

      String apiUrl = ApiConfig.calculaterDintrest;

      String customerId = context.read<SessionProvider>().get('customerId');

      String jsonString = jsonEncode({
        "amount": amount.text.toString(),
        "durationY": durationY,
        "durationM": durationM,
        "customerId": customerId,
        // "schemeCode" : ActcodeGet.toString().trim(),
        "sglcode": sglcode.toString(),
      });

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonString,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      try {
        if (response.statusCode == 200) {
          if (response.body != "") {
            var res = jsonDecode(response.body);

            if (res["Result"].toString().toLowerCase() == "success") {
              var data = res["Data"];

              maAmount.text = data["mamount"].toString();
              String dateConvert = data["mdate"].toString();

              DateTime inputDate = DateTime.parse(dateConvert);

              // Format the date as "dd/MM/yyyy"
              String formattedDate = DateFormat('dd/MM/yyyy').format(inputDate);

              maDate.text = formattedDate;

              maRate.text = "${data["roi"]} %";

              Loader.hide();
            } else {
              Loader.hide();
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: res["Message"].toString(),
                  );
                },
              );
              return;
            }
          } else {
            Loader.hide();

            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertBox(
                  title: "Alert",
                  description: "Server is not responding..!",
                );
              },
            );
            return;
          }
        } else {
          Loader.hide();
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: "Alert",
                description: "Server failed..!",
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
              description: "Unable To connect Server",
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
            description: "Unable To connect Server",
          );
        },
      );
      return;
    }
  }

// Add Data After Click Button First Call This method

  Future<void> AddNomineeDetails(String am) async {
    if (scheme.toString().isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please select scheme",
          );
        },
      );
      return;
    }

    if (am != "") {
      int amountVal = int.parse(am);

      if (amountVal < 10) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertBox(
              title: "Alert",
              description: "Minimum amount of Deposit Rs.10",
            );
          },
        );
        return;
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Amount",
          );
        },
      );
      return;
    }

    if (timePSet.toString() == "") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Select Time Period",
          );
        },
      );
      return;
    }

    if (maRate.text == "" && maAmount.text == "" && maDate.text == "") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Select Tenure of Your Choice",
          );
        },
      );
      return;
    }

    if (debitNumber.toString() == "") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Select Debit Account Number",
          );
        },
      );
      return;
    }

    var amount = double.parse(amGetCheck.toString());
    int enterAmount = int.parse(am);

    if (amount < enterAmount) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Insufficient Balance",
          );
        },
      );
      return;
    }

    if (dayofMonth == "") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description:
                "Please Select Day of Month when installment to be Debited",
          );
        },
      );
      return;
    }

    SelectedDataUser.accNumberBank = debitNumber.toString();
    SelectedDataUser.amountEntered = am;
    SelectedDataUser.mIntrest = maRate.text;
    SelectedDataUser.mAmount = maAmount.text;
    SelectedDataUser.mDate = maDate.text;

    SelectedDataUser.day = otherDay;
    SelectedDataUser.month = otherMonth;
    SelectedDataUser.year = otherYear;

    // Scheme

    SelectedDataUser.mStateNameGet = mStateNameGet.toString();
    SelectedDataUser.sglcode = sglcode.toString();
    SelectedDataUser.fdkid = ActkidGet.toString();

    SelectedDataUser.dayofMonth = dayofMonth.toString();

    ADDDATA();
  }

  // 2nd final Add Data API

  Future<void> ADDDATA() async {
          Loader.show(context,
          progressIndicator: const CircularProgressIndicator());  
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

         
//------------------------------------------------------------------------------------------------------
      // String apiUrl = "rest/AccountService/sNomData";

          String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

    // String branchCode = context.read<SessionProvider>().get('branchCode');
     //String mobileNo = context.read<SessionProvider>().get('mobileNo');
    String customerId = context.read<SessionProvider>().get('customerId');

      String apiUrl = ApiConfig.sNomData;

      String jsonString = jsonEncode({
        "customerid": customerId,
      });

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonString,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      try {
        if (response.statusCode == 200) {
          if (response.body != "") {
            var res = jsonDecode(response.body);

            if (res["Result"].toString().toLowerCase() == "success") {
              var data = jsonDecode(res["Data"]);

              List<NomineedetailsRD> nomineedetaisl = <NomineedetailsRD>[];

              // Pending data Add

              for (int i = 0; i < data.length; i++) {
                var gatData = data[i];

                NomineedetailsRD vObject = NomineedetailsRD();

                vObject.nomineeNamee = gatData["nom_ename"].toString();
                vObject.nomineeRelationshipp =
                    gatData["nom_erel"].toString(); //mother
                vObject.nomineeAgee = gatData["nom_age"].toString(); // age
                vObject.nomineeDobb = gatData["nom_dob"].toString(); // dob
                vObject.nomineeMinorr =
                    gatData["nom_minor"].toString(); // Minor Ya Major
                vObject.nomineeAddress11 =
                    gatData["nomadr_ehno"].toString(); // Address 1
                vObject.nomineeAddess22 =
                    gatData["nomadr_eloc"].toString(); // Address 2
                vObject.nomieeCityy = gatData["nomadr_ecity"].toString(); //City
                vObject.pincodee =
                    gatData["nomadr_pincode"].toString(); //Pincode
                vObject.idd = gatData["nomadr_stateid"].toString(); //id

                RDGetData.nomineeNameRD = vObject.nomineeNamee.toString();
                RDGetData.nomineeRealtionshipRD =
                    vObject.nomineeRelationshipp.toString();
                RDGetData.nomineeageRD = vObject.nomineeAgee.toString();
                RDGetData.nomineeAddress1RD =
                    vObject.nomineeAddress11.toString();
                RDGetData.nomineeAddress2RD =
                    vObject.nomineeAddess22.toString();
                RDGetData.nomineeCityRD = vObject.nomieeCityy.toString();
                RDGetData.nomineeStateRD = vObject.pincodee.toString();

                nomineedetaisl.add(vObject);
              }

//------------------------------------------------------------------------------------------------------

              // context.push("/NomineeRD");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NomineeRD()));

              Loader.hide();
            } else {
              Loader.hide();
//------------------------------------------------------------------------------------------------------
              // context.push("/NomineeRD");

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NomineeRD()));
            }
          } else {
            Loader.hide();
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertBox(
                  title: "Alert",
                  description: "Server is not responding..!",
                );
              },
            );

            return;
          }
        } else {
          Loader.hide();
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: "Alert",
                description: "Server failed..!",
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
              description: "Unable To connect Server",
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
            description: "Unable To connect Server",
          );
        },
      );
      return;
    }
  }

  // Get Relation List for Nominee pass data next page

  Future<void> relationGet() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
//------------------------------------------------------------------------------------------------------
      //  Loader.show(context, progressIndicator: CircularProgressIndicator());

      //String apiUrl = "rest/AccountService/getrelationship";

      String apiUrl = ApiConfig.getrelationship;

      String jsonString = jsonEncode({});

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonString,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      try {
        if (response.statusCode == 200) {
          if (response.body != "") {
            nomineeName.clear();

            var res = jsonDecode(response.body);

            if (res["Result"].toString().toLowerCase() == "success") {
              var data = jsonDecode(res["Data"]);

              for (int i = 0; i < data.length; i++) {
                var getValue = data[i];

                NomineeListName vObject = NomineeListName();

                vObject.relmas_code = getValue["relmas_code"].toString();
                vObject.relmas_ename = getValue["relmas_ename"].toString();
                // vObject.relmas_kid = getValue["relmas_kid"];

                nomineeName.add(vObject);
              }

              //  Loader.hide();

              RelationList.nomineeEname = nomineeName;
            } else {
              //    Loader.hide();
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: res["Message"].toString(),
                  );
                },
              );
              return;
            }
          } else {
            //   Loader.hide();
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertBox(
                  title: "Alert",
                  description: "Server is not responding..!",
                );
              },
            );
            return;
          }
        } else {
          //     Loader.hide();
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: "Alert",
                description: "Server failed..!",
              );
            },
          );
          return;
        }
      } catch (e) {
        //  Loader.hide();
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertBox(
              title: "Alert",
              description: "Unable To connect Server",
            );
          },
        );
        return;
      }
    } catch (e) {
      //  Loader.hide();
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Unable To connect Server",
          );
        },
      );
      return;
    }
  }

// day select for payment
  void onDayOFMonthAccount(String day) {
    dayofMonth = day.toString();
  }
}
