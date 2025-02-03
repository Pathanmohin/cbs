// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/models/liendatamodel.dart';
import 'package:hpscb/data/models/moreline.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/more/fdrdreciptprint/fdview/fdView.dart';
import 'package:hpscb/presentation/view/more/fdrdreciptprint/rdview/rdview.dart';
import 'package:hpscb/presentation/view/more/moreoptions.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FDRDView extends StatefulWidget {
  const FDRDView({super.key});
  @override
  State<StatefulWidget> createState() => _FDRDViewState();
}

class _FDRDViewState extends State<FDRDView> {
  bool _fdShow = false;
  bool _rdShow = false;

  List<FdReceipt> fdlistShow = <FdReceipt>[];
  List<FdReceipt> rdlistShow = <FdReceipt>[];

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

  @override
  void initState() {
    super.initState();

    if (MyAccountList.childModelsFDList.isNotEmpty) {
      setFlagFD(true);
    }

    if (MyAccountList.childModelsRDList.isNotEmpty) {
      setFlagRD(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final List<Model> models = [
      Model(
        isExpand: false,
        image: 'https://via.placeholder.com/50',
        synonyms: 'Example Synonyms',
        imageArrow: 'https://via.placeholder.com/20',
        fdModelList: MyAccountList.childModelsFDList,
        rdModelList: MyAccountList.childModelsRDList,
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
              "View Receipt FD/RD",
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
            backgroundColor: const Color(0xFF0057C2),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: InkWell(
                  onTap: () {
                    // Navigator.pop(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const DashboardPage()));

                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MoreOptions()));

                   // context.go('/dashboard');


                  },
                  child: Image.asset(
                    CustomImages.home,
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
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Image.asset(CustomImages.fixdepositnew),
                              const SizedBox(width: 15),
                              const Expanded(
                                child: Text(
                                  "FD Accounts",
                                  style: TextStyle(
                                    color: Colors.black,
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

                                  bool val = await Utils.netWorkCheck(context);

                                  if (val == false) {
                                    return;
                                  }

                                  getListFDSeries(obj.accountNo.toString());

                                  // getList("FD Accounts", obj.accountNo.toString(), obj.availbalance.toString());
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.9,
                                      child: Text(
                                        obj.accountNo.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
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
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Image.asset(CustomImages.rdnewimage),
                              const SizedBox(width: 15),
                              const Expanded(
                                child: Text(
                                  "RD Accounts",
                                  style: TextStyle(
                                    color: Colors.black,
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
                                onTap: () {
                                  // Handle tap gesture
                                  getRDList(obj.accountNo.toString());
                                  // getList("RD Accounts", obj.accountNo.toString(), obj.availbalance.toString());
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.8,
                                      child: Text(
                                        obj.accountNo.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
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
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> getListFDSeries(String accNo) async {
    try {


      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      //String apiUrl = "$protocol$ip$port/rest/AccountService/fddepositrecipt";

      String apiUrl = ApiConfig.fddepositrecipt;

      String jsonString = jsonEncode({
        "Accno": accNo,
      });

       String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "tokenNo": tokenNo,
        "userID": userid,
      };

      // Convert data to JSON

      String encrypted =
          AESencryption.encryptString(jsonString, ibUsrKid);

      final parameters = <String, dynamic>{
        "data": encrypted,
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      try {
        if (response.statusCode == 200) {
          fdlistShow.clear();

          String Dencrypted =
              AESencryption.decryptString(response.body, ibUsrKid);

          var res = json.decode(Dencrypted);

          if (res["Result"].toString().toLowerCase() == "success") {
            var data = json.decode(res["Data"]);

            for (var item in data) {
              FdReceipt vObject = FdReceipt();

              vObject.schcode = item["sch_code"].toString();
              vObject.fdistrsrno = item["fdi_strsrno"].toString();
              vObject.fdiseries = item["fdi_series"].toString();

              String fdidate = item["fdi_date"].toString();
              DateTime fdiDate = DateTime.parse(fdidate);

              vObject.fdidate = DateFormat("MMMM-dd,yyyy").format(fdiDate);

              vObject.fdiintpaid = item["fdi_intpaid"].toString();
              vObject.fditdsamt = item["fdi_tdsamt"].toString();

              vObject.fdiamount = item["fdi_amount"].toString();
              //  vObject.ROL =  item["brn_brcod"].toString();

              String fdimdate = item["fdi_mdate"].toString();
              DateTime fdimDate = DateTime.parse(fdimdate);

              vObject.fdimdate = DateFormat("MMMM-dd,yyyy").format(fdimDate);

              vObject.fdiint = item["fdi_int"].toString();
              vObject.fdimamount = item["fdi_mamount"].toString();

              fdlistShow.add(vObject);
            }

            Loader.hide();

            SavaDataMore.fdListForView = fdlistShow;
            SavaDataMore.accNoFDRe = accNo;

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const FDView()));

            // context.push('/FDView');


          } else if (res["Result"].toString().toLowerCase() == "fail") {
            Loader.hide();
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertBox(
                  title: "Alert",
                  description: res["Data"].toString(),
                );
              },
            );

            return;
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

            return;
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
          return AlertBox(
            title: "Alert",
            description: "Unable to Connect to the Server",
          );
        },
      );

      return;
    }
  }

  Future<void> getRDList(String accno) async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      //String apiUrl = "$protocol$ip$port/rest/AccountService/RDdepositrecipt";\

      String apiUrl = ApiConfig.rddepositrecipt;

      String jsonString = jsonEncode({
        "Accno": accno,
      });

       String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "tokenNo": tokenNo,
        "userID": userid,
      };

      // Convert data to JSON

      String encrypted =
          AESencryption.encryptString(jsonString, ibUsrKid);

      final parameters = <String, dynamic>{
        "data": encrypted,
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      try {
        if (response.statusCode == 200) {
          if (response.body != null || response.body != "") {
            String Dencrypted = AESencryption.decryptString(
                response.body, ibUsrKid);

            var res = json.decode(Dencrypted);

            if (res["Result"].toString().toLowerCase() == "success") {
              rdlistShow.clear();

              var data = json.decode(res["Data"]);

              for (var item in data) {
                FdReceipt vObject = FdReceipt();

                vObject.schcode = item["sch_code"].toString();

                vObject.fdistrsrno = item["rdi_srno"].toString();

                //  vObject.fdiseries = item["fdi_series"].toString();

                String fdidate = item["rdi_date"].toString();

                DateTime fdiDate = DateTime.parse(fdidate);

                vObject.fdidate = DateFormat("MMMM-dd,yyyy").format(fdiDate);

                vObject.fdiintpaid = item["rdi_intpaid"].toString();

                vObject.fditdsamt = item["rdi_matamt"].toString();

                vObject.fdiamount = item["rdi_amt"].toString();
                // vObject.ROL = (string)bob["brn_brcod"];

                vObject.fdimdate = item["rdi_mdate"].toString();

                String rdimdate = item["rdi_mdate"].toString();

                DateTime rdimDate = DateTime.parse(rdimdate);

                vObject.fdimdate = DateFormat("MMMM-dd,yyyy").format(rdimDate);

                vObject.fdiint = item["rdi_roi"].toString();

                vObject.fdimamount = item["rdi_matamt"].toString();

                rdlistShow.add(vObject);
              }

              SavaDataMore.rdListForView = rdlistShow;
              SavaDataMore.accNoFDRe = accno;

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RdView()));

              //context.push('/RdView');

              Loader.hide();
            } else if (res["Result"].toString().toLowerCase() == "fail") {
              Loader.hide();
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: res["Data"].toString(),
                  );
                },
              );

              return;
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

              return;
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
            return;
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
}

class Model {
  bool isExpand;
  String image;
  String synonyms;
  String imageArrow;
  List<ParentChildModel> fdModelList;
  List<ParentChildModel> rdModelList;

  Model({
    required this.isExpand,
    required this.image,
    required this.synonyms,
    required this.imageArrow,
    required this.rdModelList,
    required this.fdModelList,
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

