// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings, unused_local_variable, non_constant_identifier_names, unnecessary_null_comparison

import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:hpscb/presentation/view/applydashboard/currentaccount/CAPreDetails/CAPreDetails.dart';
import 'package:hpscb/presentation/view/applydashboard/savingaccount/branchmodel.dart';
import 'package:hpscb/presentation/view/applydashboard/savingaccount/savaccmodel.dart';
import 'package:hpscb/presentation/view/applydashboard/savingaccount/saveverifydata.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fdrdmodel/model.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fdrfdatasave/datasave.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CAOccupations extends StatefulWidget {
  const CAOccupations({super.key});

  @override
  State<CAOccupations> createState() => _CAOccupationsState();
}

class _CAOccupationsState extends State<CAOccupations> {
  int currentStep = 0;

  // First Step 1
  String? occupationSelect;
  final TextEditingController annualIncomeCon = TextEditingController();
  final TextEditingController motherNameCon = TextEditingController();

  List<Ocp> occupationList = <Ocp>[];

  final TextEditingController nomNameCon = TextEditingController();

  List<String> gender = ["Male", "Female", "Other"];

  String? genderValue;

  String? globalGenderValue;

  String? branchName;
  String? ocpBehav;

// Ocuption

  Ocp? ocu;

// Branch

  String? selectedOccupation;
  String? selectedIncomeSource;

  StateObjectList? mStateData;
  StateObjectList? mcityData;
  BankDetailsModel? branchData;

// Nominee List

  NomineeListName? NomineeRelationshipData;

  List<NomineeListName> nomineeName = [];

  String? relationValue;

  TextEditingController pinNumber = TextEditingController();
  TextEditingController add1 = TextEditingController();
  TextEditingController add2 = TextEditingController();

  List<StateObjectList> stateList = <StateObjectList>[];

  List<BankDetailsModel> branch = <BankDetailsModel>[];

  String selectedState = "";
  String selectedCity = "";
  String selectDist = "";
  String cityPINCode = "";
  String selectBranch = "";

  final List<String> occupations = [
    'Software Engineer',
    'Teacher',
    'Doctor',
    'Accountant',
    'Business Owner',
    'Freelancer',
    'Student',
    'Retired',
    'Government Employee',
    'Unemployed'
  ];

  final List<String> incomeSources = [
    'Salary',
    'Business Profits',
    'Freelance/Contract Work',
    'Pension',
    'Rental Income',
    'Investments',
    'Family Support',
    'Other'
  ];

  DateTime _selectedStartDate = DateTime.now();

