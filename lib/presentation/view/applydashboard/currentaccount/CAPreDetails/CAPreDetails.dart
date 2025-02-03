// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:hpscb/presentation/view/applydashboard/currentaccount/CAUnauthorized/CAUnauthorized.dart';
import 'package:hpscb/presentation/view/applydashboard/savingaccount/savaccmodel.dart';
import 'package:hpscb/presentation/view/applydashboard/savingaccount/saveverifydata.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart'; // Import the shimmer package
import 'package:intl/intl.dart';

class CAPreView extends StatefulWidget {
  const CAPreView({super.key});

  @override
  State<StatefulWidget> createState() => _CAPreViewState();
}

class _CAPreViewState extends State<CAPreView> {
  String base64Image = "";
  String name = "";
  String aadhaar_number = "";
  String dob = "";
  String gender = "";
  String address = "";
  bool isLoading = true; // Loading state

  final TextEditingController nameCon = TextEditingController();
  final TextEditingController aNumberCon = TextEditingController();
  final TextEditingController dobCon = TextEditingController();
  final TextEditingController genderCon = TextEditingController();
  final TextEditingController addressCon = TextEditingController();

  // professional

  String occupation = "";
  String gorss = "";
  String motherName = "";

  // professional

  final TextEditingController occupationCon = TextEditingController();
  final TextEditingController grossInCon = TextEditingController();
  final TextEditingController motherCon = TextEditingController();

// Branch Details

  String state = "";
  String city = "";
  String branch = "";

  // Branch

  final TextEditingController stateCon = TextEditingController();
  final TextEditingController cityCon = TextEditingController();
  final TextEditingController branchCon = TextEditingController();

  // Nominee Details

  String nomineeShow = "";
  String nomineeName = "";
  String nomineeRel = "";
  String nomineeGender = "";
  String nomineeDOB = "";

  bool showNO = false;

  // Nominee Controller

