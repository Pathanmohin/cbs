// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/presentation/view/appdrawer/profileview/profileview.dart';

import 'package:hpscb/utility/theme/colors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import the share_plus package

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  String customerName = "";
  String accountNumber = "";
  String accountType = "";
  String branchName = "";
  String ifscCode = "";
  String address = "";
  String address1 = "";
  String city = "";
  String mobileNumber = "";
  String emailId = "";
  String panNumber = "";

  Map<String, bool> details = {
    'Account number': false,
    'Branch Name': false,
    'Account Type': false,
    'Account holder\'s name': false,
    'Communication address': false,
    'IFSC Code': false,
    'Mobile Number': false,
    'Email ID': false,
    'Pan Number': false,
  };

  Map<String, String> values = {
    'Account number': '',
    'Branch Name': '',
    'Account Type': '',
    'Account holder\'s name': '',
    'Communication address': '',
    'IFSC Code': '',
    'Mobile Number': '',
    'Email ID': '',
    'Pan Number': '',
  };

  @override
  void initState() {
    super.initState();
    dataFound();
  }

  Future<void> dataFound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      customerName = prefs.getString("CustomerName") ?? '';
      accountNumber = prefs.getString("Accountnumber") ?? '';
      accountType = prefs.getString("ACTNAME") ?? '';
      branchName = prefs.getString("BranchName") ?? '';
      ifscCode = prefs.getString("IFSCCODE") ?? '';
      address = prefs.getString("Addresss") ?? '';
      address1 = prefs.getString("Address1") ?? '';
      city = prefs.getString("City") ?? '';
      mobileNumber = prefs.getString("MobileNumber") ?? '';
      emailId = prefs.getString("EmailId") ?? '';
      panNumber = prefs.getString("Pannumber") ?? '';

      values['Account number'] = accountNumber;
      values['Branch Name'] = branchName;
      values['Account Type'] = accountType;
      values['Account holder\'s name'] = customerName;
      values['Communication address'] = '$address, $address1, $city';
      values['IFSC Code'] = ifscCode;
      values['Mobile Number'] = mobileNumber;
      values['Email ID'] = emailId;
      values['Pan Number'] = panNumber;
    });
  }

  void shareSelectedDetails() {
    List<String> selectedItems = [];
    details.forEach((key, value) {
      if (value) {
        selectedItems.add('$key: ${values[key]}');
      }
    });

    String selectedDetails = selectedItems.join('\n');

    if (selectedDetails.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select details to share.')),
      );
    } else {
      Share.share(selectedDetails);
    }
  }

  Future<bool> _onWillPop() async {
     Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfileView()));

    //context.pop(context);

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Builder(
        builder: (context) {
          return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.1)),
            child: Scaffold(
              backgroundColor: AppColors.onPrimary,
              appBar: AppBar(

                
                leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileView()),
                    );
            
                    //context.pop(context);
            
            
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
                title: Text(
                  'My Account Details',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                backgroundColor: AppColors.appBlueC,
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select the details that you wish to share',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ListView(
                        children: details.keys.map((String key) {
                          return CheckboxListTile(
                            title: Text(
                              key,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
            
                            activeColor:
                                const Color(0xFF0057C2), // Changes the active color
                            checkColor: Colors.white,
                            subtitle: Text(values[key] ?? ''),
                            value: details[key],
                            onChanged: (bool? value) {
                              setState(() {
                                details[key] = value ?? false;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: shareSelectedDetails,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF0057C2),
                        ),
                        child: const Text(
                          'Share Details',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
