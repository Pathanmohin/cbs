// ignore_for_file: prefer_final_fields, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, non_constant_identifier_names, unused_local_variable, unrelated_type_equality_checks

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/createfdrd.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fdrdmodel/model.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fdrfdatasave/datasave.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ADDADDRESS extends StatefulWidget {
  const ADDADDRESS({super.key});

  @override
  State<ADDADDRESS> createState() => _ADDADDRESSState();
}

class _ADDADDRESSState extends State<ADDADDRESS> {
  NomineeListName? NomineeRelationshipData;

  StateObjectList? mStateData;
  StateObjectList? mcityData;

  String? relationValue;

  List<NomineeListName> nomineeName = RelationList.nomineeEname;

  TextEditingController pinNumber = TextEditingController();
  TextEditingController add1 = TextEditingController();
  TextEditingController add2 = TextEditingController();
  TextEditingController guardianName = TextEditingController();

  List<StateObjectList> stateList = <StateObjectList>[];

  String selectedState = "";
  String selectedStateCode = "";
  String selectedCity = "";

  DateTime _selectedStartDate = DateTime.now();

  TextEditingController _dateStartController = TextEditingController();

  @override
  void initState() {
    List<StateObjectList> city = <StateObjectList>[];

    CityData.city = city;
    super.initState();

    _dateStartController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
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

  int? _age;
  bool _isAdult = false;

  @override
  Widget build(BuildContext context) {
    if (stateList.isEmpty) {
      StateGet();
    }

    List<StateObjectList> cityList = CityData.city;

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

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);

        // context.pop(context);

        return false;
      },
      child: Builder(builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.1)),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Guardian Detail",
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
                          "Guardian Name",
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
                            controller: guardianName,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: 'Guardian Name',
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
                          "Guardian RelationShip",
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
                            width: size.width,
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
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "Address 1",
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
                            controller: add1,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: 'Enter Address 1',
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
                          "Address 2",
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
                            controller: add2,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: 'Enter Address 2',
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
                          "City",
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
                              value: mcityData,
                              hint: const Text(
                                'Select City',
                                style: TextStyle(
                                  color: Color(0xFF898989),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              isExpanded: true,
                              items: cityList.map((StateObjectList obj) {
                                return DropdownMenuItem<StateObjectList>(
                                  value: obj,
                                  child: Builder(builder: (context) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          textScaler:
                                              const TextScaler.linear(1.1)),
                                      child: Text(
                                        "${obj.cityName}",
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
                          "Pin Code",
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
                            keyboardType: TextInputType.number,
                            enabled: false,
                            controller: pinNumber,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: 'Enter Pin Code',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          submitData();
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
                                "SUBMIT",
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
      }),
    );
  }

  Future<void> StateGet() async {
    //   stateList.clear();

    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

//------------------------------------------------------------------------------------------------------
      // String apiUrl = "rest/AccountService/getStateName";

      String apiUrl = ApiConfig.getStateName;

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

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

//------------------------------------------------------------------------------------------------------
      //String apiUrl = "rest/AccountService/getdistName";

      String apiUrl = ApiConfig.getdistName;

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
                vObject.cityName =
                    "${getState["dist_ename"]} (${getState["dist_pincode"]})";
                ListGet.add(vObject);
              }

              CityData.city = ListGet;

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

  // Select State
  void onStateSelect(StateObjectList stateObjectList) {
    String mStateCodeGet = stateObjectList.mStateCode.toString();

    String mStateNameGet = stateObjectList.mStateName.toString();

    String mStateIDGet = stateObjectList.mStateID.toString();

    pinNumber.text = "";

    List<StateObjectList> ListGet = <StateObjectList>[];

    CityData.city = ListGet;

    StateObjectList? mcityDataList;

    mcityData = mcityDataList;

    setState(() {});

    selectedState = mStateNameGet;

    // List<StateObjectList> ListGet = <StateObjectList>[];

    // cityList = ListGet;

    selectedStateCode = mStateCodeGet;

    getCityList(mStateIDGet);
  }

  void onCityCode(StateObjectList stateObjectList) {
    selectedCity = stateObjectList.cityName.toString();

    pinNumber.text = stateObjectList.pincode.toString();
  }

  Future<void> submitData() async {
    if (guardianName.text == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Guardian Name",
          );
        },
      );

      return;
    }
    if (relationValue == "" || relationValue == null) {
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
    if (_isAdult == false) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please enter age must be at least 18 years old.",
          );
        },
      );

      return;
    }

    if (add1.text == "" || add1.text == null) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Address 1",
          );
        },
      );

      return;
    }

    if (add2.text == "" ||add2.text == null) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Address 2",
          );
        },
      );

      return;
    }

    if (selectedState == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Select State",
          );
        },
      );

      return;
    }

    if (selectedCity == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(title: "Alert", description: "Please Select City");
        },
      );

      return;
    }

    if (pinNumber.text == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(title: "Alert", description: "Please Select Pincode");
        },
      );

      return;
    }

    _checkLatency();
  }

  Future<void> FinalDataAdd() async {
    try {
      //  String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
//------------------------------------------------------------------------------------------------------
      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      //String apiUrl = "rest/AccountService/createFD";

      String apiUrl = ApiConfig.createFD;

      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

      String accountNo = context.read<SessionProvider>().get('accountNo');
      String sessionId = context.read<SessionProvider>().get('sessionId');
      String branchCode = context.read<SessionProvider>().get('branchCode');
      String customerId = context.read<SessionProvider>().get('customerId');

      var nomineeDetail = UserInput2(
          sEName: SelectedDataUser.nomineeName.toString(),
          sERelation: SelectedDataUser.relationName.toString(),
          sSex: SelectedDataUser.gender.toString(),
          sMinor: SelectedDataUser.Minor.toString(),
          sEDesc: "",
          sGuardian: "N",
          sORelation: "",
          sOName: "",
          sODescription: "",
          sFlag: "");

      var gardienceDetails = UserInput3(
        guardianname: guardianName.text,
        guardianRel: relationValue.toString(),
        dob: _dateStartController.text,
        guardianperaddressline1: add1.text,
        guardianperaddressline2: add2.text,
        guardianstatename: selectedState.toString(),
        guardianstatecode: selectedStateCode.toString(),
        guardiancityname: selectedCity.toString(),
        guardiancitycode: pinNumber.text,
        guardianpincode: pinNumber.text,
      );
//------------------------------------------------------------------------------------------------------
      var jsonString = UserInput1(
        customerId: customerId.toString(),
        FdScheme: SelectedDataUser.mStateNameGet.toString(),
        fdCode: SelectedDataUser.sglcode.toString(),
        month: SelectedDataUser.month.toString(),
        year: SelectedDataUser.year.toString(),
        day: SelectedDataUser.day.toString(),
        instPayable: "",
        intrestRate: removePercentageSign(SelectedDataUser.mIntrest),
        Maturityamount: SelectedDataUser.mAmount.toString(),
        Maturitydate: SelectedDataUser.mDate.toString(),
        sglcode: SelectedDataUser.sglcode.toString(),
        accno: SelectedDataUser.accNumberBank.toString(),
        amount: SelectedDataUser.amountEntered.toString(),
        Remark: "FD",
        fdKid: SelectedDataUser.fdkid.toString(),
        brnCode: branchCode.toString(),
        maturityInst: SelectedDataUser.switchButton.toString(),
        NominieeDetail: nomineeDetail.toJson(),
        gardianDetails: gardienceDetails.toJson(),
      );

      String json = jsonEncode(jsonString.toJson());

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "tokenNo": tokenNo,
        "userID": userid,
      };

//------------------------------------------------------------------------------------------------------
      String encrypted = AESencryption.encryptString(json, ibUsrKid);

      final parameters = <String, dynamic>{
        "data": encrypted,
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      try {
        if (response.statusCode == 200) {
          if (response.body != "") {
            var data = jsonDecode(response.body);

            if (data["Result"].toString().toLowerCase() == "success") {
//------------------------------------------------------------------------------------------------------
              String deencrypted =
                  AESencryption.decryptString(data["Data"], ibUsrKid);

              var res = jsonDecode(deencrypted);

              var getdata = res["map"];

              Loader.hide();

              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Success",
                    description: getdata["Message"].toString(),
                  );
                },
              );
//--------------------------------------------------------------------------------------------
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreateFDRD()));

              // context.push("/CreateFDRD");

//------------------------------------------------------------------------------------------------------
            } else {
              String deencrypted =
                  AESencryption.decryptString(data["Data"], ibUsrKid);
              //------------------------------------------------------------------------------------------------------

              var res = jsonDecode(deencrypted);

              var getdata = res["map"];

              Loader.hide();
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                      title: "Alert",
                      description: getdata["Message"].toString());
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

  // RelationShip select
  void RelationGet(NomineeListName nomineeListName) {
    relationValue = nomineeListName.relmas_ename;
  }

  String removePercentageSign(String percentage) {
    return percentage.replaceAll('%', '');
  }

  Future<void> _checkLatency() async {
    final stopwatch = Stopwatch()..start();

    try {
      var response = await http.get(Uri.parse('https://www.google.com/'));

      if (kDebugMode) {
        print(response.statusCode);
      }

      stopwatch.stop();
      if (response.statusCode == 200) {
        if (stopwatch.elapsedMilliseconds > 5000) {
          await QuickAlert.show(
              context: context,
              type: QuickAlertType.warning,
              headerBackgroundColor: Colors.yellow,
              title: 'Oops...',
              text:
                  "There’s a minor network issue at the moment. Click 'Yes' to keep your connection active, but be aware it might be risky. Select 'No' to log off securely.",
              confirmBtnText: 'Yes',
              cancelBtnText: 'No',
              onConfirmBtnTap: () {
                Navigator.pop(context);

                FinalDataAdd();
              },
              onCancelBtnTap: () {
                Navigator.pop(context);
              },
              showCancelBtn: true,
              confirmBtnColor: Colors.green,
              barrierDismissible: false);
        } else {
          FinalDataAdd();
        }
      } else {
        FinalDataAdd();
      }
    } catch (e) {
      FinalDataAdd();
    }
  }
}
