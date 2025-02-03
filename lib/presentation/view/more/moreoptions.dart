import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/models/liendatamodel.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/view/more/Widgets/morecom1.dart';
import 'package:hpscb/presentation/view/more/Widgets/morecom2.dart';
import 'package:hpscb/presentation/view/more/Widgets/morecom3.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/titles/custom_titles.dart';

class MoreOptions extends StatefulWidget {
  const MoreOptions({super.key});

  @override
  State<MoreOptions> createState() => _MoreOptionsState();
}

class _MoreOptionsState extends State<MoreOptions> {
  // List<LienData> fdlien = <LienData>[];





  @override
  Widget build(BuildContext context) {
    getData(context);

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.1)),
        // ignore: deprecated_member_use
        child: WillPopScope(
          onWillPop: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Dashboard()));

            return false;
          },
          child: Scaffold(
            backgroundColor: AppColors.onPrimary,
            appBar: AppBar(
              title: Text(
                CustomTitles.moreTitle,
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              backgroundColor: AppColors.appBlueC,
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Dashboard()));
                },
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              iconTheme: const IconThemeData(
                color: AppColors.onPrimary,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.sp,
                    ),

                    const CompMenu1(
                      titel1: "Social Security",
                      subtitle: "Schemes",
                      titel2: "Certificates",
                      titel3: "Cheque Services",
                    ),

                    SizedBox(
                      height: 10.sp,
                    ),

                    const CompMenu2(
                      titel1: 'Add Nominee',
                      titel2: '15G/15H',
                      titel3: 'Positive Pay',
                    ),

                    SizedBox(
                      height: 10.sp,
                    ),

                    CompMenu3(
                      titel1: 'FD Lien',
                      titel2: 'View FD/RD',
                      subtitle1: 'Receipt',
                      titel3: 'FD Interest',
                      subtitle2: "Rate",
                    ),

                    SizedBox(
                      height: 10.sp,
                    ),

                    // CompMenu4(

                    //   titel1: 'Insurance',
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<void> getData(BuildContext context) async {

  int saving = 0;
  int current = 0;
  int ccod = 0;
  int fd = 0;
  int rd = 0;
  int loan = 0;

List<ParentChildModel> childModelsSavingListData = <ParentChildModel>[];
  List<ParentChildModel> childModelsCurrentList = <ParentChildModel>[];
  List<ParentChildModel> childModelsCCODList = <ParentChildModel>[];
  List<ParentChildModel> childModelsFDList = <ParentChildModel>[];
  List<ParentChildModel> childModelsRDList = <ParentChildModel>[];
  List<ParentChildModel> childModelsLoanList = <ParentChildModel>[];

    // ignore: non_constant_identifier_names
    String Data = AccountListData.accListData;

    Map<String, dynamic> map = jsonDecode(Data);

    List<dynamic> listData = map["accountInformation"];

    for (int i = 0; i < listData.length; i++) {
      var config = listData[i];

      if (config["accountType"] == "S") {
        //var test[] = new AccountFetchModel();

        ParentChildModel vObject = ParentChildModel();

        vObject.accountNo = config["accountNo"];
        vObject.customerName = config["customerName"].toString().trim();
        vObject.acckid = config["acckid"];
        String availbalance = config["clearBalance"];
        vObject.brancode = config["brncode"];
        vObject.address = config["address"].toString().trim();
        vObject.brnEname = config["brnname"].toString().trim();
        vObject.comment = config["actEname"];
        vObject.loanslabName = config["loanslabName"];
        vObject.loanslabtype = config["loanslabtype"];
        vObject.roidtfrom = config["roidtfrom"];
        vObject.loanintrestrate = config["loanintrestrate"];
        vObject.loanintrestrate1 = config["loanintrestrate1"];
        vObject.loanintrestrate2 = config["loanintrestrate2"];
        vObject.underClgBalance = config["underClgBalance"];
        vObject.headerTitle = "Saving Account";
        vObject.tittle = "Available Balance:";

        double balance = double.parse(availbalance);
        double avAmount = double.parse(balance.toStringAsFixed(2));

        vObject.availbalance = avAmount.toString();

        childModelsSavingListData.insert(saving, vObject);

        saving = saving + 1;
      } else if (config["accountType"] == "A") {
        ParentChildModel vObject = ParentChildModel();

        vObject.accountNo = config["accountNo"];
        vObject.customerName = config["customerName"].toString().trim();
        vObject.acckid = config["acckid"];
        String availbalance = config["clearBalance"];
        vObject.brancode = config["brncode"];
        vObject.address = config["address"].toString().trim();
        vObject.brnEname = config["brnname"].toString().trim();
        vObject.comment = config["actEname"];
        vObject.loanslabName = config["loanslabName"];
        vObject.loanslabtype = config["loanslabtype"];
        vObject.roidtfrom = config["roidtfrom"];
        vObject.loanintrestrate = config["loanintrestrate"];
        vObject.loanintrestrate1 = config["loanintrestrate1"];
        vObject.loanintrestrate2 = config["loanintrestrate2"];
        vObject.underClgBalance = config["underClgBalance"];
        vObject.headerTitle = "Current Account";
        vObject.tittle = "Available Balance:";

        double balance = double.parse(availbalance);
        double avAmount = double.parse(balance.toStringAsFixed(2));

        vObject.availbalance = avAmount.toString();

        childModelsCurrentList.insert(current, vObject);

        current = current + 1;
      } else if (config["accountType"] == "C") {
        ParentChildModel vObject = ParentChildModel();

        vObject.limittext = "Limit Sanctioned:";
        vObject.limit = config["lmtamt"];

        vObject.interestRate = "Interest Rate";

        vObject.accountNo = config["accountNo"];
        vObject.customerName = config["customerName"].toString().trim();
        vObject.acckid = config["acckid"];
        String availbalance = config["clearBalance"];
        vObject.brancode = config["brncode"];
        vObject.address = config["address"].toString().trim();
        vObject.brnEname = config["brnname"].toString().trim();
        vObject.comment = config["actEname"];
        vObject.loanslabName = config["loanslabName"];
        vObject.loanslabtype = config["loanslabtype"];
        vObject.roidtfrom = config["roidtfrom"];
        vObject.loanintrestrate = config["loanintrestrate"];
        vObject.loanintrestrate1 = config["loanintrestrate1"];
        vObject.loanintrestrate2 = config["loanintrestrate2"];
        vObject.headerTitle = "CC Account";
        vObject.tittle = "Available Balance:";

        double balance = double.parse(availbalance);
        double avAmount = double.parse(balance.toStringAsFixed(2));

        vObject.availbalance = avAmount.toString();

        childModelsCCODList.insert(ccod, vObject);

        ccod = ccod + 1;
      } else if (config["accountType"] == "F") {
        ParentChildModel vObject = ParentChildModel();

        vObject.checkstateus = "";
        vObject.clourcode = "";

        vObject.accountNo = config["accountNo"];

        vObject.address = config["address"].toString().trim();
        vObject.customerName = config["customerName"].toString().trim();
        vObject.acckid = config["acckid"];

        String availbalance = config["clearBalance"];

        vObject.brancode = config["brncode"];
        vObject.brnEname = config["brnname"].toString().trim();

        vObject.comment = config["actEname"];

        vObject.loanslabName = config["loanslabName"];
        //  var loanin = (string)config["Roi"];
        vObject.loanslabtype = config["loanslabtype"];
        vObject.roidtfrom = config["roidtfrom"];
        vObject.loanintrestrate = config["loanintrestrate"];
        vObject.loanintrestrate1 = config["loanintrestrate1"];
        vObject.loanintrestrate2 = config["loanintrestrate2"];

        var fdistatus = config["fdistatus"];
        var fdiflag = config["fdiflag"];

        if (fdistatus == "N" && fdiflag == "I") {
          vObject.checkstateus = "Live";
          vObject.clourcode = "#3da625";
        }
        if (fdistatus == "W" && fdiflag == "A") {
          vObject.checkstateus = "Paid";
          vObject.clourcode = "#FF0000";
        }

        vObject.underClgBalance = config["underClgBalance"];

        double balance = double.parse(availbalance);
        double avAmount = double.parse(balance.toStringAsFixed(2));

        vObject.availbalance = avAmount.toString();

        vObject.headerTitle = "FD Account";
        vObject.tittle = "Available Balance:";

        childModelsFDList.insert(fd, vObject);

        fd = fd + 1;
      } else if (config["accountType"] == "E") {
        ParentChildModel vObject = ParentChildModel();

        vObject.accountNo = config["accountNo"];
        vObject.customerName = config["customerName"].toString().trim();
        vObject.acckid = config["acckid"];
        String availbalance = config["clearBalance"];
        vObject.address = config["address"].toString().trim();
        vObject.brancode = config["brncode"];
        vObject.brnEname = config["brnname"].toString().trim();

        vObject.comment = config["actEname"];

        vObject.loanslabName = config["loanslabName"];
        // var loanin = (string)config["Roi"];
        vObject.loanslabtype = config["loanslabtype"];
        vObject.roidtfrom = config["roidtfrom"];
        vObject.loanintrestrate = config["loanintrestrate"];
        vObject.loanintrestrate1 = config["loanintrestrate1"];
        vObject.loanintrestrate2 = config["loanintrestrate2"];

        vObject.underClgBalance = config["underClgBalance"];

        vObject.headerTitle = "RD Account";
        vObject.tittle = "Available Balance:";

        double balance = double.parse(availbalance);
        double avAmount = double.parse(balance.toStringAsFixed(2));

        vObject.availbalance = avAmount.toString();

        childModelsRDList.insert(rd, vObject);

        rd = rd + 1;

      } else if (config["accountType"] == "D" || config["accountType"] == "T") {
        ParentChildModel vObject = ParentChildModel();

        vObject.accountNo = config["accountNo"];
        vObject.customerName = config["customerName"].toString().trim();

        vObject.acckid = config["acckid"];
        var availbalance = config["clearBalance"];

        vObject.brancode = config["brncode"];
        vObject.address = config["address"].toString().trim();
        vObject.brnEname = config["brnname"].toString().trim();
        vObject.comment = config["actEname"].toString().trim();
        vObject.loanslabName = config["loanslabName"];
        vObject.loanin = config["Roi"] + "%";
        vObject.loanslabtype = config["loanslabtype"];
        vObject.roidtfrom = config["roidtfrom"];
        vObject.loanintrestrate = config["loanintrestrate"];
        vObject.loanintrestrate1 = config["loanintrestrate1"];
        vObject.loanintrestrate2 = config["loanintrestrate2"];

        vObject.limit = config["lmtamt"];

        vObject.limittext = "Limit Sanctioned:";
        vObject.interesttext = " Rate Of Interest:";

        vObject.headerTitle = "Loan Account";
        vObject.tittle = "Outstanding Balance:";
        vObject.interestRate = "Interest Rate";
        vObject.underClgBalance = config["underClgBalance"];

        double balance = double.parse(availbalance);
        double avAmount = double.parse(balance.toStringAsFixed(2));

        vObject.availbalance = avAmount.toString();

        childModelsLoanList.insert(loan, vObject);

        loan = loan + 1;
      }
    }

    MyAccountList.childModelsFDList.clear();

    MyAccountList.childModelsFDList = childModelsFDList;

    MyAccountList.childModelsRDList.clear();
    MyAccountList.childModelsRDList = childModelsRDList;

// Navigator.push(context, MaterialPageRoute(builder: (contex) => const FDRDView()));
  }
}
