// ignore_for_file: camel_case_types, non_constant_identifier_names, deprecated_member_use, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/presentation/view/BBPS/bbps.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/MobileRecharge/mobilerecharge.dart';

import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Successfully extends StatefulWidget {
  const Successfully({super.key});

  @override
  State<StatefulWidget> createState() => _mobileSuccessfully();
}

class _mobileSuccessfully extends State<Successfully> {

  Future<bool> _onBackPressed() async {
    // Use Future.delayed to simulate async behavior
    await Future.delayed(const Duration(milliseconds: 1));

    // Perform the navigation
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Recharge()),
    );

    // context.go("/mobilerecharge");

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
  String txnRespTypeee = "";
  String ResponseReasonn = "";
  String BillPeroid = "";

  String Custconvenfees = "";

  String txtrefID = "";

  String ResponceCode = "";
  String ResponceBillNumber = "";
  String approvalRefNumber = "";

  @override
  void initState() {
    super.initState();
     dataFound();
    // updateNumberInWords();
  }

  Future<void> dataFound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      BillAmount = prefs.getString("BillAmount") ?? '';
      CustomeName = prefs.getString("CustomeName") ?? '';
      DueDate = prefs.getString("DueDate") ?? '';
      BillDate = prefs.getString("BillDate") ?? '';
      BillNumnber = prefs.getString("BillNumnber") ?? '';
      RequestID = prefs.getString("RequestID") ?? '';
      BillPeriod = prefs.getString("BillPeriod") ?? '';
      txnRespTypeee = prefs.getString("txnRespTypee") ?? '';
      ResponseReasonn = prefs.getString("responseReasonn") ?? '';
      BillPeroid = prefs.getString("RespBillPeriodd") ?? '';
      Custconvenfees = prefs.getString("CustConvFeee") ?? '';
      txtrefID = prefs.getString("txnRefIdd") ?? '';
      ResponceCode = prefs.getString("responseCode") ?? '';
      ResponceBillNumber = prefs.getString("RespBillNumberr") ?? '';
      approvalRefNumber = prefs.getString("approvalRefNumber") ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
              backgroundColor: const Color(0xFF0057C2),
              automaticallyImplyLeading: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(CustomImages.assured,
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
                              "Customer Name:",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF0057C2)),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              //CustomeName
                              CustomeName,
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
                            child: Text(
                              "Bill Number:",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF0057C2)),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              BillNumnber,
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
                            child: Text(
                              "Bill Date:",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF0057C2)),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              BillDate,
                              style: const TextStyle(
                                  fontSize: 16, color: Color(0xFF0057C2)),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10.0),
                    //   child: Center(
                    //       child: SizedBox(
                    //     width: size.width * 0.9,
                    //     height: 2,
                    //     child: Center(
                    //         child: Container(
                    //       color: Colors.black26,
                    //     )),
                    //   )),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       top: 8.0, right: 20, left: 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       const Flexible(
                    //         child: Text("Due Date:",
                    //             style: TextStyle(
                    //                 fontSize: 16,
                    //                 color: Color(0xFF0057C2))),
                    //       ),
                    //       Flexible(
                    //         child: Text(
                    //           DueDate,
                    //           style: const TextStyle(
                    //               fontSize: 16, color: Color(0xFF0057C2)),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
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
                              BillAmount,
                              style: const TextStyle(
                                  fontSize: 16, color: Color(0xFF0057C2)),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10.0),
                    //   child: Center(
                    //       child: SizedBox(
                    //     width: size.width * 0.9,
                    //     height: 2,
                    //     child: Center(
                    //         child: Container(
                    //       color: Colors.black26,
                    //     )),
                    //   )),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       top: 8.0, right: 20, left: 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       const Flexible(
                    //         child: Text("Transcation Type:",
                    //             style: TextStyle(
                    //                 fontSize: 16,
                    //                 color: Color(0xFF0057C2))),
                    //       ),
                    //       Flexible(
                    //         child: Text(
                    //           txnRespTypeee,
                    //           style: const TextStyle(
                    //               fontSize: 16, color: Color(0xFF0057C2)),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
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
                              ResponseReasonn,
                              style: const TextStyle(
                                  fontSize: 16, color: Color(0xFF0057C2)),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10.0),
                    //   child: Center(
                    //       child: SizedBox(
                    //     width: size.width * 0.9,
                    //     height: 2,
                    //     child: Center(
                    //         child: Container(
                    //       color: Colors.black26,
                    //     )),
                    //   )),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       top: 8.0, right: 20, left: 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       const Flexible(
                    //         child: Text("Request ID:",
                    //             style: TextStyle(
                    //                 fontSize: 16,
                    //                 color: Color(0xFF0057C2))),
                    //       ),
                    //       Flexible(
                    //         child: Text(
                    //           RequestID,
                    //           style: const TextStyle(
                    //               fontSize: 16, color: Color(0xFF0057C2)),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10.0),
                    //   child: Center(
                    //       child: SizedBox(
                    //     width: size.width * 0.9,
                    //     height: 2,
                    //     child: Center(
                    //         child: Container(
                    //       color: Colors.black26,
                    //     )),
                    //   )),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       top: 8.0, right: 20, left: 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       const Flexible(
                    //         child: Text("Bill Number:",
                    //             style: TextStyle(
                    //                 fontSize: 16,
                    //                 color: Color(0xFF0057C2))),
                    //       ),
                    //       Flexible(
                    //         child: Text(
                    //           BillNumnber,
                    //           style: const TextStyle(
                    //               fontSize: 16, color: Color(0xFF0057C2)),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
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
                            child: Text("txn Refference ID:",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF0057C2))),
                          ),
                          Flexible(
                            child: Text(
                              txtrefID,
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
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       top: 8.0, right: 20, left: 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       const Flexible(
                    //         child: Text("Approvel Ref Number :",
                    //             style: TextStyle(
                    //                 fontSize: 16,
                    //                 color: Color(0xFF0057C2))),
                    //       ),
                    //       Flexible(
                    //         child: Text(
                    //           approvalRefNumber,
                    //           style: const TextStyle(
                    //               fontSize: 16, color: Color(0xFF0057C2)),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10.0),
                    //   child: Center(
                    //       child: SizedBox(
                    //     width: size.width * 0.9,
                    //     height: 2,
                    //     child: Center(
                    //         child: Container(
                    //       color: Colors.black26,
                    //     )),
                    //   )),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       top: 8.0, right: 20, left: 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       const Flexible(
                    //         child: Text("Bill Period:",
                    //             style: TextStyle(
                    //                 fontSize: 16,
                    //                 color: Color(0xFF0057C2))),
                    //       ),
                    //       Flexible(
                    //         child: Text(
                    //           BillPeriod,
                    //           style: const TextStyle(
                    //               fontSize: 16, color: Color(0xFF0057C2)),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10.0),
                    //   child: Center(
                    //       child: SizedBox(
                    //     width: size.width * 0.9,
                    //     height: 2,
                    //     child: Center(
                    //         child: Container(
                    //       color: Colors.black26,
                    //     )),
                    //   )),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Customer Convenience Fee :",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF0057C2))),
                          Flexible(
                            child: Text(
                              Custconvenfees,
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
    
                        // context.go("/dashboard");
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