// ignore_for_file: non_constant_identifier_names, unused_field, prefer_typing_uninitialized_variables, unnecessary_null_comparison, unused_local_variable

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/more/AddNominee/Addnominee.dart';
import 'package:hpscb/presentation/view/more/moreoptions.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Guardiencedetails extends StatefulWidget {
  final List<String> nomineeRelationship;

  const Guardiencedetails({super.key, required this.nomineeRelationship});
  @override
  State<StatefulWidget> createState() => _Guardiencedetails();
}

class CODE {
  int? dist_kid;
  String? dist_ename;
  //String? dist_kid;

  CODE({
    required this.dist_kid,
    required this.dist_ename,
    // this.dist_kid,
  });

  factory CODE.fromJson(Map<String, dynamic> json) {
    return CODE(
      dist_kid: json['dist_kid'],
      dist_ename: json['dist_ename'],
      //  dist_kid: json['dist_kid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dist_kid': dist_kid,
      'dist_ename': dist_ename,
      // 'dist_kid': dist_kid,
    };
  }
}

class city {
  String? stat_ename;
  String? stat_code;
  int? stat_kid;

  //String? dist_kid;

  city({
    required this.stat_ename,
    required this.stat_code,
    required this.stat_kid,
    // this.dist_kid,
  });

  factory city.fromJson(Map<String, dynamic> json) {
    return city(
      stat_ename: json['stat_ename'],
      stat_code: json['stat_code'],
      stat_kid: json['stat_kid'],
      //  dist_kid: json['dist_kid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stat_ename': stat_ename,
      'stat_code': stat_code,
      'stat_kid': stat_kid,
    };
  }
}

class _Guardiencedetails extends State<Guardiencedetails> {
  @override
  void initState() {
    super.initState();
    GetStatename();
    dataFound();
  }

  void citycode(String? newValue) {
    setState(() {
      CityName = newValue;
      String Name = CityName!.split('(').toString();

      String input = CityName.toString();

      // Split the string at '('
      List<String> parts = input.split('(');

      // Remove the closing parenthesis ')' from the second part
      String number = parts[1].replaceAll(')', '');
      NameCity = parts[0];
      txtpincode.text = number.toString();
    });
  }

