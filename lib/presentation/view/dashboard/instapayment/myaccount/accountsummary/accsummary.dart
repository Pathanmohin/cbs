// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/myaccount/accountsummary/comp/accsummarycomp.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';

class AccSummary extends StatefulWidget {
  const AccSummary({super.key});

  @override
  State<StatefulWidget> createState() => _AccSummaryState();
}

class _AccSummaryState extends State<AccSummary> {
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

    if (MyAccountList.childModelsSavingListData.length != 0) {
      setFlagAcc(true);
    }

    if (MyAccountList.childModelsCurrentList.length != 0) {
      setFlagCA(true);
    }

    if (MyAccountList.childModelsCCODList.length != 0) {
      setFlagCC(true);
    }

    if (MyAccountList.childModelsFDList.length != 0) {
      setFlagFD(true);
    }

    if (MyAccountList.childModelsRDList.length != 0) {
      setFlagRD(true);
    }

    if (MyAccountList.childModelsLoanList.length != 0) {
      setFlagLoan(true);
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
              "Account Summary",
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

                    // context.go("/dashboard");
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                // All accounts
                //-----------------------------------------------------------------------------------------------------
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
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/savingimagesnew.png",
                                color: Colors.red,
                              ),
                              const SizedBox(width: 15),
                              const Expanded(
                                child: Text(
                                  "Saving Accounts",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                              // Image.network(model.imageArrow),
                            ],
                          ),
                        ),
                        children: model.svModelList.map((ParentChildModel obj) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                // Handle tap gesture
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AccComp(
                                            title: "Account Name:",
                                            description: obj.comment.toString(),
                                          ),
                                          AccComp(
                                            title: "Account Number:",
                                            description:
                                                obj.accountNo.toString(),
                                          ),
                                          AccComp(
                                            title: "A/c Holder Name:",
                                            description: obj.customerName
                                                .toString()
                                                .trim(),
                                          ),
                                          AccComp(
                                            title: "Branch Name:",
                                            description:
                                                obj.brnEname.toString().trim(),
                                          ),
                                          AccComp(
                                            title: "Available Balance:",
                                            description:
                                                obj.availbalance.toString(),
                                          ),
                                          AccComp(
                                            title: "UnderClear Balance:",
                                            description:
                                                obj.underClgBalance.toString(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, left: 5, right: 5),
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
                                        ],
                                      )),
                                  const SizedBox(
                                    height: 2,
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),

                const SizedBox(
                  height: 0,
                ),

                // Current Accounts
                //------------------------------------------------------------------------------------------------------

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
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/currentnewimage.png",
                                color: Colors.red,
                              ),
                              const SizedBox(width: 15),
                              const Expanded(
                                child: Text(
                                  "Current Accounts",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
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
                          return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                // Handle tap gesture
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AccComp(
                                            title: "Account Name:",
                                            description: obj.comment.toString(),
                                          ),
                                          AccComp(
                                            title: "Account Number:",
                                            description:
                                                obj.accountNo.toString(),
                                          ),
                                          AccComp(
                                            title: "A/c Holder Name:",
                                            description: obj.customerName
                                                .toString()
                                                .trim(),
                                          ),
                                          AccComp(
                                            title: "Branch Name:",
                                            description:
                                                obj.brnEname.toString().trim(),
                                          ),
                                          AccComp(
                                            title: "Available Balance:",
                                            description:
                                                obj.availbalance.toString(),
                                          ),
                                          AccComp(
                                            title: "UnderClear Balance:",
                                            description:
                                                obj.underClgBalance.toString(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, left: 5, right: 5),
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
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),

                // CC Accounts
                //------------------------------------------------------------------------------------------------------

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
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.credit_card,
                                color: Colors.red,
                                size: 28, // Change this to any color you prefer
                              ),

                              SizedBox(width: 15),
                              Expanded(
                                child: Text(
                                  "CC Accounts",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
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
                          return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                // Handle tap gesture
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AccComp(
                                            title: "Account Name:",
                                            description:
                                                obj.comment.toString().trim(),
                                          ),
                                          AccComp(
                                            title: "Account Number:",
                                            description:
                                                obj.accountNo.toString(),
                                          ),
                                          AccComp(
                                            title: "A/c Holder Name:",
                                            description: obj.customerName
                                                .toString()
                                                .trim(),
                                          ),
                                          AccComp(
                                            title: "Branch Name:",
                                            description:
                                                obj.brnEname.toString().trim(),
                                          ),
                                          AccComp(
                                            title: "Outstanding Balance:",
                                            description:
                                                obj.availbalance.toString(),
                                          ),
                                          // AccComp(title: "UnderClear Balance:",description:obj.underClgBalance.toString(),),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, left: 5, right: 5),
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
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),

                // FD Accounts
                //------------------------------------------------------------------------------------------------------

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
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/fixdepositnew.png",
                                color: Colors.red,
                              ),
                              const SizedBox(width: 15),
                              const Expanded(
                                child: Text(
                                  "FD Accounts",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                              // Image.network(model.imageArrow),
                            ],
                          ),
                        ),
                        children: model.fdModelList.map((ParentChildModel obj) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                // Handle tap gesture
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AccComp(
                                            title: "Account Name:",
                                            description: obj.comment.toString(),
                                          ),
                                          AccComp(
                                            title: "Account Number:",
                                            description:
                                                obj.accountNo.toString(),
                                          ),
                                          AccComp(
                                            title: "A/c Holder Name:",
                                            description: obj.customerName
                                                .toString()
                                                .trim(),
                                          ),
                                          AccComp(
                                            title: "Branch Name:",
                                            description:
                                                obj.brnEname.toString().trim(),
                                          ),
                                          AccComp(
                                            title: "Available Balance:",
                                            description:
                                                obj.availbalance.toString(),
                                          ),
                                          AccComp(
                                            title: "UnderClear Balance:",
                                            description:
                                                obj.underClgBalance.toString(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, left: 5, right: 5),
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
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),

                // RD Accounts
                //------------------------------------------------------------------------------------------------------
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
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/rdnewimage.png",
                                color: Colors.red,
                              ),
                              const SizedBox(width: 15),
                              const Expanded(
                                child: Text(
                                  "RD Accounts",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                              // Image.network(model.imageArrow),
                            ],
                          ),
                        ),
                        children: model.rdModelList.map((ParentChildModel obj) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                // Handle tap gesture
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AccComp(
                                            title: "Account Name:",
                                            description: obj.comment.toString(),
                                          ),
                                          AccComp(
                                            title: "Account Number:",
                                            description:
                                                obj.accountNo.toString(),
                                          ),
                                          AccComp(
                                            title: "A/c Holder Name:",
                                            description: obj.customerName
                                                .toString()
                                                .trim(),
                                          ),
                                          AccComp(
                                            title: "Branch Name:",
                                            description:
                                                obj.brnEname.toString().trim(),
                                          ),
                                          AccComp(
                                            title: "Available Balance:",
                                            description:
                                                obj.availbalance.toString(),
                                          ),
                                          AccComp(
                                            title: "UnderClear Balance:",
                                            description:
                                                obj.underClgBalance.toString(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, left: 5, right: 5),
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
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),

                // Loan Accounts
                //------------------------------------------------------------------------------------------------------

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
                              Image.asset(
                                "assets/images/newloanimage.png",
                                color: Colors.red,
                              ),
                              const SizedBox(width: 15),
                              const Expanded(
                                child: Text(
                                  "Loan Accounts",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
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
                          return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                // Handle tap gesture
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AccComp(
                                            title: "Account Name:",
                                            description: obj.comment.toString(),
                                          ),
                                          AccComp(
                                            title: "Account Number:",
                                            description:
                                                obj.accountNo.toString(),
                                          ),
                                          AccComp(
                                            title: "A/c Holder Name:",
                                            description: obj.customerName
                                                .toString()
                                                .trim(),
                                          ),
                                          AccComp(
                                            title: "Branch Name:",
                                            description:
                                                obj.brnEname.toString().trim(),
                                          ),
                                          AccComp(
                                            title: "Outstanding Balance:",
                                            description:
                                                obj.availbalance.toString(),
                                          ),
                                          AccComp(
                                            title: "UnderClear Balance:",
                                            description:
                                                obj.underClgBalance.toString(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, left: 5, right: 5),
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
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
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
