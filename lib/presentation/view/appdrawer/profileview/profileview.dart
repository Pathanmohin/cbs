// ignore_for_file: non_constant_identifier_names, unused_local_variable, deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/presentation/view/appdrawer/profileview/profileView_share.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  @override
  State<StatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String Message = "";

  String CustomerName = "";
  String Accountnumber = "";

  String ACTNAME = "";

  String BranchName = "";

  String shareContent = "";
  String shareContent2 = "";
  String IFSCCODE = "";

  String Addresss = "";

  String Address1 = "";

  String City = "";

  String MobileNumber = "";

  String EmailId = "";
  String Pannumber = "";
  String FullAddress = "";
  String Name = "";
  double _getFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 600) {
      return 30.0; // Large screen
    } else if (screenWidth > 400) {
      return 20.0; // Medium screen
    } else {
      return 15.0; // Default size
    }
  }

  @override
  void initState() {
    super.initState();
    //GetProfileDeatils();
    dataFound();
  }

  Future<void> dataFound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Name = prefs.getString("CustomerName") ?? '';
      CustomerName = Name.trim();
      Accountnumber = prefs.getString("Accountnumber") ?? '';
      ACTNAME = prefs.getString("ACTNAME") ?? '';
      BranchName = prefs.getString("BranchName") ?? '';
      IFSCCODE = prefs.getString("IFSCCODE") ?? '';
      Addresss = prefs.getString("Addresss") ?? '';
      City = prefs.getString("City") ?? '';
      MobileNumber = prefs.getString("MobileNumber") ?? '';
      EmailId = prefs.getString("EmailId") ?? '';
      Pannumber = prefs.getString("Pannumber") ?? '';
      Address1 = prefs.getString("Address1") ?? '';

      // Addresss, Address1, City
      FullAddress = "$Addresss,$Address1,$City";
    });
  }

  Future<bool> _onWillPop() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Dashboard()));
