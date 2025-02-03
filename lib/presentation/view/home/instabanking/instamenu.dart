import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/BBPS/bbps.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/myaccount/myaccount.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/quicktransfer.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';

class Instamenu extends StatelessWidget {
  final String titel1;

  final String titel2;

  final String titel3;

  const Instamenu(this.titel1, this.titel2, this.titel3, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () async {
              await getData(context);
            },
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.onPrimary,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(Icons.person,
                        size: 30.sp, color: AppColors.appBlueC),
                  ),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                Text(
                  titel1,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const QuickTransfer()));

             // context.push('/QuickTransfer');
            },
            child: Padding(
              padding: EdgeInsets.only(left: 3.sp, right: 3.sp),
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: AppColors.onPrimary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(Icons.offline_share,
                            size: 30.sp, color: AppColors.appBlueC),
                      )),
                  SizedBox(
                    height: 5.sp,
                  ),
                  Text(
                    titel2,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=> const BBPSConnect()));

              //context.push("/bbps");
            },
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.onPrimary,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset(
                      CustomImages.bbpslogo,
                      height: 30.sp,
                      width: 30.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                Text(
                  titel3,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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

  try {
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

    MyAccountList.childModelsSavingListData = childModelsSavingListData;
    MyAccountList.childModelsCurrentList = childModelsCurrentList;

    MyAccountList.childModelsCCODList = childModelsCCODList;

    MyAccountList.childModelsFDList = childModelsFDList;
    MyAccountList.childModelsRDList = childModelsRDList;
    MyAccountList.childModelsLoanList = childModelsLoanList;

    Loader.hide();

      Navigator.push(context, MaterialPageRoute(builder: (context)=>  const MyAccounts()));

    //context.push("/myaccount");
    
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