  Future<void> dataFound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      NomineeName = prefs.getString("NomineeName") ?? '';
      Accountnumber = prefs.getString("Accountnumber") ?? '';
      NomineeRelations = prefs.getString("NomineeRelationship") ?? '';
      Nomineegender = prefs.getString("Nomineegender") ?? '';
      Age = prefs.getString("Age") ?? '';
      flag = prefs.getString("flag") ?? '';
      DOB = prefs.getString("DOB") ?? '';
    });
  }

  String NameCity = "";
  String mStateCodeGet = "";
  String NomineeName = '';
  String Accountnumber = "";
  String NomineeRelations = "";
  String Nomineegender = "";
  String Age = "";
  String flag = "";
  String DOB = "";
  String Alertmessage = "";
  String? NomineeRelationship;
  TextEditingController txtaddress2 = TextEditingController();
  TextEditingController txtaddress1 = TextEditingController();
  TextEditingController txtpincode = TextEditingController();
  TextEditingController txtguardienname = TextEditingController();
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();
  List<String> fromAccountList = [];
  List<city> CityNamenominee = [];
  void onToAccount(String value) {}

  void ToAccount(String item) {}
  void FromAccount(String item) {}
  String? StateName;
  String? CityName;
  String Message = "";
  city? mStateData;

  Future<bool> _onBackPressed() async {
    // Use Future.delayed to simulate async behavior
    await Future.delayed(const Duration(milliseconds: 1));

    // Perform the navigation
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNominee()),
    );

    // ignore: use_build_context_synchronously
    // context.pop(context);

    // Prevent the default back button behavior
    return false;
  }

  var toSelectedValue;
  var fromSelectedValue;
  var ttoSelectedValue;

  final List<AccountFetchModel> toAccountList = AppListData.FromAccounts;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Builder(builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Guardian Details",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddNominee()),
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
                  child: InkWell(
                    onTap: () {
                      //  context.go('/dashboard');

                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MoreOptions()));
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
                padding:
                    const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
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
                        padding: EdgeInsets.only(top: 5.0, left: 10.0),
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
                            controller: txtguardienname,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: 'Enter Guardian Name',
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
                            child: DropdownButton<String>(
                              dropdownColor: AppColors.onPrimary,
                              value: NomineeRelationship,
                              hint: const Text(
                                'Select Guardian RelationShip',
                                style: TextStyle(
                                  color: Color(0xFF898989),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              isExpanded: true,
                              items: widget.nomineeRelationship
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Builder(builder: (context) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          textScaler:
                                              const TextScaler.linear(1.1)),
                                      child: Text(
                                        value,
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
                                  NomineeRelationship = newValue!;
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
                        padding: EdgeInsets.only(top: 5.0, left: 10.0),
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
                            controller: txtaddress1,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: 'Address 1',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 5.0, left: 10.0),
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
                            controller: txtaddress2,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: 'Address 2',
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
                            child: DropdownButton<city>(
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
                              items: CityNamenominee.map((city obj) {
                                return DropdownMenuItem<city>(
                                  value: obj,
                                  child: Builder(builder: (context) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          textScaler:
                                              const TextScaler.linear(1.1)),
                                      child: Text(
                                        obj.stat_ename ?? '',
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

                                // onToAccount(newValue!);
                                mStateCodeGet = mStateData!.stat_kid.toString();

                                // String mStateNameGet = stateObjectList.mStateName.toString();

                                // // ignore: unused_local_variable
                                // String mStateIDGet = stateObjectList.mStateID.toString();
                                GetStateCode(mStateCodeGet);
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
                            child: DropdownButton<String>(
                              dropdownColor: AppColors.onPrimary,
                              value: CityName,
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
                              items: fromAccountList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Builder(builder: (context) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          textScaler:
                                              const TextScaler.linear(1.1)),
                                      child: Text(
                                        value,
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
                              onChanged: citycode,
                              // onChanged: (newValue) {
                              //   setState(() {
                              //     toSelectedValue = newValue!;
                              //   });

                              // ToAccount(newValue);

                              // onToAccount(newValue!);
                              //},
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 5.0, left: 10.0),
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
                            controller: txtpincode,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6)
                            ],
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
                          bool val = await Utils.netWorkCheck(context);

                          if (val == false) {
                            return;
                          }
                          if (txtguardienname.text == null ||
                              txtguardienname.text == "") {
                            Message = "Please Enter Gardience Name";
                            await DialogboxAlert(Message);
                            return;
                          }
                          if (NomineeRelationship == null ||
                              NomineeRelationship == "") {
                            Message = "Please Select RealstionShip";
                            await DialogboxAlert(Message);
                            return;
                          }
                          if (txtaddress1.text == null ||
                              txtaddress1.text == "") {
                            Message = "Please Enter Address 1";
                            await DialogboxAlert(Message);
                            return;
                          }

                          if (txtaddress2.text == null ||
                              txtaddress2.text == "") {
                            Message = "Please Enter Address 2";
                            await DialogboxAlert(Message);
                            return;
                          }
                          if (mStateCodeGet == null || mStateCodeGet == "") {
                            Message = "Please Select State Name";
                            await DialogboxAlert(Message);
                            return;
                          }
                          if (CityName == null || CityName == "") {
                            Message = "Please Select City Name";
                            await DialogboxAlert(Message);
                            return;
                          }
                          if (txtpincode.text == null || txtpincode == "") {
                            Message = "Please Enter PinCode";
                            await DialogboxAlert(Message);
                            return;
                          }

                          OnSubmitButton();
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

  void onFromAccount(String item) {
    if (kDebugMode) {
      print('Selected value: $item');
    }
  }

  Dialgbox(String MESSAGE) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Builder(builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.1)),
            child: AlertDialog(
              backgroundColor: AppColors.onPrimary,
              title: const Text(
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
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

// API Code............................................................

  DialogboxAlert(String message) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Builder(builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.1)),
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
        });
      },
    );
  }

  Future<void> GetStateCode(String Code) async {
    try {
      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      // API endpoint URL

      //String apiUrl = "rest/AccountService/getdistName";

      String apiUrl = ApiConfig.getdistName;

      String jsonString = jsonEncode({"Statecode": Code});

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

      // Convert data to JSON

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
          Loader.hide();
          Map<String, dynamic> responseData = jsonDecode(response.body);

          var b = responseData["Result"].toString();
          var decryptedResult = responseData["Data"];
          var jsonObject = json.decode(decryptedResult) as List;
          List<dynamic> data = jsonObject;
          List<CODE> trends = data.map((json) => CODE.fromJson(json)).toList();
          List<String> updatedStatusItems = trends
              .map((code) => '${code.dist_ename}(${code.dist_kid})')
              .toList();
          setState(() {
            //   fromAccountList = updatedStatusItems;

            if (updatedStatusItems == null) {
              fromAccountList = updatedStatusItems;
            }
            {
              //   fromAccountList.clear();

              CityName = null; // Reset CityName to null when button is pressed

              fromAccountList = updatedStatusItems;
            }
          });
        } else {
          Loader.hide();
          Message = "Server Failed....!";
          await DialogboxAlert(Message);
          return;
        }
      } catch (error) {
        Loader.hide();

        Message = "Server Failed....!";
        await DialogboxAlert(Message);
        return;
      }
    } catch (e) {
      Loader.hide();
      Message = "Unable to Connect to the Server";
      await DialogboxAlert(Message);
      return;
    }
  }

// API Code............................................................

  Future<void> GetStatename() async {
    try {
      // Loader.show(context, progressIndicator: CircularProgressIndicator());

      // API endpoint URL

      // String apiUrl = "$protocol$ip$port/rest/AccountService/getStateName";

      String apiUrl = ApiConfig.getStateName;

      String jsonString = jsonEncode({});

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

      // Convert data to JSON

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

          List<dynamic> data = jsonObject;
          List<city> trends = data.map((json) => city.fromJson(json)).toList();
          // List<city> updatedStatusItems =
          //     trends.map((code) => '${code}').toList();
          setState(() {
            CityNamenominee = trends;
            ;
          });
        } else {
          // Loader.hide();
          Message = "Server Failed....!";
          await DialogboxAlert(Message);
          return;
        }
      } catch (error) {
        //  Loader.hide();

        Message = "Server Failed....!";
        await DialogboxAlert(Message);
        return;
      }
    } catch (e) {
      Message = "Unable to Connect to the Server";
      await DialogboxAlert(Message);
      return;
    }
  }

  Future<void> OnSubmitButton() async {
    // String ip = ServerDetails().getIPaddress();
    // String port = ServerDetails().getPort();
    // String protocol = ServerDetails().getProtocol();
    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    //String apiUrl = "rest/AccountService/newnomDetail";

    String apiUrl = ApiConfig.newnomDetail;

    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

    String accountNo = context.read<SessionProvider>().get('accountNo');
    String sessionId = context.read<SessionProvider>().get('sessionId');
    String branchCode = context.read<SessionProvider>().get('branchCode');
    String customerId = context.read<SessionProvider>().get('customerId');

    String City = CityName.toString();

    int index = City.indexOf('(');
    String name = City.substring(0, index);
    String number = City.substring(index + 1, City.length - 1);
    // List<String> parts = City.split('-');
    // String numericPart = parts[0];
    // String textualPart = parts[1];

    String age;
    if (Nomineegender == "Male") {
      age = "M";
    } else {
      age = "F";
    }

    String jsonString = jsonEncode({
      "accountno": Accountnumber,
      "relation": NomineeRelations,
      "age": Age,
      "gender": age,
      "name": NomineeName,
      "dob": DOB,
      "flag": flag,
      "grdname": txtguardienname.text,
      "grdrela": NomineeRelationship,
      "adrno": "",
      "adreloc": "",
      "adrcity": "",
      "adrpin": "",
      "grdadrno": txtaddress1.text,
      "grdadreloc": txtaddress2.text,
      "grdadrcity": NameCity.toString(),
      "grdadrpin": txtpincode.text,
    });

    String encrypted = AESencryption.encryptString(jsonString, ibUsrKid);

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "tokenNo": tokenNo,
      "userID": userid,
    };

    final parameters = {"data": encrypted};

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      if (response.statusCode == 200) {
        Loader.hide();

        var data = response.body;
        var decryptedData =
            AESencryption.decryptString(data.toString(), ibUsrKid);

        var parsedData = jsonDecode(decryptedData);

        if (parsedData["Result"] == "Success") {
          Message = "Your Nominee Add Successfully";
          Alertmessage = "Success";
          await Successfullydialog(Message, Alertmessage);
          return;
        } else {
          Message = "Formate Mis Match";
          await Dialgbox(Message);
          return;
        }
      } else {
        Loader.hide();
        Message = "Server Failed....!";
        await DialogboxAlert(Message);
        return;
      }
    } catch (e) {
      Loader.hide();
      Message = "Unable to Connect to the Server";
      await DialogboxAlert(Message);
      return;
      //_showAlertDialog("Alert", "Unable to Connect to the Server");
    }
  }

  Successfullydialog(String message, String alertmessage) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.onPrimary,
          title: const Text(
            "Success",
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
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => MoreServices()));

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MoreOptions()));
              },
              child: const Text(
                'OK',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }
}
