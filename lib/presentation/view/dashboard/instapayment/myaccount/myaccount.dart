// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/models/myaccountmodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/myaccount/accountsummary/accsummary.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/myaccount/sv&rdaccount/svaccount.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyAccounts extends StatefulWidget {
  const MyAccounts({super.key});
  @override
  State<StatefulWidget> createState() => _MyAccountsState();
}

class _MyAccountsState extends State<MyAccounts> {
  bool _accShow = false;
  bool _ccShow = false;
  bool _caShow = false;
  bool _fdShow = false;
  bool _rdShow = false;
  bool _loanShow = false;

  void setFlagAcc(bool flag) {
    setState(() {
      _accShow = flag;
    });
  }

  void setFlagCA(bool flag) {
    setState(() {
      _caShow = flag;
    });
  }

  void setFlagCC(bool flag) {
    setState(() {
      _ccShow = flag;
    });
  }

  void setFlagFD(bool flag) {
    setState(() {
      _fdShow = flag;
    });
  }

  void setFlagRD(bool flag) {
    setState(() {
      _rdShow = flag;
    });
  }

  void setFlagLoan(bool flag) {
    setState(() {
      _loanShow = flag;
    });
  }

  @override
  void initState() {
    super.initState();

    if (MyAccountList.childModelsSavingListData.isNotEmpty) {
      setFlagAcc(true);
    }

    if (MyAccountList.childModelsCurrentList.isNotEmpty) {
      setFlagCA(true);
    }

    if (MyAccountList.childModelsCCODList.isNotEmpty) {
      setFlagCC(true);
    }

    if (MyAccountList.childModelsFDList.isNotEmpty) {
      setFlagFD(true);
    }

    if (MyAccountList.childModelsRDList.isNotEmpty) {
      setFlagRD(true);
    }

    if (MyAccountList.childModelsLoanList.isNotEmpty) {
      setFlagLoan(true);
    }
  }

  List<MiniStatementData> dataShowList = <MiniStatementData>[];

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    double _getButtonFontSize(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;

      if (screenWidth > 600) {
        return 14.0; // Large screen
      } else if (screenWidth > 400) {
        return 15.0; // Medium screen
      } else {
        return 16.0; // Default size
      }
    }

    final List<Model> models = [
      Model(
        isExpand: false,
        image: 'https://via.placeholder.com/50',
        synonyms: 'Example Synonyms',
        imageArrow: 'https://via.placeholder.com/20',
        svModelList: MyAccountList.childModelsSavingListData,
        curentModelList: MyAccountList.childModelsCurrentList,
        ccvModelList: MyAccountList.childModelsCCODList,
        fdModelList: MyAccountList.childModelsFDList,
        rdModelList: MyAccountList.childModelsRDList,
        loanModelList: MyAccountList.childModelsLoanList,
      ),

      // Add more models if needed
    ];
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "My Accounts",
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
            backgroundColor: const Color(0xFF0057C2),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: InkWell(
                  onTap: () {
// Dashboard redirect ----------------------------------------------------------------------------------
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const DashboardPage()));