  TextEditingController _dateStartController = TextEditingController();
  TextEditingController name = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _dateStartController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());

    if (FDGetData.nomineeName != "") {
      name.text = FDGetData.nomineeName;
    }
  }

  String? selectedSource;

  List<StateObjectList> cityList = [];

  String? _selectedOption = 'no';

  List<Step> stepList() => [
        Step(
          title: const Text(
            'Professional & Personal Details',
            style: TextStyle(
                color: Color(0xFF0057C2), fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "Occupation",
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
                            child: DropdownButton<Ocp>(
                               dropdownColor: AppColors.onPrimary,
                              value: ocu,
                              hint: const Text(
                                'Select Occupation',
                                style: TextStyle(
                                  color: Color(0xFF898989),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              isExpanded: true,
                              items: occupationList.map((Ocp source) {
                                return DropdownMenuItem<Ocp>(
                                  value:
                                      source, // Use the source directly as the value
                                  child: Text(
                                    source.ocpEname
                                        .toString(), // Display the source
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  ocu = newValue; // Update the selected source
                                });
                                // Call your method here, similar to SelectedIndexChanged
                                onOccSelect(newValue!);
                              },
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "Gross annual income in Ruppes (₹)",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 55,
                          child: TextFormField(
                            controller: annualIncomeCon,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Gross annual income',
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "Mother's full name",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: motherNameCon,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Mother's full name",
                                hintText: 'e.g Lata Singh'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          isActive: currentStep >= 0,
          state: currentStep == 0 ? StepState.editing : StepState.complete,
        ),
        Step(
          title: const Text(
            'Branch Select',
            style: TextStyle(
                color: Color(0xFF0057C2), fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        "State",
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
                          child: DropdownButton<StateObjectList>(
                             dropdownColor: AppColors.onPrimary,
                            value: mStateData,
                            hint: const Text(
                              'Select State',
                              style: TextStyle(
                                color: Color(0xFF898989),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            icon: const Icon(Icons.arrow_drop_down),
                            isExpanded: true,
                            items: stateList.map((StateObjectList obj) {
                              return DropdownMenuItem<StateObjectList>(
                                value: obj,
                                child: Text(
                                  "${obj.mStateName}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                mStateData = newValue;
                              });

                              // Call your method here, similar to SelectedIndexChanged
                              onStateSelect(newValue!);
                            },
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        "District",
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
                          child: DropdownButton<StateObjectList?>(
                             dropdownColor: AppColors.onPrimary,
                            value: mcityData,
                            hint: const Text(
                              'Select District',
                              style: TextStyle(
                                color: Color(0xFF898989),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            icon: const Icon(Icons.arrow_drop_down),
                            isExpanded: true,
                            items: cityList.map((StateObjectList? obj) {
                              return DropdownMenuItem<StateObjectList?>(
                                value: obj,
                                child: Text(
                                  "${obj!.cityName}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                mcityData = newValue;
                              });

                              // Call your method here, similar to SelectedIndexChanged
                              onCityCode(newValue!);
                            },
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        "Branch",
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
                          child: DropdownButton<BankDetailsModel?>(
                             dropdownColor: AppColors.onPrimary,
                            value: branchData,
                            hint: const Text(
                              'Select Branch',
                              style: TextStyle(
                                color: Color(0xFF898989),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            icon: const Icon(Icons.arrow_drop_down),
                            isExpanded: true,
                            items: branch.map((BankDetailsModel? obj) {
                              return DropdownMenuItem<BankDetailsModel?>(
                                value: obj,
                                child: Text(
                                  "${obj!.brnEaddr}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                branchData = newValue;
                              });

                              // Call your method here, similar to SelectedIndexChanged

                              BranchCode(newValue!);
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    )
                  ],
                ),
              ),
            ),
          ),
          isActive: currentStep >= 1,
          state: currentStep == 1 ? StepState.editing : StepState.complete,
        ),
        Step(
          title: const Text(
            'Nominee Add',
            style: TextStyle(
                color: Color(0xFF0057C2), fontWeight: FontWeight.bold),
          ),
          content: Container(
              child: Column(
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 32,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "Would you like to add a nominee?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'yes',
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
                  ),
                  const Text('Yes, Add nominee'),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'no',
                    autofocus: true,
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
                  ),
                  const Text('No, I do not wish to nominate anyone'),
                ],
              ),
              if (_selectedOption == 'yes')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nominee Details',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        "Nominee Name",
                        style: TextStyle(
                            color: Color(0xFF0057C2),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          autofocus: true,
                          controller: nomNameCon,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Nominee Name",
                              hintText: 'e.g Ram Singh'),
                          onFieldSubmitted: (value) async {},
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        "Nominee RelationShip",
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
                          child: DropdownButton<NomineeListName>(
                             dropdownColor: AppColors.onPrimary,
                            value: NomineeRelationshipData,
                            hint: const Text(
                              'Select Nominee RelationShip',
                              style: TextStyle(
                                color: Color(0xFF898989),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            icon: const Icon(Icons.arrow_drop_down),
                            isExpanded: true,
                            items: nomineeName.map((NomineeListName obj) {
                              return DropdownMenuItem<NomineeListName>(
                                value: obj,
                                child: Builder(builder: (context) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                        textScaler: const TextScaler.linear(1.1)),
                                    child: Text(
                                      "${obj.relmas_ename}",
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
                                NomineeRelationshipData = newValue;
                              });

                              // Call your method here, similar to SelectedIndexChanged
                              RelationGet(newValue!);
                            },
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        "Gender",
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
                          child: DropdownButton<String?>(
                             dropdownColor: AppColors.onPrimary,
                            value: genderValue,
                            hint: const Text(
                              'Select Gender',
                              style: TextStyle(
                                color: Color(0xFF898989),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            icon: const Icon(Icons.arrow_drop_down),
                            isExpanded: true,
                            items: gender.map((String? obj) {
                              return DropdownMenuItem<String?>(
                                value: obj,
                                child: Builder(builder: (context) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                        textScaler: const TextScaler.linear(1.1)),
                                    child: Text(
                                      obj.toString(),
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
                                genderValue = newValue;
                              });

                              // Call your method here, similar to SelectedIndexChanged
                              onGenderSelect(newValue!);
                            },
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        "Date Of Birth",
                        style: TextStyle(
                            color: Color(0xFF0057C2),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                        child: TextField(
                          readOnly: true,
                          controller: _dateStartController,
                          onTap: () => _selectStartDate(context),
                          decoration: const InputDecoration(
                            labelText: 'Date Of Birth',
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                        )),
                  ],
                ),
            ],
          )),
          isActive: currentStep >= 2,
          state: currentStep == 2 ? StepState.editing : StepState.complete,
        ),
      ];

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _selectedStartDate = picked;

        _dateStartController.text =
            DateFormat('dd-MM-yyyy').format(_selectedStartDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentStep == 0) {
      if (occupationList.isEmpty) {
        OccupationList();
      }
    }

    if (currentStep == 1) {
      if (stateList.isEmpty) {
        StateGet();
      }

      cityList = CityData.city;
    }

    if (currentStep == 2) {
      if (nomineeName.isEmpty) {
        relationGet();
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Basic Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0057C2),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Stepper(
        currentStep: currentStep,
        steps: stepList(),
        onStepContinue: currentStep < stepList().length
            ? () async {
                if (currentStep == 0) {
                  if (occupationSelect!.isEmpty ||
                      occupationSelect == "" ||
                      occupationSelect == null) {
                    await showCustomizeFlushbar(
                        context, "Please select occupation");
                    return;
                  } else if (annualIncomeCon.text == null ||
                      annualIncomeCon.text.isEmpty) {
                    await showCustomizeFlushbar(
                        context, "Please enter gross annual income");
                    return;
                  } else if (motherNameCon.text == null ||
                      motherNameCon.text.isEmpty) {
                    await showCustomizeFlushbar(
                        context, "Please enter mother's name");
                    return;
                  }

                  ProfessionalData.occupation = occupationSelect.toString();
                   ProfessionalData.ocpBehav = ocpBehav.toString();
                  ProfessionalData.grossIncome = annualIncomeCon.text;
                  ProfessionalData.mothername = motherNameCon.text;

                  setState(() => currentStep += 1);
                } else if (currentStep == 1) {
                  if (selectedState.isEmpty ||
                      selectedState == "" ||
                      selectedState == null) {
                    await showCustomizeFlushbar(context, "Please select state");
                    return;
                  } else if (selectedCity.isEmpty ||
                      selectedCity == "" ||
                      selectedCity == null) {
                    await showCustomizeFlushbar(context, "Please select city");
                    return;
                  } else if (selectBranch.isEmpty ||
                      selectBranch == "" ||
                      selectBranch == null) {
                    await showCustomizeFlushbar(
                        context, "Please select branch");
                    return;
                  }

                  BranchDetails.stateBranch = selectedState;

                  BranchDetails.cityBranch = selectedCity;
                  BranchDetails.branchName = branchName.toString();

                    BranchDetails.selectDist = selectDist;
                     BranchDetails.cityPINCode = cityPINCode;


                   BranchDetails.branchcode = selectBranch.toString();

                  setState(() => currentStep += 1);
                } else if (currentStep == 2) {
                  if (_selectedOption == "yes") {
                    if (nomNameCon.text.isEmpty ||
                        nomNameCon.text == "" ||
                        nomNameCon.text == null) {
                      await showCustomizeFlushbar(
                          context, "Please enter nominee name");
                      return;
                    } else if (relationValue!.isEmpty ||
                        relationValue == "" ||
                        relationValue == null) {
                      await showCustomizeFlushbar(
                          context, "Please select relationship");
                      return;
                    } else if (globalGenderValue!.isEmpty ||
                        globalGenderValue == "" ||
                        globalGenderValue == null) {
                      await showCustomizeFlushbar(
                          context, "Please select gender");
                      return;
                    } else if (_dateStartController.text.isEmpty ||
                        _dateStartController.text == "" ||
                        _dateStartController.text == null) {
                      await showCustomizeFlushbar(context, "Please select dob");
                      return;
                    }
                  }

                  NomeenieData.nomniShow = _selectedOption.toString();
                  NomeenieData.nomiName = nomNameCon.text;
                  NomeenieData.nomiRelation = relationValue.toString();
                  NomeenieData.nomiGender = globalGenderValue.toString();
                  NomeenieData.nomiDob = _dateStartController.text;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CAPreView()));
                }
              }
            : null,
        onStepCancel:
            currentStep > 0 ? () => setState(() => currentStep -= 1) : null,
      ),
    );
  }

  void onGenderSelect(String genderGet) {
    globalGenderValue = genderGet;
  }

  Future<void> StateGet() async {
    //   stateList.clear();

    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      Loader.show(context, progressIndicator: const CircularProgressIndicator());

      String apiUrl = "rest/AccountService/getStateName";

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
            var res = jsonDecode(response.body);

            if (res["Result"].toString().toLowerCase() == "success") {
              var data = jsonDecode(res["Data"]);

              for (int i = 0; i < data.length; i++) {
                StateObjectList vObject = StateObjectList();

                var getState = data[i];

                vObject.mStateCode = getState["stat_code"].toString();
                vObject.mStateID = getState["stat_kid"].toString();
                vObject.mStateName = getState["stat_ename"].toString();
                stateList.add(vObject);
              }

              setState(() {});

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

  Future<void> getCityList(String mStateCode) async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      Loader.show(context, progressIndicator: const CircularProgressIndicator());

      String apiUrl = "rest/AccountService/getdistName";

      String jsonString = jsonEncode({
        "Statecode": mStateCode,
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

              List<StateObjectList> ListGet = <StateObjectList>[];

              for (int i = 0; i < data.length; i++) {
                StateObjectList vObject = StateObjectList();

                var getState = data[i];

                vObject.pincode = getState["dist_pincode"].toString();
                vObject.city_kid = getState["dist_kid"].toString();
                vObject.cityName = getState["dist_ename"].toString() +
                    " (${getState["dist_pincode"]})";

                vObject.eCityName = getState["dist_ename"].toString();
                ListGet.add(vObject);
              }

              CityData.city = ListGet;

              Loader.hide();

              setState(() {});
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

  // --------------------------------------------------------------------------- State Select -----------

  // Select State
  void onStateSelect(StateObjectList stateObjectList) {
   
    String mStateCodeGet = stateObjectList.mStateCode.toString();

    String mStateNameGet = stateObjectList.mStateName.toString();

    String mStateIDGet = stateObjectList.mStateID.toString();

// city list refrese

    List<StateObjectList> ListGet = <StateObjectList>[];

    CityData.city = ListGet;

    StateObjectList? mcityDataList;

    mcityData = mcityDataList;

// branch list refrese

    List<BankDetailsModel> listBGet = <BankDetailsModel>[];

    branch = listBGet;

    BankDetailsModel? bankModel;

    branchData = bankModel;

    setState(() {});

    selectedState = mStateNameGet;



    // List<StateObjectList> ListGet = <StateObjectList>[];

    // cityList = ListGet;

    getCityList(mStateIDGet);
  }

  // ----------------------------------------------------------- City Select -------------------------------

  void onCityCode(StateObjectList stateObjectList) {
    // branch list refrese

    List<BankDetailsModel> listBGet = <BankDetailsModel>[];

    branch = listBGet;

    BankDetailsModel? bankModel;

    branchData = bankModel;

    setState(() {});

    selectedCity = stateObjectList.cityName!;

    selectDist = stateObjectList.eCityName.toString();

    cityPINCode = stateObjectList.pincode.toString();

    String cityID = stateObjectList.city_kid.toString();

    BranchGet(cityID, cityPINCode);
  }

// ---------------------------------------------------------------- Select Branch -----------------------
  void BranchCode(BankDetailsModel stateObjectList) {
    selectBranch = stateObjectList.brnBrcod.toString();

    String brnBkcod = stateObjectList.brnBkcod.toString();
    String brnEaddr = stateObjectList.brnEaddr.toString();
    String brnEname = stateObjectList.brnEname.toString();

    branchName = brnEaddr;
  }

// ---------------------------------------- Occupation api --------------------------

  Future<void> OccupationList() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      String apiUrl =
          "rest/AccountService/getocupationMaster";

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
          var res = json.decode(response.body);

          if (res["Result"].toString().toLowerCase() == "success") {
            var getList = json.decode(res["Data"]);

            var lGetData = getList["Data"];

            for (int i = 0; i < lGetData.length; i++) {
              var allRes = lGetData[i];

              Ocp vObject = Ocp();

              vObject.ocpCode = allRes["ocp_code"].toString();
              vObject.ocpHname = allRes["ocp_hname"].toString();
              vObject.ocpEname = allRes["ocp_ename"].toString();
              vObject.ocpKid = allRes["ocp_kid"].toString();
              vObject.ocpBehav = allRes["ocp_behav"].toString();

              occupationList.add(vObject);
            }

            Loader.hide();

            setState(() {});
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

  Future<void> BranchGet(String cityID, String cityPINCode) async {
    //   stateList.clear();

    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      String apiUrl = "rest/AccountService/getBrnName";

      String jsonString =
          jsonEncode({"citykid": cityID, "pincode": cityPINCode});

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

              if (data.length == 0) {
                Loader.hide();
                await showCustomizeFlushbar(context,
                    "Currently, a branch is not available in this district.");
                return;
              }

              branch.clear();

              for (int i = 0; i < data.length; i++) {
                BankDetailsModel vObject = BankDetailsModel();

                var getList = data[i];

                vObject.brnBrcod = getList["brn_brcod"];

                vObject.brnEaddr = getList["brn_eaddr"];
                vObject.brnEname = getList["brn_ename"];
                vObject.brnEbank = getList["brn_ebank"];
                vObject.brnIfsc = getList["brn_ifsc"];
                vObject.brnType = getList["brn_type"];
                vObject.brnBkcod = getList["brn_bkcod"];
                vObject.brnZoacode = getList["brn_zoacode"];
                vObject.brnPtype = getList["brn_ptype"];
                vObject.brnHname = getList["brn_hname"];

                branch.add(vObject);
              }

              setState(() {});

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

  
  //   Future<void> _checkLatency() async{
  //   final stopwatch = Stopwatch()..start();

  //   try {

  //     var response = await http.get(
  //       Uri.parse('https://www.google.com/'));

  //        print(response.statusCode);

  //     stopwatch.stop();
  //     if (response.statusCode == 200) {

  //       if(stopwatch.elapsedMilliseconds > 5000){
  //                await QuickAlert.show(
  //                 context: context,
  //                 type: QuickAlertType.warning,

  //                 headerBackgroundColor : Colors.yellow,
  //                 title:  'Oops...',
  //                 text: "There’s a minor network issue at the moment. Click 'Yes' to keep your connection active, but be aware it might be risky. Select 'No' to log off securely.",
  //                 confirmBtnText: 'Yes',
  //                 cancelBtnText: 'No',

  //                 onConfirmBtnTap: (){

  //                   Navigator.pop(context);

  //                   FinalDataAdd();

  //                 },

  //                 onCancelBtnTap: (){
  //                   Navigator.pop(context);
  //                 },
  //                 showCancelBtn: true,
  //                 confirmBtnColor: Colors.green,
  //                 barrierDismissible: false
  //                 );

  //       }else{

  //         FinalDataAdd();

  //       }

  //     } else {
  //       FinalDataAdd();
  //     }
  //   } catch (e) {
  //     FinalDataAdd();
  //   }
  // }

  String formatPhoneNumber(String phoneNumber) {
    // Remove the country code by removing the first 3 characters
    return phoneNumber.substring(3);
  }

  // ------------------- alert

  Future<void> showCustomizeFlushbar(BuildContext context, String msg) {
    return Flushbar(
      messageText: Builder(builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.1)),
          child: Text(
            msg,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
              color: Color(0xFFFEFEFE),
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }),
      boxShadows: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 3,
        )
      ],
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 26.0),
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(8.0),
      backgroundColor: const Color(0xFFB8585B),
      flushbarPosition: FlushbarPosition.TOP,
      forwardAnimationCurve: Curves.bounceIn,
    ).show(context);
  }

  //----------------------------------------------------------------- Select Occupation
  void onOccSelect(Ocp? occupation) {
    occupationSelect = occupation?.ocpEname.toString();

    String? ocpHname = occupation?.ocpHname.toString();
    String? ocpCode = occupation?.ocpCode.toString();
    ocpBehav = occupation?.ocpBehav.toString();
    String? ocpKid = occupation?.ocpKid.toString();
  }

  // RelationShip select
  void RelationGet(NomineeListName nomineeListName) {
    relationValue = nomineeListName.relmas_ename;
  }

  Future<void> relationGet() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      //  Loader.show(context, progressIndicator: CircularProgressIndicator());

      String apiUrl = "rest/AccountService/getrelationship";

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
}