//context.go('/dashboard');

    return false;
  }

  @override
  Widget build(BuildContext context) {
    String Message = "";

    String userid = context.read<SessionProvider>().get('userid');

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Builder(builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.1)),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Personal View",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Dashboard()),
                  );

                  //context.go('/dashboard');
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Dashboard()),
                      );
                    },
                    child: Image.asset(
                      "assets/images/dashlogo.png",
                      width: 24.sp,
                      height: 24.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10), // Adjust the spacing as needed
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            CustomerName, // Provide the account holder name dynamically
                            style: const TextStyle(
                              fontFamily: 'Montserrat-SemiBold',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'User ID - ',
                              style: TextStyle(
                                fontFamily: 'Montserrat-SemiBold',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              userid, // Provide the user ID dynamically
                              style: const TextStyle(
                                fontFamily: 'Montserrat-SemiBold',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  buildFrameWithTitle('assets/images/numberacc.png',
                      'Account Number', Accountnumber),
                  buildFrameWithTitle(
                      'assets/images/numberacc.png', 'Branch Name', BranchName),
                  buildFrameWithTitle(
                      'assets/images/pannumber.png', 'Account Type', ACTNAME),
                  buildFrameWithTitle('assets/images/username.png',
                      'Account Holder Name', CustomerName),
                  buildFrameWithTitle(
                      'assets/images/ifscnumber.png', 'IFSC', IFSCCODE),
                  buildFrameWithTitle(
                      'assets/images/location.png', 'Address', FullAddress),
                  buildFrameWithTitle('assets/images/telephone.png',
                      'Mobile Number', MobileNumber),
                  buildFrameWithTitle(
                      'assets/images/mail.png', 'Email ID', EmailId),
                  buildFrameWithTitle(
                      'assets/images/pannumber.png', 'Pan Number', Pannumber),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, top: 30, right: 10, bottom: 20.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AccountDetailsScreen()));

                        //context.push("/AccountDetailsScreen");
                      },

                      // Add your Google login functionality here

                      icon: const Icon(Icons.share),
                      label: const Text(
                        'View/Share My Account Details',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: const Color(0xFF0057C2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void share() async {
    // String shareContent ='Invoicing has never been THIS easy. Absolutely hassle-free with E-Maps. Check it out!\nhttps://drive.google.com/file/d/1WLNUpgXkaPMT7WlbCYRhFEs7DKMqfSPU/view?usp=drivesdk';
    // String shareContent = '$CustomerName\n$Accountnumber\n$BranchName\n$IFSCCODE\n$Addresss';

    String shareContent = ''' Please find my account details below  

Account Number: $Accountnumber

Branch Name: $BranchName

Account Type: $ACTNAME

Account Holder's Name: $CustomerName

Communication Address: $Addresss

IFSC Code: $IFSCCODE

Mobile Number: $MobileNumber

Pan Number: $Pannumber

Email ID: $EmailId
''';

    await Share.share(
      shareContent,
      // shareContent.toString(),

      subject: 'Share App',
    );
  }

  Widget buildFrameWithTitle(String iconPath, String title, String value) {
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.1)),
        child: Container(
          margin: const EdgeInsets.all(5),
          color: Colors.white,
          child: Row(
            children: [
              Image.asset(
                iconPath,
                width: 40,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Montserrat SemiBold',
                        fontSize: _getFontSize(context),
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      value,
                      style: const TextStyle(
                        fontFamily: 'Montserrat SemiBold',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      maxLines: 3, // Sets the maximum number of lines
                      overflow: TextOverflow
                          .ellipsis, // Adds ellipsis if text exceeds the second line
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],

            // crossAxisAlignment: CrossAxisAlignment.start,
            // children: [
            //   Padding(
            //     padding: const EdgeInsets.all(10.0),
            //     child: Row(
            //       children: [
            //         Image.asset(iconPath, width: 50),
            //         SizedBox(width: 20),
            //         Text(
            //           title,
            //           style: TextStyle(
            //             fontFamily: 'Montserrat-SemiBold',
            //             fontSize: 12,
            //             color: Colors.black,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            //   Text(
            //     value, // Provide dynamic value
            //     style: TextStyle(
            //       fontFamily: 'Montserrat-SemiBold',
            //       fontSize: 12,
            //       color: Colors.black,
            //     ),
            //   ),
            // ],
          ),
        ),
      );
    });
  }

  // ignore: unused_element
  Widget _buildInfoFrame(String iconPath, String label, String info) {
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.1)),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Image.asset(
                  iconPath,
                  width: 50,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontFamily: 'Montserrat SemiBold',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        info,
                        style: const TextStyle(
                          fontFamily: 'Montserrat SemiBold',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // ignore: unused_element
  Widget _buildAddressFrame(
      String iconPath, String label, List<String> addressParts) {
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.1)),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Image.asset(
                  iconPath,
                  width: 50,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontFamily: 'Montserrat SemiBold',
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            addressParts[0],
                            style: const TextStyle(
                              fontFamily: 'Montserrat Regular',
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Flexible(
                          child: Text(
                            ', ',
                            style: TextStyle(
                              fontFamily: 'Montserrat Regular',
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            addressParts[1],
                            style: const TextStyle(
                              fontFamily: 'Montserrat Regular',
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Flexible(
                          child: Text(
                            ', ',
                            style: TextStyle(
                              fontFamily: 'Montserrat Regular',
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            addressParts[2],
                            style: const TextStyle(
                              fontFamily: 'Montserrat Regular',
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> GetProfileDeatils() async {
    // String ip = ServerDetails().getIPaddress();
    // String port = ServerDetails().getPort();
    // String protocol = ServerDetails().getProtocol();

// Password Ency.
    // String md5Hash = Crypt().generateMd5(password);
    // Loader.show(context, progressIndicator: CircularProgressIndicator());

    // API endpoint URL

    //String userid = context.read<SessionProvider>().get('userid');
    //String tokenNo = context.read<SessionProvider>().get('tokenNo');
    // String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

    String accountNo = context.read<SessionProvider>().get('accountNo');
    //String sessionId = context.read<SessionProvider>().get('sessionId');

    // String apiUrl = "$protocol$ip$port/rest/AccountService/ViewProfileMB";

    String apiUrl = ApiConfig.profileView;

    String jsonString = jsonEncode({
      "Accno": accountNo,
    });

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
        List<dynamic> jsonResponse = jsonDecode(response.body);

        Map<String, dynamic> billData = jsonResponse[0];

        CustomerName = billData["cust_ename"];
        Accountnumber = billData["acc_no"];

        ACTNAME = billData["act_ename"];

        BranchName = billData["brn_ename"];

        IFSCCODE = billData["brn_ifsc"];

        Addresss = billData["adr_ehno"];

        Address1 = billData["adr_ehdtl"];

        City = billData["adr_ecity"];

        MobileNumber = billData["adr_mobile"];

        EmailId = billData["adr_emailid"];
        Pannumber = billData["iac_panno"];
      } else {
        // Loader.hide();
        Message = response.statusCode.toString();
        Dialgbox(Message);
        return;
      }
    } catch (error) {
      // Loader.hide();
      Message = error.toString();
      Dialgbox(Message);
      return;
    }
  }

  void Dialgbox(String MESSAGE) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
        );
      },
    );
  }
}