                    Navigator.pop(context);
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
            iconTheme: const IconThemeData(
              color: Colors.white,
              //change your color here
            ),
          ),
          body: WillPopScope(
            onWillPop: () async {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const DashboardPage()));

              Navigator.pop(context);

              return false;
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Use a ListView.builder to create the expandable items dynamically
                  Visibility(
                    visible: _accShow,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: models.length,
                      itemBuilder: (context, index) {
                        final model = models[index];

                        return ExpansionTile(
                          initiallyExpanded: model.isExpand,
                          onExpansionChanged: (expanded) {
                            // Handle expansion change
                            model.isExpand = expanded;
                          },
                          title: Container(
                            padding: EdgeInsets.all(10.sp),
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10.sp),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                    "assets/images/savingimagesnew.png"),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Text(
                                    "Saving Accounts",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                                // Image.network(model.imageArrow),
                              ],
                            ),
                          ),
                          children:
                              model.svModelList.map((ParentChildModel obj) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(10.sp),
                                margin: EdgeInsets.symmetric(
                                    vertical: 0.sp, horizontal: 20.sp),
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    Loader.show(context,
                                        progressIndicator:
                                            const CircularProgressIndicator());

                                    await getList(
                                        "Saving Account",
                                        obj.accountNo.toString(),
                                        obj.availbalance.toString());
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: Text(
                                          obj.accountNo.toString(),
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.sp,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),

                  //---------------------------------------------------
                  //Current Accounts

                  Visibility(
                    visible: _caShow,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: models.length,
                      itemBuilder: (context, index) {
                        final model = models[index];

                        return ExpansionTile(
                          initiallyExpanded: model.isExpand,
                          onExpansionChanged: (expanded) {
                            // Handle expansion change
                            model.isExpand = expanded;
                          },
                          title: Container(
                            padding: const EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(
                                vertical: 5.sp, horizontal: 10.sp),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                    "assets/images/currentnewimage.png"),
                                SizedBox(width: 15.sp),
                                Expanded(
                                  child: Text(
                                    "Current Accounts",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                                // Image.network(model.imageArrow),
                              ],
                            ),
                          ),
                          children:
                              model.curentModelList.map((ParentChildModel obj) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 20),
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    // Handle tap gesture

                                    Loader.show(context,
                                        progressIndicator:
                                            const CircularProgressIndicator());

                                    await getList(
                                        "Current Accounts",
                                        obj.accountNo.toString(),
                                        obj.availbalance.toString());
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: Text(
                                          obj.accountNo.toString(),
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),

                  //---------------------------------------------------
                  //CC Accounts

                  Visibility(
                    visible: _ccShow,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: models.length,
                      itemBuilder: (context, index) {
                        final model = models[index];

                        return ExpansionTile(
                          initiallyExpanded: model.isExpand,
                          onExpansionChanged: (expanded) {
                            // Handle expansion change
                            model.isExpand = expanded;
                          },
                          title: Container(
                            padding: EdgeInsets.all(10.sp),
                            margin: EdgeInsets.symmetric(
                                vertical: 5.sp, horizontal: 10.sp),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.credit_card,
                                  color: const Color(0xFF002E5B),
                                  size: 28
                                      .sp, // Change this to any color you prefer
                                ),

                                SizedBox(width: 15.sp),
                                Expanded(
                                  child: Text(
                                    "CC Accounts",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                                // Image.network(model.imageArrow),
                              ],
                            ),
                          ),
                          children:
                              model.ccvModelList.map((ParentChildModel obj) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(10.sp),
                                margin: EdgeInsets.symmetric(
                                    vertical: 0.sp, horizontal: 20.sp),
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    // Handle tap gesture

                                    Loader.show(context,
                                        progressIndicator:
                                            const CircularProgressIndicator());

                                    await getList(
                                        "CC Accounts",
                                        obj.accountNo.toString(),
                                        obj.availbalance.toString());
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: Text(
                                          obj.accountNo.toString(),
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                  //---------------------------------------------------

                  Visibility(
                    visible: _fdShow,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: models.length,
                      itemBuilder: (context, index) {
                        final model = models[index];

                        return ExpansionTile(
                          initiallyExpanded: model.isExpand,
                          onExpansionChanged: (expanded) {
                            // Handle expansion change
                            model.isExpand = expanded;
                          },
                          title: Container(
                            padding: EdgeInsets.all(10.sp),
                            margin: EdgeInsets.symmetric(
                                vertical: 5.sp, horizontal: 10.sp),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Image.asset("assets/images/fixdepositnew.png"),
                                SizedBox(width: 15.sp),
                                Expanded(
                                  child: Text(
                                    "FD Accounts",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                                // Image.network(model.imageArrow),
                              ],
                            ),
                          ),
                          children:
                              model.fdModelList.map((ParentChildModel obj) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(10.sp),
                                margin: EdgeInsets.symmetric(
                                    vertical: 0.sp, horizontal: 20.sp),
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    // Handle tap gesture

                                    Loader.show(context,
                                        progressIndicator:
                                            const CircularProgressIndicator());

                                    await getList(
                                        "FD Accounts",
                                        obj.accountNo.toString(),
                                        obj.availbalance.toString());
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: Text(
                                          obj.accountNo.toString(),
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 1),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),

                  //----------------------------------------------------------------------------------------
                  Visibility(
                    visible: _rdShow,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: models.length,
                      itemBuilder: (context, index) {
                        final model = models[index];

                        return ExpansionTile(
                          initiallyExpanded: model.isExpand,
                          onExpansionChanged: (expanded) {
                            // Handle expansion change
                            model.isExpand = expanded;
                          },
                          title: Container(
                            padding: EdgeInsets.all(10.sp),
                            margin: EdgeInsets.symmetric(
                                vertical: 5.sp, horizontal: 10.sp),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Image.asset("assets/images/rdnewimage.png"),
                                SizedBox(width: 15.sp),
                                Expanded(
                                  child: Text(
                                    "RD Accounts",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                                // Image.network(model.imageArrow),
                              ],
                            ),
                          ),
                          children:
                              model.rdModelList.map((ParentChildModel obj) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(10.sp),
                                margin: EdgeInsets.symmetric(
                                    vertical: 0.sp, horizontal: 20.sp),
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    // Handle tap gesture
                                    Loader.show(context,
                                        progressIndicator:
                                            const CircularProgressIndicator());
                                    await getList(
                                        "RD Accounts",
                                        obj.accountNo.toString(),
                                        obj.availbalance.toString());
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: Text(
                                          obj.accountNo.toString(),
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),

                  //---------------------------------------------------

                  Visibility(
                    visible: _loanShow,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: models.length,
                      itemBuilder: (context, index) {
                        final model = models[index];

                        return ExpansionTile(
                          initiallyExpanded: model.isExpand,
                          onExpansionChanged: (expanded) {
                            // Handle expansion change
                            model.isExpand = expanded;
                          },
                          title: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Image.asset("assets/images/newloanimage.png"),
                                SizedBox(width: 15.sp),
                                Expanded(
                                  child: Text(
                                    "Loan Accounts",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                                // Image.network(model.imageArrow),
                              ],
                            ),
                          ),
                          children:
                              model.loanModelList.map((ParentChildModel obj) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: EdgeInsets.symmetric(
                                    vertical: 0.sp, horizontal: 20.sp),
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    // Handle tap gesture

                                    Loader.show(context,
                                        progressIndicator:
                                            const CircularProgressIndicator());

                                    await getList(
                                        "Loan Accounts",
                                        obj.accountNo.toString(),
                                        obj.availbalance.toString());
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: Text(
                                          obj.accountNo.toString(),
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),

                  InkWell(
                    onTap: () async {
// Page Redirect ----------------------------------------------------------------------------------

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccSummary()));

                      // context.push("/summaryaccount");
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0057C2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/images/balance_sheet_icon_1.png",
                                color: Colors.white,
                              ),

                              const SizedBox(width: 8),
                              // Add some spacing between the icon and the text
                              Text(
                                "Accounts Summary",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: _getButtonFontSize(context),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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
      );
    });
  }

  Future<void> getList(
      String title, String accNumber, String accBalance) async {
    dataShowList.clear();      
    
    Loader.show(context,  progressIndicator: const CircularProgressIndicator());



    // final getAccountModel = Provider.of<DashboardViewmodel>(context,listen: false);

    // String customerId = context.read<SessionProvider>().get('customerId');
    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');
    String sessionId = context.read<SessionProvider>().get('sessionId');

    String titelAccount = title;
    String accNumberAccount = accNumber;
    String accBalanceAccount = accBalance;

    try {
      // ignore: unused_local_variable
      String val = SVModel.accNumber.toString();

      String apiUrl = ApiConfig.ministatement;

      String jsonString = jsonEncode({
        "sessionID": sessionId,
        "userID": userid,
        "accNo": accNumberAccount,
      });

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "tokenNo": tokenNo,
        "userID": userid,
      };

      // Convert data to JSON

      String encrypted = AESencryption.encryptString(jsonString, ibUsrKid);

      final parameters = <String, dynamic>{
        "data": encrypted,
      };

      try {
        var response = await http.post(
          Uri.parse(apiUrl),
          body: parameters,
          headers: headers,
          encoding: Encoding.getByName('utf-8'),
        );

        // Check if request was successful
        if (response.statusCode == 200) {
          // ignore: unnecessary_null_comparison
          if (response.body != null) {
            var res = jsonDecode(response.body);

            if (res["Result"] == "Success") {
              dataShowList.clear();

              var deEnData = AESencryption.decryptString(res["Data"], ibUsrKid);

              var getdataList = jsonDecode(deEnData);

              var list = getdataList["tranList"];

              if (kDebugMode) {
                print(list);
              }

              for (int i = 0; i < list.length; i++) {
                Map<String, dynamic> lastdata = list[i];

                MiniStatementData mini = MiniStatementData();

String rawDate = lastdata["trdDate"];
  DateTime date;


    if (rawDate.contains('/')) {
      // If the date contains '/', assume it's in dd/MM/yyyy format
      DateFormat inputFormat = DateFormat("dd/MM/yyyy");
      date = inputFormat.parse(rawDate);
    } else {
      // Assume it's in yyyy-MM-dd HH:mm:ss.S format
      DateFormat inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss.S");
      date = inputFormat.parse(rawDate);
    }




                // DateFormat inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss.S");

                // DateTime date = inputFormat.parse(lastdata["trdDate"]);

                // var dateGet = lastdata["trdDate"].toString().split('/');

                // var formattedDate = "${dateGet[2]}-${dateGet[1]}-${dateGet[0]}";

                DateFormat outputFormat = DateFormat("dd-MM-yyyy");
                String formattedDate = outputFormat.format(date);

                mini.trdDate = formattedDate;

                if (lastdata["trdDrCr"] == "D") {
                  mini.trdamt = "- " + "\u{20B9}" + lastdata["trdAmt"];
                  mini.color = const Color(0xFFFF0000);
                } else {
                  mini.trdamt = "+ " + "\u{20B9}" + lastdata["trdAmt"];
                  mini.color = const Color(0xFF3DA625);
                }

                mini.narration = lastdata["narration"].toString();
                mini.trAccID = lastdata["trAccID"].toString();
                mini.curbalance = lastdata["curbalance"].toString();

                dataShowList.add(mini);
              }

              SVModel.accNumber = accNumberAccount;
              SVModel.accBalance = accBalanceAccount;
              SVModel.title = titelAccount;

              MiniDataList.dataShowList = dataShowList;

              Loader.hide();

              // Saving account -----------------------------------------------------------------------------------

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SVAccount()));

              //  context.push("/ministatment");
            } else {
              Loader.hide();
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: "${res["Message"]}",
                  );
                },
              );
            }
          } else {
            Loader.hide();
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertBox(
                  title: "Alert",
                  description: "Server not responding",
                );
              },
            );
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
    }
  }
}

class Model {
  bool isExpand;
  String image;
  String synonyms;
  String imageArrow;
  List<ParentChildModel> svModelList;
  List<ParentChildModel> curentModelList;
  List<ParentChildModel> ccvModelList;
  List<ParentChildModel> fdModelList;
  List<ParentChildModel> rdModelList;
  List<ParentChildModel> loanModelList;

  Model({
    required this.isExpand,
    required this.image,
    required this.synonyms,
    required this.imageArrow,
    required this.svModelList,
    required this.curentModelList,
    required this.ccvModelList,
    required this.rdModelList,
    required this.fdModelList,
    required this.loanModelList,
  });
}

// class ChildModel {
//   String accountNo;
//   String headerTitle;
//   ChildModel({
//     required this.accountNo,
//     required this.headerTitle,
//   });
// }

// Sample data
