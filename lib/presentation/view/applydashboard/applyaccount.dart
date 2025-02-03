// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import 'package:hpscb/data/services/api_config.dart';

import 'package:hpscb/presentation/view/applydashboard/currentaccount/currentaccount.dart';
import 'package:hpscb/presentation/view/applydashboard/explorerdmore/exp.dart';
import 'package:hpscb/presentation/view/applydashboard/fdaccount/fdaccountapply.dart';
import 'package:hpscb/presentation/view/applydashboard/loanaccount/apply/loanmodel.dart';
import 'package:hpscb/presentation/view/applydashboard/model/applymodel.dart';
import 'package:hpscb/presentation/view/applydashboard/rdaccount/rdaccountapply.dart';
import 'package:hpscb/presentation/view/applydashboard/savedata/savedata.dart';
import 'package:hpscb/presentation/view/applydashboard/savingaccount/svaccount.dart';
import 'package:hpscb/presentation/view/auth/login_view.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fd/fd.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/rd/rdcreate.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;

class ApplyAccount extends StatefulWidget {
  const ApplyAccount({super.key});
  @override
  State<StatefulWidget> createState() => _ApplyAccount();
}

class _ApplyAccount extends State<ApplyAccount> {
  List<AccountDetailsFirst> listFirstPage = [];
  List<AccountDetails> listSecondMore = [];

  List<LoanDetails> loanacc = [];

  @override
  void initState() {
    super.initState();

    listFirstPage = SaveDataApply.getFirstList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        // ignore: deprecated_member_use
        child: WillPopScope(
          onWillPop: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginView()));

            // context.go('/login');

