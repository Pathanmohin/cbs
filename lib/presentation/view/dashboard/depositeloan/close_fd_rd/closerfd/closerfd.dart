// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/close_fd_rd/closerfd/finalpageclosefd/finalcloserfd.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/close_fd_rd/model/fdrdclosermodel.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/close_fd_rd/saveFdRD/savefdrd.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CloserFD extends StatefulWidget {
  const CloserFD({super.key});
  @override
  State<StatefulWidget> createState() => _CloserFDState();
}

class _CloserFDState extends State<CloserFD> {
  AccountFetchModel? toFdValue;

  List<FatchFDCluserDetails> ll = <FatchFDCluserDetails>[];

  List<AccountFetchModel> listFD = <AccountFetchModel>[];

  String fetchRoi = "";

  bool showList = false;

  String accNumber = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    if (listFD.isEmpty) {
      listFD = AppListData.fd;
      setState(() {});
    }

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "FD Closer Details",
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
                    // context.go('/dashboard');
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
          body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Text(
                    "Select FD Account",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          CustomImages.closefd,
                          height: 32,
                          width: 32,
                        ),
//-----------------------------------------------------------------------------------
                        const SizedBox(
                            width:
                                10), // Add some space between the icon and the dropdown

                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<AccountFetchModel>(
                              dropdownColor: AppColors.onPrimary,
                              value: toFdValue,
                              hint: const Text(
                                'Select FD Account',
                                style: TextStyle(
                                  color: Color(0xFF898989),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              isExpanded: true,
                              items: listFD.map((AccountFetchModel obj) {
                                return DropdownMenuItem<AccountFetchModel>(
                                  value: obj,
                                  child: Builder(builder: (context) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          textScaler:
                                              const TextScaler.linear(1.1)),
                                      child: Text(
                                        "${obj.textValue}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  toFdValue = newValue;
                                });
                                // Call your method here, similar to SelectedIndexChanged
                                selectFDAccount(newValue!);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
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
                Visibility(
                  visible: showList,
                  child: Expanded(
                      child: ListView.builder(
                    itemCount: ll.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 10.0, bottom: 5.0),
                        child: Container(
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 20.0, right: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "FD Interest:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(ll[index].fdiint.toString())
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "FD STR No.:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(ll[index].fdistrsrno.toString())
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "FD Date:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(ll[index].fdidate.toString())
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "FD Maturity Date:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(ll[index].fdimdate.toString())
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "FD Number:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(ll[index].fdinumber.toString())
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "FD Series:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(ll[index].fdiseries.toString())
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
//-----------------------------------------------------------------------------------
//
                                    bool val =
                                        await Utils.netWorkCheck(context);

                                    if (val == false) {
                                      return;
                                    }

                                    if (accNumber == "") {
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertBox(
                                            title: "Alert",
                                            description:
                                                "Please Select FD Account",
                                          );
                                        },
                                      );
                                      return;
                                    }

                                    fetchRoi = ll[index].fdistrsrno.toString();

                                    SaveSelectAccountDetails.roiSelect =
                                        fetchRoi;

                                    selectListTap();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0,
                                        left: 10.0,
                                        right: 10.0,
                                        bottom: 10.0),
                                    child: Container(
                                      height: 55,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF0057C2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Add some spacing between the icon and the text

                                            Text(
                                              "Select",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      );
                    },
                  )),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('MMMM-dd, yyyy');
    String formattedDate = formatter.format(dateTime);

    return formattedDate;
  }

  Future<void> selectListTap() async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
//-----------------------------------------------------------------------------------
      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      // String apiUrl = "rest/AccountService/preclosurefd";

      String apiUrl = ApiConfig.preclosurefd;

      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

      //String accountNo = context.read<SessionProvider>().get('accountNo');
      //String sessionId = context.read<SessionProvider>().get('sessionId');

      String jsonString = jsonEncode({
        "accountno": accNumber,
        "requestype": "c",
        "fdisrsrno": fetchRoi,
        "savaccountno": "0"
      });

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "tokenNo": tokenNo,
        "userID": userid,
      };

      String encrypted = AESencryption.encryptString(jsonString, ibUsrKid);

      final parameters = <String, dynamic>{
        "data": encrypted,
      };

      // Make POST request

      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      try {
        if (response.statusCode == 200) {
          if (response.body != "") {
            var getData = response.body.toString();

            String deEncrypted = AESencryption.decryptString(getData, ibUsrKid);

            if (kDebugMode) {
              print(deEncrypted);
            }

            var res = jsonDecode(deEncrypted);

            if (res["Result"].toString().toLowerCase() == "success") {
              List<FatchFDDeatlsforClouser> trends =
                  <FatchFDDeatlsforClouser>[];

              var data = jsonDecode(res["Data"]);

              FatchFDDeatlsforClouser vObject = FatchFDDeatlsforClouser();

              vObject.roii = data["NeAmtPayble"];

              vObject.principalAmountt = data["PrincipalAmount"].toString();
              vObject.originalMaurityValuee = data["EffectiveRoi"].toString();
              vObject.totalIntAmtt = data["OriginalMaturityvalue"].toString();

              vObject.intAlreadyPaidd = data["RestIntPayable"].toString();

              vObject.restIntPayablee = data["IntAlreadyPaid"].toString();

              vObject.tdsForPreFyy = data["sYear"].toString();
              vObject.tdsForThisFyy = data["sMonth"].toString();

              vObject.intOnTdsRecovv = data["sDay"].toString();

              vObject.parkedTdsAmountt = data["tdsForPRE"].toString();

              vObject.intOnParkedTdsAmttt = data["tdsForthis"].toString();

              vObject.netAmtPayablee = data["intOnTDSRecov"].toString();

              vObject.parkedDSAmounttt = data["parkedDSAmount"].toString();

              vObject.intonParkedTdsamtt = data["IntOnParkedTdsAmt"].toString();

              vObject.intToBePaidForHolidayyy =
                  data["IntToBEPaidForHoliday"].toString();
              vObject.totalIntAmttt = data["TotalIntAmt"].toString();

              SaveFDCloserListTap.ROIi = vObject.roii.toString();
              SaveFDCloserListTap.PrincipalAmountt =
                  vObject.principalAmountt.toString();

              SaveFDCloserListTap.OriginalMaurityValuee =
                  vObject.originalMaurityValuee.toString();

              SaveFDCloserListTap.TotalIntAmtt =
                  vObject.totalIntAmtt.toString();
              SaveFDCloserListTap.IntAlreadyPaidd =
                  vObject.intAlreadyPaidd.toString();

              SaveFDCloserListTap.RestIntPayablee =
                  vObject.restIntPayablee.toString();

              SaveFDCloserListTap.TDSForPreFYy =
                  vObject.tdsForPreFyy.toString();

              SaveFDCloserListTap.TDSforThisFYy =
                  vObject.tdsForThisFyy.toString();

              SaveFDCloserListTap.IntOnTDSRecovv =
                  vObject.intOnTdsRecovv.toString();

              SaveFDCloserListTap.ParkedTdsAmountt =
                  vObject.parkedTdsAmountt.toString();

              SaveFDCloserListTap.IntonParkedTDSamtt =
                  vObject.intOnParkedTdsAmttt.toString();

              SaveFDCloserListTap.NetAmtPayablee =
                  vObject.netAmtPayablee.toString();

              SaveFDCloserListTap.NetAmtPayableea =
                  vObject.parkedDSAmounttt.toString();

              SaveFDCloserListTap.NetAmtPayableeb =
                  vObject.intonParkedTdsamtt.toString();

              SaveFDCloserListTap.NetAmtPayableec =
                  vObject.intToBePaidForHolidayyy.toString();

              SaveFDCloserListTap.NetAmtPayableed =
                  vObject.totalIntAmttt.toString();

              FinalApiData.accNumber = accNumber;
              FinalApiData.serNum = fetchRoi;

              trends.add(vObject);

              Loader.hide();
//-----------------------------------------------------------------------------------
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FinalCloserFD()));

              // context.push('/closerfdfinal');
            } else {
              Loader.hide();

              var data = res["Data"];

              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: data.toString(),
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

  String convertDateFormat(String inputDate) {
    // Parse the input date string
    DateTime dateTime = DateTime.parse(inputDate);

    // Format the date as "yyyy-MM-dd"
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return formattedDate;
  }

  // ignore: non_constant_identifier_names
  Future<void> GetListFD(String accNo) async {
    try {
      // String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
//-----------------------------------------------------------------------------------
      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      //String apiUrl = "rest/AccountService/clsoefdrdetails";

      String apiUrl = ApiConfig.clsoefdrdetails;

      String jsonString = jsonEncode({
        "accountno": accNo,
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
            var res = jsonDecode(response.body);

            if (res["Result"].toString().toLowerCase() == "success") {
              showList = false;
              ll.clear();

              var data = jsonDecode(res["Data"]);

              for (int i = 0; i < data.length; i++) {
                var getList = data[i];

                FatchFDCluserDetails vObject = FatchFDCluserDetails();

                vObject.fdiint = getList["fdi_int"].toString().trim();
                vObject.fdistrsrno = getList["fdi_strsrno"].toString().trim();

                vObject.fdidate =
                    formatDate(getList["fdi_date"].toString().trim());

                vObject.fdimdate =
                    formatDate(getList["fdi_mdate"].toString().trim());
                vObject.fdinumber = getList["fdi_number"].toString().trim();

                vObject.fdiseries = getList["fdi_series"].toString().trim();

                ll.add(vObject);

                showList = true;

                setState(() {});
              }

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

  // ignore: non_constant_identifier_names
  void selectFDAccount(AccountFetchModel AccountFetchModel) {
    String accNo = AccountFetchModel.textValue.toString();

    //String roi = AccountFetchModel.

    accNumber = accNo;

    SaveSelectAccountDetails.accountNo = accNo;

    GetListFD(accNo);
  }
}
