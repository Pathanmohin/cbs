// ignore_for_file: non_constant_identifier_names, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fdrdmodel/model.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fdrfdatasave/datasave.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/rd/nominee/addaddress/rdaddaddress.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/rd/nominee/ifage18/rdselfage.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:intl/intl.dart';

class NomineeRD extends StatefulWidget {
  const NomineeRD({super.key});

  @override
  State<NomineeRD> createState() => _NomineeRDState();
}

class _NomineeRDState extends State<NomineeRD> {
  int? _age;
  bool _isAdult = false;

  NomineeListName? NomineeRelationshipData;

  List<NomineeListName> nomineeName = RelationList.nomineeEname;

  List<String> gender = ["Male", "Female"];

  String? genderValue;

  String? globalGenderValue;

  String? relationValue;

  DateTime _selectedStartDate = DateTime.now();

  TextEditingController _dateStartController = TextEditingController();
  TextEditingController name = TextEditingController();

  @override
  void initState() {
    super.initState();

    _dateStartController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());

    if (FDGetData.nomineeName != "") {
      name.text = FDGetData.nomineeName;
    }
  }

  int _calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    Future<void> _selectStartDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedStartDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );

      if (picked != null) {
        setState(() {
          _selectedStartDate = picked;

          _age = _calculateAge(picked);

          _isAdult = _age! > 18;

          _dateStartController.text =
              DateFormat('dd-MM-yyyy').format(_selectedStartDate);
        });
      }
    }

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
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
                "Nominee Detail",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
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
                          "Nominee Name",
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
                            controller: name,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: 'Nominee Name',
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
                                          textScaler:
                                              const TextScaler.linear(1.1)),
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
                                          textScaler:
                                              const TextScaler.linear(1.1)),
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
                          child: SizedBox(
                            width: size.width * 0.9,
                            child: TextField(
                              readOnly: true,
                              controller: _dateStartController,
                              onTap: () => _selectStartDate(context),
                              decoration: const InputDecoration(
                                labelText: 'Date Of Birth',
                                prefixIcon: Icon(Icons.calendar_today),
                              ),
                            ),
                          )),
                      InkWell(
                        onTap: () async {
                          await setNomineeData();
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
                                "ADD ADDRESS",
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

  void onGenderSelect(String genderGet) {
    globalGenderValue = genderGet;
  }

  Future<void> setNomineeData() async {
    if (name.text == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Nominee Name",
          );
        },
      );

      return;
    }

    if (relationValue == "" ||relationValue == null) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Select Nominee RelationShip",
          );
        },
      );

      return;
    }

    if (globalGenderValue == "" ||globalGenderValue == null) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Select Gender",
          );
        },
      );

      return;
    }

    if (globalGenderValue == "Male") {
      SelectedDataUser.gender = "M";
    } else if (globalGenderValue == "Female") {
      SelectedDataUser.gender = "F";
    }

    SelectedDataUser.nomineeName = name.text;
    SelectedDataUser.relationName = relationValue.toString();
    SelectedDataUser.DateOFBirth = _dateStartController.text;

    CityData.city.clear();

    if (_isAdult == false) {
      // context.push('/ADDADDRESSRD');

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ADDADDRESSRD()));

//-------------------------------------
//-----------------------------------------------------------------
      SelectedDataUser.Minor = "M";
    } else {
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const SelfRDAgePage()));

      // context.push('/SelfRDAgePage');

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SelfRDAgePage()));

//------------------------------------------------------------------------------------------------------
      SelectedDataUser.Minor = "N";
    }
  }

  // RelationShip select
  void RelationGet(NomineeListName nomineeListName) {
    relationValue = nomineeListName.relmas_ename;
  }
}