            return false;
          },
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text(
                  "Apply Now",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: const Color(0xFF0057C2),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                  //change your color here
                ),
              ),
              body: ListView.builder(
                  itemCount: listFirstPage.length,
                  itemBuilder: (BuildContext context, index) {
                    bool exShow = true;
                    //  bool conVis = true;

                    //  if(listFirstPage[index].mbacctypename.toString() == "Saving Bank Account" || listFirstPage[index].mbacctypename.toString() == "Current Account" ||listFirstPage[index].mbacctypename.toString() == "Term Deposits" ||listFirstPage[index].mbacctypename.toString() == "Recurring Deposit"){
                    //    exShow = true;
                    //    conVis = false;
                    //  }

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width,
                              height: 45,
                              alignment: Alignment.centerLeft,
                              decoration: const BoxDecoration(
                                color: Color(0xFF0057C2),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  listFirstPage[index].mbacctypename.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                listFirstPage[index].mbdetail.toString(),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Visibility(
                                    visible: exShow,
                                    child: InkWell(
                                      onTap: () async {
                                        bool val =
                                            await Utils.netWorkCheck(context);

                                        if (val == false) {
                                          return;
                                        }
                                        getApplyMore(
                                            listFirstPage[index]
                                                .mbacctypename
                                                .toString(),
                                            "");
                                      },
                                      child: Container(
                                        height: 50,
                                        width: size.width * 0.4,
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Explore More",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Visibility(
                                      visible: exShow,
                                      child: const SizedBox(
                                        width: 10,
                                      )),

                                  Visibility(
                                    visible: exShow,
                                    child: InkWell(
                                      onTap: () async {
                                        bool val =
                                            await Utils.netWorkCheck(context);

                                        if (val == false) {
                                          return;
                                        }

                                        if (listFirstPage[index]
                                                .mbacctypename ==
                                            "Saving Bank Account") {
                                          Loader.show(context,
                                              progressIndicator:
                                                  const CircularProgressIndicator());

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SVOpenAccount()));

                                          Loader.hide();
                                        } else if (listFirstPage[index]
                                                .mbacctypename ==
                                            "Current Account") {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CAOpenAccount()));
                                        } else if (listFirstPage[index]
                                                .mbacctypename ==
                                            "Term Deposits") {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const FDCreation()));
                                        } else if (listFirstPage[index]
                                                .mbacctypename ==
                                            "Recurring Deposit") {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const RDCreation()));
                                        } else if (listFirstPage[index]
                                                .mbacctypename ==
                                            "Loan Account") {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             const eligiblityLoan()));

                                          //loanAccount();

                                          await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertBox(
                                                title: "Alert",
                                                description: "Work in process",
                                              );
                                            },
                                          );

                                          return;
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        width: size.width * 0.4,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF0057C2),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Apply",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Visibility(
                                  //   visible: conVis,
                                  //   child: InkWell(
                                  //     onTap: () async {
                                  //       final List<ConnectivityResult>
                                  //           connectivityResult =
                                  //           await (Connectivity().checkConnectivity());

                                  //       if (connectivityResult
                                  //           .contains(ConnectivityResult.none)) {
                                  //         showDialog(
                                  //           context: context,
                                  //           builder: (BuildContext context) {
                                  //             return AlertDialog(
                                  //               title: const Text(
                                  //                 'Alert',
                                  //                 style: TextStyle(fontSize: 16),
                                  //               ),
                                  //               content: const Text(
                                  //                 'Please Check Your Internet Connection',
                                  //                 style: TextStyle(fontSize: 16),
                                  //               ),
                                  //               actions: [
                                  //                 TextButton(
                                  //                   onPressed: () {
                                  //                     Navigator.of(context).pop();
                                  //                   },
                                  //                   child: const Text(
                                  //                     'OK',
                                  //                     style: TextStyle(fontSize: 16),
                                  //                   ),
                                  //                 ),
                                  //               ],
                                  //             );
                                  //           },
                                  //         );

                                  //         return;
                                  //       }

                                  //       if(listFirstPage[index].mbacctypename == "Saving Bank Account"){

                                  //         Navigator.push(context, MaterialPageRoute(builder: (context)=> const SavingApply()));

                                  //       }else if(listFirstPage[index].mbacctypename == "Current Account"){

                                  //         Navigator.push(context, MaterialPageRoute(builder: (context)=> const SavingApply()));

                                  //       }else if(listFirstPage[index].mbacctypename == "Term Deposits"){

                                  //         Navigator.push(context, MaterialPageRoute(builder: (context)=> const SavingApply()));

                                  //       }else if(listFirstPage[index].mbacctypename == "Recurring Deposit"){

                                  //         Navigator.push(context, MaterialPageRoute(builder: (context)=> const SavingApply()));

                                  //       }else if(listFirstPage[index].mbacctypename == "Loan Account"){

                                  //         Navigator.push(context, MaterialPageRoute(builder: (context)=> const SavingApply()));

                                  //       }

                                  //     },
                                  //     child: Container(
                                  //       height: 50,
                                  //       width: size.width * 0.8,
                                  //       decoration: BoxDecoration(
                                  //         color: const Color(0xFF0057C2),
                                  //         borderRadius: BorderRadius.circular(10),
                                  //       ),
                                  //       child: Center(
                                  //         child: Text(
                                  //           "Apply Online",
                                  //           style: TextStyle(
                                  //               color: Colors.white,
                                  //               fontSize: 14,
                                  //               fontWeight: FontWeight.bold),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })),
        ),
      );
    });
  }

  // API code

  Future<void> getApplyMore(String heading, String subheading) async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      // String apiUrl = "/rest/AccountService/accDetails";

      String apiUrl = ApiConfig.accDetails;

      String jsonString = jsonEncode({
        "head": heading,
        "subhead": subheading,
        "subheadName": "",
        "subheadN": ""
      });

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonString,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      try {
        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);

          if (res["Result"].toString().toLowerCase() == "success") {
            if (res["Data"] != null ||
                res["Data"] != [] ||
                res["Data"] != "[]") {
              listSecondMore.clear();

              var data = jsonDecode(res["Data"]);

              for (int i = 0; i < data.length; i++) {
                var getRes = data[i];

                AccountDetails vObject = AccountDetails();

                vObject.id = getRes["accdetails_kid"];
                vObject.headname = getRes["headname"];
                vObject.details = getRes["details"];
                vObject.requirement = getRes["requirement"];
                vObject.eligibility = getRes["eligibility"];
                vObject.subhead = getRes["subhead"];
                vObject.flag = getRes["flag"];

                listSecondMore.add(vObject);
              }

              SaveDataApply.getSceondApplyList = listSecondMore;

              Loader.hide();

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ExploreMore()));

              //  Navigator.push(context, MaterialPageRoute(builder: (context) => const ApplyAccount()));
            } else {
              Loader.hide();
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: "Server is not responding..!",
                  );
                },
              );

              return;
            }
          } else {
            Loader.hide();
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertBox(
                  title: "Alert",
                  description: "Server is not responding..!",
                );
              },
            );

            return;
          }
        } else {
          Loader.hide();
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: "Alert",
                description: "Server failed..!",
              );
            },
          );

          return;
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

        return;
      }
    } catch (e) {
      Loader.hide();
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Builder(builder: (context) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.1)),
              child: AlertBox(
                title: "Alert",
                description: "Unable to Connect to the Server",
              ),
            );
          });
        },
      );

      return;
    }
  }

  // Future<void> loanAccount() async {
  //   try {
  //     // String ip = ServerDetails().getIPaddress();
  //     // String port = ServerDetails().getPort();
  //     // String protocol = ServerDetails().getProtocol();

  //     Loader.show(context,
  //         progressIndicator: const CircularProgressIndicator());

  //    // String apiUrl = "rest/AccountService/fetchloantypes";

  //    String apiUrl = ApiConfig.fetchloantypes;

  //     String jsonString = jsonEncode({});

  //     Map<String, String> headers = {
  //       "Content-Type": "application/x-www-form-urlencoded",
  //     };

  //     var response = await http.post(
  //       Uri.parse(apiUrl),
  //       body: jsonString,
  //       headers: headers,
  //       encoding: Encoding.getByName('utf-8'),
  //     );

  //     try {
  //       if (response.statusCode == 200) {
  //         var res = json.decode(response.body);

  //         if (kDebugMode) {
  //           print(res);
  //         }

  //         if (res["Result"].toString().toLowerCase() == "success") {
  //           var data = json.decode(res["Data"]);

  //           for (int i = 0; i < data.length; i++) {
  //             var listData = data[i];

  //             LoanDetails vObject = LoanDetails();

  //             vObject.loanname = listData["loanname"].toString();
  //             vObject.act_code = listData["act_code"].toString();
  //             vObject.act_atptype = listData["act_atptype"].toString();
  //             vObject.ltype_remark = listData["ltype_remark"].toString();

  //             loanacc.add(vObject);
  //           }

  //           //print(data);
  //           Loader.hide();

  //           LoansaveData.loanacc = loanacc;

  //           Navigator.push(context,
  //               MaterialPageRoute(builder: (context) => const LoanAccount()));
  //         } else {
  //           Loader.hide();
  //           await showDialog(
  //             context: context,
  //             builder: (BuildContext context) {
  //               return AlertBox(
  //                 title: "Alert",
  //                 description: "Unable to Connect to the Server",
  //               );
  //             },
  //           );

  //           return;
  //         }
  //       } else {
  //         Loader.hide();
  //         await showDialog(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return AlertBox(
  //               title: "Alert",
  //               description: "Unable to Connect to the Server",
  //             );
  //           },
  //         );

  //         return;
  //       }
  //     } catch (e) {
  //       Loader.hide();
  //       await showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertBox(
  //             title: "Alert",
  //             description: "Unable to Connect to the Server",
  //           );
  //         },
  //       );

  //       return;
  //     }
  //   } catch (e) {
  //     Loader.hide();
  //     await showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Builder(builder: (context) {
  //           return MediaQuery(
  //             data: MediaQuery.of(context)
  //                 .copyWith(textScaler: const TextScaler.linear(1.1)),
  //             child: AlertBox(
  //               title: "Alert",
  //               description: "Unable to Connect to the Server",
  //             ),
  //           );
  //         });
  //       },
  //     );

  //     return;
  //   }
  // }
}
