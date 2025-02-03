// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/presentation/view/applydashboard/currentaccount/CAOccupation/CAOccupation.dart';
import 'package:hpscb/presentation/view/applydashboard/savingaccount/saveverifydata.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package

class CAAadhaarCard extends StatefulWidget {
  const CAAadhaarCard({super.key});

  @override
  State<StatefulWidget> createState() => _CAAadhaarCardState();
}

class _CAAadhaarCardState extends State<CAAadhaarCard> {
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

      String address = AadhaarcardVerifyuser.house +
          AadhaarcardVerifyuser.landmark +
          "${AadhaarcardVerifyuser.street.isNotEmpty ? AadhaarcardVerifyuser.street + ', ' : ''}"
              "${AadhaarcardVerifyuser.loc}, ${AadhaarcardVerifyuser.po}, "
              "${AadhaarcardVerifyuser.vtc}, ${AadhaarcardVerifyuser.dist}, "
              "${AadhaarcardVerifyuser.state}, ${AadhaarcardVerifyuser.country}";

      addressCon.text = address;

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
            title: Text(
              "Aadhaar Details",
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
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
        ...List.generate(5, (index) => _buildShimmerTextField()),
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

          //  getBranchDetails();

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CAOccupations()));
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF0057C2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              "Continue",
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
}