  final TextEditingController nomNameCon = TextEditingController();
  final TextEditingController nomRelCon = TextEditingController();
  final TextEditingController nomGenderCon = TextEditingController();
  final TextEditingController nomDOBCon = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Simulating a data fetch delay
    Future.delayed(const Duration(seconds: 1), () {
      base64Image = AadhaarcardVerifyuser.profile_image;
      nameCon.text = AadhaarcardVerifyuser.full_name;
      aNumberCon.text = AadhaarcardVerifyuser.aadhaar_number;
      dobCon.text = AadhaarcardVerifyuser.dob;
      genderCon.text = AadhaarcardVerifyuser.gender;

      String address =
          "${AadhaarcardVerifyuser.house}${AadhaarcardVerifyuser.landmark}${AadhaarcardVerifyuser.street.isNotEmpty ? '${AadhaarcardVerifyuser.street}, ' : ''}${AadhaarcardVerifyuser.loc}, ${AadhaarcardVerifyuser.po}, ${AadhaarcardVerifyuser.vtc}, ${AadhaarcardVerifyuser.dist}, ${AadhaarcardVerifyuser.state}, ${AadhaarcardVerifyuser.country}";

      addressCon.text = address;

// Occupation Details
      occupationCon.text = ProfessionalData.occupation;
      grossInCon.text = ProfessionalData.grossIncome;
      motherCon.text = ProfessionalData.mothername;

// Branch details

      stateCon.text = BranchDetails.stateBranch;
      cityCon.text = BranchDetails.cityBranch;
      branchCon.text = BranchDetails.branchName;

// Nominee Details

      nomNameCon.text = NomeenieData.nomiName;
      nomRelCon.text = NomeenieData.nomiRelation;
      nomGenderCon.text = NomeenieData.nomiGender;
      nomDOBCon.text = NomeenieData.nomiDob;

      nomineeShow = NomeenieData.nomniShow;

      if (nomineeShow == "yes") {
        showNO = true;
      } else {
        showNO = false;
      }

      setState(() {
        isLoading = false; // Set loading to false after data is fetched
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Uint8List bytes =
        base64Image.isNotEmpty ? base64Decode(base64Image) : Uint8List(0);
    Size size = MediaQuery.of(context).size;

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              "All Personal Details",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color(0xFF0057C2),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: isLoading // Check if data is loading
                    ? _buildShimmer() // Show shimmer effect
                    : _buildContent(bytes), // Show the content
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: const CircleAvatar(
              radius: 75, // Adjust as needed
              backgroundColor: Colors.white,
            ),
          ),
        ),
        ...List.generate(9, (index) => _buildShimmerTextField()),
      ],
    );
  }

  Widget _buildShimmerTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(Uint8List bytes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: ClipOval(
            child: Image.memory(
              bytes,
              height: 150.0,
              width: 150.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
        ..._buildDetailsFields(), // Reusable method to build text fields
        const SizedBox(
          height: 14.0,
        ),
        _buildSelectBranchButton(),
      ],
    );
  }

  List<Widget> _buildDetailsFields() {
    return [
      _buildTextField(nameCon, "Name", Icons.person),
      _buildTextField(aNumberCon, "Aadhaar Number", Icons.edit_document),
      _buildTextField(dobCon, "Date of Birth", Icons.cake),
      _buildTextField(genderCon, "Gender", Icons.male_outlined),
      _buildTextField(addressCon, "Address", null, maxLines: 3),
      const SizedBox(
        height: 10,
      ),
      const Text(
        "Professional & Personal Details",
        style: TextStyle(
            fontSize: 16,
            color: Color(0xFF0057C2),
            fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 5,
      ),
      _buildTextField(occupationCon, "Occupation", Icons.work),
      _buildTextField(grossInCon, "Gross Annual Income", Icons.wallet),
      _buildTextField(motherCon, "Mother's Full Name", Icons.person),
      const SizedBox(
        height: 10,
      ),
      const Text(
        "Branch Details",
        style: TextStyle(
            fontSize: 16,
            color: Color(0xFF0057C2),
            fontWeight: FontWeight.bold),
      ),
      _buildTextField(stateCon, "State", Icons.fmd_good_sharp),
      _buildTextField(cityCon, "District", Icons.location_city),
      _buildTextField(branchCon, "Branch", Icons.account_balance),
      Visibility(
        visible: showNO,
        child: const SizedBox(
          height: 10,
        ),
      ),
      Visibility(
          visible: showNO,
          child: const Text(
            "Nominee Details",
            style: TextStyle(
                fontSize: 16,
                color: Color(0xFF0057C2),
                fontWeight: FontWeight.bold),
          )),
      Visibility(
          visible: showNO,
          child: _buildTextField(
              nomNameCon, "Nominee Name", Icons.assignment_ind_outlined)),
      Visibility(
          visible: showNO,
          child: _buildTextField(
              nomRelCon, "Nominee RelationShip", Icons.bookmarks_sharp)),
      Visibility(
          visible: showNO,
          child: _buildTextField(
              nomGenderCon, "Gender", Icons.contact_page_sharp)),
      Visibility(
          visible: showNO,
          child: _buildTextField(nomDOBCon, "DOB", Icons.cake_sharp)),
    ];
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, IconData? icon,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefixIcon: icon != null ? Icon(icon) : null,
          labelText: labelText,
        ),
        keyboardType: TextInputType.text,
        readOnly: true,
      ),
    );
  }

  Widget _buildSelectBranchButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: InkWell(
        onTap: () async {
                            bool val = await Utils.netWorkCheck(context);

                          if (val == false) {
                            return;
                          }

          getApiAadhaar();

          //  getBranchDetails();

          //Navigator.push(context, MaterialPageRoute(builder: (context) => const Occupations()));
        },
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            color: const Color(0xFF0057C2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              "Proceed to open account",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }


  Future<void> getApiAadhaar() async {
    // String mobile = formatPhoneNumber(AccOpenStart.phone);

    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
      // String? deviceId = await PlatformDeviceId.getDeviceId;

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      String apiUrl =
          "rest/AccountService/unauthAccountgenebyMobile";

      // String jsonString = jsonEncode({
      //   "userselect": "aadhar",
      //   "actType": "S",
      //   "mobileno": mobile,
      //   "district": selectDist,
      //   "branch": selectBranch,
      //   "state": selectedState,
      //   "CCDetails": {},
      //   "full_name": AadhaarcardVerifyuser.full_name,
      //   "aadhaar_number": AadhaarcardVerifyuser.aadhaar_number,
      //   "dob": AadhaarcardVerifyuser.dob,
      //   "gender": AadhaarcardVerifyuser.gender,
      //   "care_of": AadhaarcardVerifyuser.care_of,
      //   "zip": AadhaarcardVerifyuser.zip,
      //   "address": {
      //     "country": AadhaarcardVerifyuser.country,
      //     "dist": AadhaarcardVerifyuser.dist,
      //     "state": AadhaarcardVerifyuser.state,
      //     "po": AadhaarcardVerifyuser.po,
      //     "loc": AadhaarcardVerifyuser.loc,
      //     "vtc": AadhaarcardVerifyuser.vtc,
      //     "subdist": AadhaarcardVerifyuser.subdist,
      //     "house": AadhaarcardVerifyuser.house,
      //     "landmark": AadhaarcardVerifyuser.landmark
      //   },
      //   "profile_image": AadhaarcardVerifyuser.profile_image
      // });

      String date = AadhaarcardVerifyuser.dob;
      DateTime dateTime = DateTime.parse(date);
      // Format the DateTime object to dd-MM-yyyy format
      String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

      // User INFO Details

      var UserDetail = UserInfo(
        mobileno: AccOpenStart.phoneNumber,
        Email: AccOpenStart.email,
        pan: AccOpenStart.pan,
        aadhaar_number: AccOpenStart.aadhaar,
      );

      // Aadhaar Details

      var AadhaarDetails = AadhaarDetail(
        full_name: AadhaarcardVerifyuser.full_name,
        dob: formattedDate,
        gender: AadhaarcardVerifyuser.gender,
        care_of: AadhaarcardVerifyuser.care_of,
        zip: AadhaarcardVerifyuser.zip,
      );

// Address Details

      var AddressDetail = AddressDetails(
          country: AadhaarcardVerifyuser.country,
          dist: AadhaarcardVerifyuser.dist,
          state: AadhaarcardVerifyuser.state,
          po: AadhaarcardVerifyuser.po,
          loc: AadhaarcardVerifyuser.loc,
          vtc: AadhaarcardVerifyuser.vtc,
          subdist: AadhaarcardVerifyuser.subdist,
          house: AadhaarcardVerifyuser.house,
          landmark: AadhaarcardVerifyuser.landmark);

// Occupation

      var Occupation = OccupationInfo(
          occupation: ProfessionalData.occupation,
          MotherName: ProfessionalData.mothername,
          incom: ProfessionalData.grossIncome,
          ocpbehave: ProfessionalData.ocpBehav.trim()
      );

// Branch Details

      var BarnchDetails = BranchInfo(
        district: BranchDetails.selectDist,
        branch: BranchDetails.branchcode,
        state: BranchDetails.stateBranch,
        pincode: BranchDetails.cityPINCode,
      );

      var NominDetails = NomiInfo(
        NominiFlag: NomeenieData.nomniShow,
        NominiName: NomeenieData.nomiName,
        NominiRelation: NomeenieData.nomiRelation,
        Nominigender: NomeenieData.nomiGender,
        NominiDob: NomeenieData.nomiDob,
      );

      var jsonString = AllDetails(
          actType: "S",
          userselect: "aadhar",
          CCDetails: {},
          profile_image: AadhaarcardVerifyuser.profile_image,
          userinfo: UserDetail.toJson(),
          AadharDetails: AadhaarDetails.toJson(),
          address: AddressDetail.toJson(),
          Occup: Occupation.toJson(),
          Branch: BarnchDetails.toJson(),
          Nomini: NominDetails.toJson());

      String jsonStringSend = jsonEncode(jsonString.toJson());

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonStringSend,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      if (kDebugMode) {
        print(jsonStringSend);
      }

      try {
        if (response.statusCode == 200) {
          var res = json.decode(response.body);

          if (res["Result"].toString().toLowerCase() == "success") {
            var data = json.decode(res["Data"]);

            FinelDataRes.customerid = data["Customerid"];
            FinelDataRes.accountNo = data["AccouuntNo"];

            Loader.hide();

            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertBox(
                  title: "Success",
                  description: "Unauthorised id created successfully",
                );
              },
            );

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CAFinalRes()));
                
          } else if (res["Result"].toString().toLowerCase() == "fail") {
            Loader.hide();
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertBox(
                  title: "Alert",
                  description: "Internal Error",
                );
              },
            );

            return;
          } else {
            Loader.hide();
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertBox(
                  title: "Alert",
                  description: "Internal Error",
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
                description: "Unable to Connect to the Server",
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
              description: "Unable to Connect to the Server",
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
            description: "Unable to Connect to the Server",
          );
        },
      );

      return;
    }
  }
}
