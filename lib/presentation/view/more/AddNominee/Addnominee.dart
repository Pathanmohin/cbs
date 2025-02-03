// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/view/more/AddNominee/Address.dart';
import 'package:hpscb/presentation/view/more/AddNominee/Guardiencedetail.dart';
import 'package:hpscb/presentation/view/more/moreoptions.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddNominee extends StatefulWidget {
  const AddNominee({super.key});

  @override
  State<StatefulWidget> createState() => _AddNominee();
}

class Relationship {
  String? relmas_ename;

  Relationship({
    required this.relmas_ename,
  });

  factory Relationship.fromJson(Map<String, dynamic> json) {
    return Relationship(
      relmas_ename: json['relmas_ename'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'relmas_ename': relmas_ename,
    };
  }
}

class _AddNominee extends State<AddNominee> {
  @override
  void initState() {
    super.initState();
    GetBiller();
  }

  String? fromAccountlistrronak;
  List<String> NomineeRelationship = [];

  String Message = "";

  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();
  TextEditingController txtnomineename = TextEditingController();

  List<Simple> fromAccount = [
    Simple(
      countryId: '1',
      label: 'Male',
      
    ),
    Simple(
      countryId: '2',
      label: 'Female',

    ),
    // Add more accounts as needed
  ];
  void onToAccount(String value) {}

  void ToAccount(String item) {}
  // void FromAccount(String item) {}

  Future<bool> _onBackPressed() async {
    // Use Future.delayed to simulate async behavior
    await Future.delayed(const Duration(milliseconds: 1));

    // Perform the navigation
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MoreOptions()),
    );
   // context.pop(context);

