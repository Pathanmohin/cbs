// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/myaccountmodel.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/myaccount/sv&rdaccount/detailedpage/detaile.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/myaccount/sv&rdaccount/detailedpage/detailmodel.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';

class SVAccount extends StatefulWidget {
  const SVAccount({super.key});

  @override
  State<StatefulWidget> createState() => _SVAccountState();
}

class _SVAccountState extends State<SVAccount> {
  String outAvBal = "Available Balance";

  @override
  void initState() {
    super.initState();

    if (SVModel.title == "CC Accounts" || SVModel.title == "Loan Accounts") {
      outAvBal = "Outstanding Balance";
    } else {
      outAvBal = "Available Balance";
    }
  }

  @override
  Widget build(BuildContext context) {
    List<MiniStatementData> dataShowList = MiniDataList.dataShowList;

    var size = MediaQuery.of(context).size;

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              SVModel.title,
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
            backgroundColor: const Color(0xFF0057C2),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Dashboard()));

                    //   context.go("/dashboard");
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
              // Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyAccounts()));

              Navigator.pop(context);

              //    context.pop(context);

              return false;
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20.0),
                  child: Row(
                    children: [
                      Image.asset("assets/images/rdnewimage.png"),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Mini Statement",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF002E5B),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Account Number",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text(SVModel.accNumber,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(outAvBal.toString(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text("\u{20B9} " + SVModel.accBalance,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Last 10 transactions",
                          style: TextStyle(fontSize: 15)),
                      InkWell(
                          onTap: () {
                            DetailsModel.titleDetails = SVModel.title;
                            DetailsModel.accNumberDetails = SVModel.accNumber;
                            DetailsModel.accBalanceDetails =
                                "\u{20B9} " + SVModel.accBalance;

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DetailsPage()));

                            //context.push('/minidetails');
                          },
                          child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFF0057C2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text("Detailed Statement",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))),
                              ))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                  child: Center(
                      child: SizedBox(
                    width: size.width,
                    height: 2,
                    child: Center(
                        child: Container(
                      color: Colors.black26,
                    )),
                  )),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: dataShowList.length,
                    separatorBuilder: (context, index) => Divider(
                      color:
                          Colors.grey, // Customize the color of the separator
                      thickness:
                          1.0, // Customize the thickness of the separator
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(dataShowList[index].trdDate.toString()),
                                  Text(
                                    dataShowList[index].trdamt.toString(),
                                    style: TextStyle(
                                        color: dataShowList[index].color),
                                  ),
                                ],
                              ),
                              Text(dataShowList[index].narration.toString()),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
