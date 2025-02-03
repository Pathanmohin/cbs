// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/models/liendatamodel.dart';
import 'package:hpscb/data/models/moreline.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fdrdmodel/model.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fdrfdatasave/datasave.dart';
import 'package:hpscb/presentation/view/more/fd_interest/fdinterest.dart';
import 'package:hpscb/presentation/view/more/fdliendata/fdliendata.dart';
import 'package:hpscb/presentation/view/more/fdrdreciptprint/fdrfview.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CompMenu3 extends StatelessWidget {
  final String titel1;

  final String titel2;

  final String titel3;
  final String subtitle1;
  final String subtitle2;

  CompMenu3({
    super.key,
    required this.titel1,
    required this.titel2,
    required this.titel3,
    required this.subtitle1,
    required this.subtitle2,
  });

  List<LienData> fdlien = <LienData>[];

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

  List<InterestRate> intrestList = <InterestRate>[];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sp),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3.sp),
            spreadRadius: 2.sp,
            blurRadius: 5.sp,
            offset: Offset(0.sp, 2.sp),
          ),
        ],
      ),
      child: Padding(
        padding:
            EdgeInsets.only(left: 8.sp, right: 8.sp, top: 10.sp, bottom: 10.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100.sp,
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const Certificates()));

                  getFDLienList(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: AppColors.onPrimary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1.sp),
                            spreadRadius: 2.sp,
                            blurRadius: 7.sp,
                            offset: Offset(0.sp, 3.sp),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Icon(
                          Icons.view_cozy_rounded,
                          color: AppColors.appBlueC,
                          size: 30.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6.sp,
                    ),
                    Text(titel1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10.sp)),
                    Text("",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10.sp)),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 100.sp,
              child: InkWell(
                onTap: () async {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const Certificates()));

                  bool val = await Utils.netWorkCheck(context);

                  if (val == false) {
                    return;
                  }

                  if (MyAccountList.childModelsFDList.isEmpty &&
                      MyAccountList.childModelsRDList.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertBox(
                          title: "Alert",
                          description: "No FD and RD Data Available.....",
                        );
                      },
                    );

                    return;
                  }

                  Navigator.push(context,
                      MaterialPageRoute(builder: (contex) => const FDRDView()));

                  //context.push('/FDRDView');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: AppColors.onPrimary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1.sp),
                            spreadRadius: 2.sp,
                            blurRadius: 7.sp,
                            offset: Offset(0.sp, 3.sp),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Icon(
                          Icons.receipt,
                          color: AppColors.appBlueC,
                          size: 30.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6.sp,
                    ),
                    Text(titel2,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10.sp)),
                    Text(subtitle1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10.sp)),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 100.sp,
              child: InkWell(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => Chequemenu()));

                  getIntrestRate(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: AppColors.onPrimary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1.sp),
                            spreadRadius: 2.sp,
                            blurRadius: 7.sp,
                            offset: Offset(0.sp, 3.sp),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Icon(
                          Icons.receipt_long_sharp,
                          color: AppColors.appBlueC,
                          size: 30.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6.sp,
                    ),
                    Text(titel3,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10.sp)),
                    Text(subtitle2,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10.sp)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getIntrestRate(BuildContext context) async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      // String apiUrl =
      //     "$protocol$ip$port/rest/AccountService/getonlineintrestrate";

      String apiUrl = ApiConfig.getonlineintrestrate;
      String customerId = context.read<SessionProvider>().get('customerId');

      String jsonString = jsonEncode({
        "custID": customerId,
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
          if (response.body != "") {
            var data = jsonDecode(response.body);

            if (data["Result"].toString().toLowerCase() == "success") {
              var res = jsonDecode(data["Data"]);

              for (int i = 0; i < res.length; i++) {
                InterestRate vObject = InterestRate();

                var getList = res[i];

                vObject.fdintRoiii = getList["fdintroi"].toString();
                vObject.fdprdLdaysss = getList["fdprdlprd"].toString();
                vObject.fdprdUdaysss = getList["fdprduprd"].toString();

                intrestList.add(vObject);
              }

              IntRateList.intListShow = intrestList;

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FDInterestRate()));

              //context.push("/fdinterestrate");

              Loader.hide();
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
              description: "Unable To connect Server",
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
            description: "Unable To connect Server",
          );
        },
      );
      return;
    }
  }

  Future<void> getFDLienList(BuildContext context) async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      // String apiUrl = "rest/AccountService/getlienFDData";

      String apiUrl = ApiConfig.getlienFDData;

      //       String userid = context.read<SessionProvider>().get('userid');
      // String tokenNo = context.read<SessionProvider>().get('tokenNo');
      // String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');
      String customerId = context.read<SessionProvider>().get('customerId');

      String jsonString = jsonEncode({
        "custid": customerId,
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
          if (response.body != null || response.body == "") {
            var res = jsonDecode(response.body);

            if (res["result"].toString().toLowerCase() == "success") {
              Loader.hide();

              var dataGet = jsonDecode(res["data"].toString());

              if (res["data"] == "[]") {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertBox(
                      title: "Alert",
                      description: "FD Lien Data Not Available",
                    );
                  },
                );

                return;
              }

              fdlien.clear();

              for (var item in dataGet) {
                LienData vObject = LienData();

                vObject.schcode = item["sch_code"].toString(); // scheme code
                vObject.accountnumber =
                    item["acc_no"].toString(); // scheme code
                vObject.fdnumber = item["fdno"].toString();
                // scheme code
                String fdiDate = item["fdi_date"].toString(); // scheme code

                DateTime fdidd = DateTime.parse(fdiDate);

                vObject.fddate = DateFormat('dd-MM-yyyy').format(fdidd);

                vObject.fdamount = item["fdiamount"].toString(); // scheme code
                String fdimdate = item["fdi_mdate"].toString(); // scheme code
                DateTime fdiMDate = DateTime.parse(fdimdate);

                vObject.fdmddate = DateFormat('dd-MM-yyyy').format(fdiMDate);

                vObject.fdmaturityamount =
                    item["fdimamount"].toString(); // scheme code
                // vObject.ROL = (string)bob["brn_brcod"];

                String lienlastdate = item["lien_mdate"].toString();
                DateTime lielastDate = DateTime.parse(lienlastdate);
                vObject.lienlastdate =
                    DateFormat("dd-MM-yyyy").format(lielastDate);

                // scheme code
                String lienenterydate = item["liencdate"].toString();
                DateTime lienenteryDate = DateTime.parse(lienenterydate);
                vObject.lienenterydate =
                    DateFormat("dd-MM-yyyy").format(lienenteryDate);

                // scheme code
                vObject.schemename =
                    item["sch_ename"].toString(); // scheme code
                vObject.fdistrnumber =
                    item["fdi_strsrno"].toString(); // scheme code
                vObject.accountname =
                    item["accename"].toString(); // scheme code
                vObject.accounholdername =
                    item["acchname"].toString(); // scheme code
                vObject.schemeholdername =
                    item["sch_hname"].toString(); // scheme code
                vObject.actname = item["act_ename"].toString(); // scheme code
                vObject.acthname = item["act_hname"].toString(); // scheme code
                vObject.fdinterestrate =
                    item["fdi_int"].toString(); // scheme code
                vObject.lienmark = item["lien_mark"].toString(); // scheme code
                vObject.loanaccountnumber =
                    item["loanaccno"].toString(); // scheme code
                vObject.loanholdername =
                    item["loanholder"].toString(); // scheme code
                vObject.loanhead = item["loanhead"].toString();

                fdlien.add(vObject);
              }

              SavaDataMore.fdlien = fdlien;

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FdLienData()));

              // context.push('/FdLienData');
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
          return AlertBox(
            title: "Alert",
            description: "Unable to Connect to the Server",
          );
        },
      );

      return;
    }
  }
}