    // Prevent the default back button behavior
    return false;
  }

  var toSelectedValue;
  var fromSelectedValue;
  var ttoSelectedValue;

  final List<AccountFetchModel> toAccountList = AppListData.Allacc;
  //final List<Rechargmobile> RealtionShip = Realtionship.relationShip;

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
                  "Nominee Detail",
                  style: TextStyle(color: Colors.white,fontSize: 16.sp),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MoreOptions()),
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Dashboard()),
                        );
                        //
                    //context.go('/dashboard');
                      
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
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 10.0),
                          child: Text(
                            "Account Number",
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
                                value: fromSelectedValue,
                                hint: const Text(
                                  'Select Account Number',
                                  style: TextStyle(
                                    color: Color(0xFF898989),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                icon: const Icon(Icons.arrow_drop_down),
                                isExpanded: true,
                                items: toAccountList.map((AccountFetchModel obj) {
                                  return DropdownMenuItem<String>(
                                    value: obj.textValue,
                                    child: Builder(
                                      builder: (context) {
                                        return MediaQuery(
                                            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.1)),
                                          child: Text(
                                            "${obj.textValue}",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      }
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    fromSelectedValue = newValue!;
                                  });
            
                                  onToAccount(newValue!);
                                },
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5.0, left: 10.0),
                          child: Text(
                            "Nominee Name",
                            style: TextStyle(
                                color: Color(0xFF0057C2),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                          child: SizedBox(
                            height: 52,
                            child: TextField(
                              controller: txtnomineename,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                hintText: 'Enter Nominee Name',
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
                              child: DropdownButton<String>(
                                dropdownColor: AppColors.onPrimary,
                                value: fromAccountlistrronak,
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
                                items: NomineeRelationship.map((String Value) {
                                  return DropdownMenuItem<String>(
                                    value: Value,
                                    child: Builder(
                                      builder: (context) {
                                        return MediaQuery(
                                            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.1)),
                                          child: Text(
                                            Value,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      }
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    fromAccountlistrronak = newValue!;
                                  });
                                  ttoSelectedValue(newValue);
            
                                  // ToAccount(newValue!);
                                  // onToAccount(newValue!);
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
                              child: DropdownButton<String>(
                                dropdownColor: AppColors.onPrimary,
                                value: toSelectedValue,
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
                                items: fromAccount.map((Simple obj) {
                                  return DropdownMenuItem<String>(
                                    value: obj.label,
                                    child: Builder(
                                      builder: (context) {
                                        return MediaQuery(
                                            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.1)),
                                          child: Text(
                                            obj.label,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      }
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    toSelectedValue = newValue!;
                                  });
                                        
                                  // if (toSelectedValue == "Mobile Number") {
                                  //   setState(() {
                                  //     showMobileField = true;
                                  //     showMobile = false;
                                  //   });
                                  // } else {
                                  //   setState(() {
                                  //     showMobile = true;
                                  //     showMobileField = false;
                                  //   });
                                  // }
                                  // Call your method here, similar to SelectedIndexChanged
                                  //onFromAccount(newValue);
                                  fromSelectedValue(newValue);
                                  // onToAccount(newValue!);
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
                          padding: const EdgeInsets.all(9),
                          child: TextField(
                            controller: _dateController,
                            decoration: const InputDecoration(
                              hintText: 'Date Of Birth',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: const TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                            readOnly: true,
                            onTap: () async {
                              
            
                              DateTime now = DateTime.now();
                              DateTime lastDate =
                                  DateTime(now.year, now.month + 1, now.day);
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: _selectedDate ?? DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: lastDate,
                              );
                              if (picked != null && picked != _selectedDate) {
                                setState(() {
                                  _selectedDate = picked;
                                  _dateController.text =
                                      DateFormat('dd-MM-yyyy').format(_selectedDate!);
                                });
                              }
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () async {

                            if (fromSelectedValue == null ||
                                  fromSelectedValue == "") {
                                Message = "Please Select Account Number";
                                DialogboxAlert(Message, context);
                                return;
                              }
                              if (txtnomineename.text.toString() == "") {
                                Message = "Please Enter Nominee Name";
                                DialogboxAlert(Message, context);
                                return;
                              }
                              if (fromAccountlistrronak == null ||
                                  fromAccountlistrronak == "") {
                                Message = "Please Select Nominee RelationShip";
                                DialogboxAlert(Message, context);
                                return;
                              }
                              if (toSelectedValue == null || toSelectedValue == "") {
                                Message = "Please Select Gender";
                                DialogboxAlert(Message, context);
                                return;
                              }
                            DateTime currentDate = DateTime.now();
                            int age = currentDate.year - _selectedDate!.year;
                            String agee = age.toString();
            
                            DateTime eighteenYearsAgo =
                                currentDate.subtract(const Duration(days: 18 * 365));
                            final List<ConnectivityResult> connectivityResult =
                                await (Connectivity().checkConnectivity());
                            if (connectivityResult
                                .contains(ConnectivityResult.none)) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Builder(
                                    builder: (context) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.1)),
                                        child: AlertDialog(
                                          backgroundColor: AppColors.onPrimary,
                                          title: const Text(
                                            'Alert',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          content: const Text(
                                            'Please Check Your Internet Connection',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'OK',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  );
                                },
                              );
            
                              return;
                            }
                            if (_selectedDate!.isBefore(eighteenYearsAgo)) {
                              String flag = "N";
                              String dob =
                                  DateFormat('yyyy-MM-dd').format(_selectedDate!);
            
                              final prefs = await SharedPreferences.getInstance();
            
                              prefs.setString("NomineeName", txtnomineename.text);
                              prefs.setString("Accountnumber", fromSelectedValue);
                              prefs.setString("NomineeRelationship",
                                  fromAccountlistrronak.toString());
                              prefs.setString("Nomineegender", toSelectedValue);
            
                              prefs.setString("Age", agee);
                              prefs.setString("flag", flag);
                              prefs.setString("DOB", dob);
            
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Addresspage()),
                              );

                             //context.push('/Addresspage');

                              
                            } else {
                              String flag = "Y";
                              String dob =
                                  DateFormat('yyyy-MM-dd').format(_selectedDate!);
                              final prefs = await SharedPreferences.getInstance();
            
                              prefs.setString("NomineeName", txtnomineename.text);
                              prefs.setString("Accountnumber", fromSelectedValue);
                              prefs.setString("NomineeRelationship",
                                  fromAccountlistrronak.toString());
                              prefs.setString("Nomineegender", toSelectedValue);
            
                              prefs.setString("Age", agee);
                              prefs.setString("flag", flag);
                              prefs.setString("DOB", dob);
            
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Guardiencedetails(
                                        nomineeRelationship: NomineeRelationship)),
                              );
                            }
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Addresspage()));

                           
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
                                  "PROCEED",
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

  void onFromAccount(String item) {
    if (kDebugMode) {
      print('Selected value: $item');
    }
  }

  void Dialgbox(String MESSAGE) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Builder(
          builder: (context) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.1)),
              child: AlertDialog(
                backgroundColor: AppColors.onPrimary,
                title:  const Text(
                  'Alert',
                  style: TextStyle(fontSize: 18),
                ),
                content: Text(
                  MESSAGE,
                  style: const TextStyle(fontSize: 18),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child:  const Text(
                      'OK',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            );
          }
        );
      },
    );
  }

  void DialogboxAlert(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Builder(
          builder: (context) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.1)),
              child: AlertDialog(
                backgroundColor: AppColors.onPrimary,
                title: const Text(
                  'Alert',
                  style: TextStyle(fontSize: 18),
                ),
                content: Text(
                  message,
                  style: const TextStyle(fontSize: 18),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            );
          }
        );
      },
    );
  }

  Future<void> GetBiller() async {
    try {


      // Loader.show(context, progressIndicator: CircularProgressIndicator());

      // API endpoint URL

   //   String apiUrl = "rest/AccountService/getrelationship";


String apiUrl = ApiConfig.getrelationship;

      String jsonString = jsonEncode({});

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

  

      try {
        // Make POST request
        var response = await http.post(
          Uri.parse(apiUrl),
          body: jsonString,
          headers: headers,
          encoding: Encoding.getByName('utf-8'),
        );

        // Check if request was successful
        if (response.statusCode == 200) {
          // Loader.hide();
          Map<String, dynamic> responseData = jsonDecode(response.body);

          var b = responseData["Result"].toString();
          var decryptedResult = responseData["Data"];
          var jsonObject = json.decode(decryptedResult) as List;

          // var jsonObject = json.decode(decryptedResult) as List;
          List<dynamic> data = jsonObject;
          List<Relationship> trends =
              data.map((json) => Relationship.fromJson(json)).toList();
          List<String> updatedStatusItems =
              trends.map((code) => '${code.relmas_ename}').toList();
          setState(() {
            NomineeRelationship = updatedStatusItems;
          });
        } else {
          // Loader.hide();
          Message = "Server Failed....!";
          DialogboxAlert(Message, context);
          return;
        }
      } catch (error) {
        //  Loader.hide();

        Message = "Server Failed....!";
        DialogboxAlert(Message, context);
        return;
      }
    } catch (e) {
      Message = "Unable to Connect to the Server";
      DialogboxAlert(Message, context);
      return;
    }
  }

// API Code............................................................
}
