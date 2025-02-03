// ignore_for_file: non_constant_identifier_names, unused_local_variable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/presentation/view/BBPS/bbps.dart';

import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuccessfullyCabletv extends StatefulWidget {
  const SuccessfullyCabletv({super.key});

  @override
  State<StatefulWidget> createState() => _SuccessfullyCabletv();
}

class _SuccessfullyCabletv extends State<SuccessfullyCabletv> {
  Future<bool> _onBackPressed() async {
    // Use Future.delayed to simulate async behavior
    await Future.delayed(const Duration(milliseconds: 1));

    // Perform the navigation
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => Recharge()),
    // );

    // Prevent the default back button behavior
    return false;
  }

  String BillAmount = '';
  String DueDate = "";
  String CustomeName = "";
  String BillDate = "";
  String Remarks = "";
  String BillNumnber = "";
  String RequestID = "";
  String BillPeriod = "";
  String Resptype = "";
  String RefnumberApprovel = "";
  String resopneResponse = "";

  @override
  void initState() {
    super.initState();
    dataFound();
    // updateNumberInWords();
  }

  Future<void> dataFound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      AmountBill = prefs.getString("BillAmount") ?? '';
      NameCustomer = prefs.getString("CustomeName") ?? '';

      Reasonresponece = prefs.getString("responseReason") ?? '';
      Billername = prefs.getString("Billername") ?? '';
      ApprovelRefrenec = prefs.getString("approvalRefNumber") ?? '';
    });
  }

  String AmountBill = "";
  String Billername = "";
  String Reasonresponece = "";
  String ApprovelRefrenec = "";
  String NameCustomer = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    //  const IconData check = IconData(0xe156, fontFamily: 'MaterialIcons');

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Summary",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFF0057C2),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Image.asset(
                    CustomImages.assured,
                                      height: 52,
                  width: 52,
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
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 42,
                    ),
                    const Center(
                      child: Text(
                        "Successfully Transaction",
                        style: TextStyle(fontSize: 20, color: Colors.green),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 25.0, right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            child: Text(
                              "Biller Name:",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF0057C2)),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              Billername,
                              style: const TextStyle(
                                  fontSize: 16, color: Color(0xFF0057C2)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                          child: SizedBox(
                        width: size.width * 0.9,
                        height: 2,
                        child: Center(
                            child: Container(
                          color: Colors.black26,
                        )),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            child: Text(
                              "Customer Name:",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF0057C2)),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              NameCustomer,
                              style: const TextStyle(
                                  fontSize: 16, color: Color(0xFF0057C2)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                          child: SizedBox(
                        width: size.width * 0.9,
                        height: 2,
                        child: Center(
                            child: Container(
                          color: Colors.black26,
                        )),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            child: Text("Amount:",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF0057C2))),
                          ),
                          Flexible(
                            child: Text(
                              "\u{20B9} $AmountBill",
                              style: const TextStyle(
                                  fontSize: 16, color: Color(0xFF0057C2)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                          child: SizedBox(
                        width: size.width * 0.9,
                        height: 2,
                        child: Center(
                            child: Container(
                          color: Colors.black26,
                        )),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            child: Text("Status:",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF0057C2))),
                          ),
                          Flexible(
                            child: Text(
                              Reasonresponece,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.green),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                          child: SizedBox(
                        width: size.width * 0.9,
                        height: 2,
                        child: Center(
                            child: Container(
                          color: Colors.black26,
                        )),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            child: Text("Reference ID:",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF0057C2))),
                          ),
                          Flexible(
                            child: Text(
                              ApprovelRefrenec,
                              style: const TextStyle(
                                  fontSize: 16, color: Color(0xFF0057C2)),
                            ),
                          )
                        ],
                      ),
                    ),
    
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                          child: SizedBox(
                        width: size.width * 0.9,
                        height: 2,
                        child: Center(
                            child: Container(
                          color: Colors.black26,
                        )),
                      )),
                    ),
    
    
    
    Image.asset(CustomImages.downlogo,
    height: 100,
    width: 100,
    ),
    
                    InkWell(
                      onTap: () async {
                        // Your onTap functionality here
    
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BBPSConnect()));
    
                        //    context.go("/dashboard");
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0,
                            left: 10.0,
                            right: 10.0,
                            bottom: 10.0),
                        child: Container(
                          height: 50.sp,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0057C2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Add some spacing between the icon and the text
    
                                Text(
                                  "Home",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // const SizedBox(width: 8),
                                // Image.asset("assets/images/next.png"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))),
      );
    });
  }
}
