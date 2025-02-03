// ignore_for_file: prefer_is_not_empty

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/presentation/view/applydashboard/fdaccount/cal/calfd.dart';
import 'package:hpscb/presentation/view/applydashboard/model/applymodel.dart';
import 'package:hpscb/presentation/view/applydashboard/rdaccount/cal/rdcal.dart';
import 'package:hpscb/presentation/view/applydashboard/savedata/savedata.dart';

class ExploreMore extends StatefulWidget {
  const ExploreMore({super.key});

  @override
  State<StatefulWidget> createState() => _ExploreMoreState();
}

class _ExploreMoreState extends State<ExploreMore> {
  List<AccountDetails> listDetails = [];

  String? head;
  String? des;
  String? req;
  String? eli;
  String? flag;

  bool rdClick = false;
  bool fdClick = false;

  bool headDetails = false;
  bool reqShow = false;
  bool eliShow = false;

  @override
  void initState() {
    super.initState();

    listDetails = SaveDataApply.getSceondApplyList;

    head = listDetails[0].headname.toString();
    des = listDetails[0].details.toString();
    req = listDetails[0].requirement.toString();
    eli = listDetails[0].eligibility.toString();
    flag = listDetails[0].flag.toString();

    if (flag == "Y" && head == "Recurring Deposit") {
      rdClick = true;
    }

    if (flag == "Y" && head == "Term Deposits") {
      fdClick = true;
    }

    if (!head.toString().isEmpty) {
      headDetails = true;
    }

    if (req.toString() != "null" && !req.toString().isEmpty) {
      reqShow = true;
    }

    if (eli.toString() != "null" && !eli.toString().isEmpty) {
      eliShow = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              head.toString(),
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
            backgroundColor: const Color(0xFF0057C2),
            iconTheme: const IconThemeData(
              color: Colors.white,
              //change your color here
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                      visible: headDetails,
                      child: Text(
                        head.toString(),
                        style: const TextStyle(
                          fontSize: 26,
                          color: Color(0xFF0057C2),
                        ),
                      )),
                  Visibility(
                    visible: headDetails,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(des.toString()),
                    ),
                  ),
                  Visibility(
                    visible: reqShow,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Requirement",
                        style: TextStyle(
                          fontSize: 26,
                          color: Color(0xFF0057C2),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: reqShow,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(req.toString()),
                    ),
                  ),
                  Visibility(
                    visible: eliShow,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Eligibility",
                        style: TextStyle(
                          fontSize: 26,
                          color: Color(0xFF0057C2),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: eliShow,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(eli.toString()),
                    ),
                  ),
                  Visibility(
                    visible: rdClick,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: InkWell(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RDCal()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 50.sp,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0057C2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Calculator",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: fdClick,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: InkWell(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FDCal()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 50.sp,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0057C2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Calculator",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
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
}
