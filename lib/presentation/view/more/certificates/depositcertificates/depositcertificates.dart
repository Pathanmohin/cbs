// ignore_for_file: unused_local_variable, non_constant_identifier_names, use_build_context_synchronously, unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/view/more/certificates/certificates.dart';
import 'package:hpscb/presentation/view/more/certificates/depositcertificates/depositfinal/depositefinal.dart';
import 'package:hpscb/presentation/view/more/certificates/model/datamodel.dart';
import 'package:hpscb/presentation/view/more/certificates/savedata/savecertificatedata.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DepositCertificate extends StatefulWidget {
  const DepositCertificate({super.key});

  @override
  State<DepositCertificate> createState() => _DepositCertificateState();
}

class _DepositCertificateState extends State<DepositCertificate> {
  AccountFetchModel? toFdValue;
  String? finYear;

  List<AccountFetchModel> listLoanAcc = <AccountFetchModel>[];

  // ignore: prefer_final_fields
  TextEditingController _cusID = TextEditingController();

  int currentYear = DateTime.now().year;
  List<String> yearRanges = [];

  //Account and year

  String? acc;
  String? year;

  var totalIntrest = 0.0;

  List<InterestModel> getlist = [];

  @override
  void initState() {
    super.initState();

    getAccountList();

    yearRanges = getYearRanges(currentYear, 6);

    _cusID.text = context.read<SessionProvider>().get('customerId');
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: WillPopScope(
          onWillPop: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Certificates()));
            return true;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Interest Certificate for Deposit",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              backgroundColor: const Color(0xFF0057C2),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()));
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
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
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
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "Customer ID",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, right: 8.0),
                        child: SizedBox(
                          height: 52,
                          child: TextField(
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            controller: _cusID,
                            readOnly: true,
                            decoration: const InputDecoration(
                              hintText: 'Enter Customer ID',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "Account Number",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
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
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<AccountFetchModel>(
                                    dropdownColor: AppColors.onPrimary,
                                    value: toFdValue,
                                    hint: const Text(
                                      'Select Account Number',
                                      style: TextStyle(
                                        color: Color(0xFF898989),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    icon: const Icon(Icons.arrow_drop_down),
                                    isExpanded: true,
                                    items: listLoanAcc
                                        .map((AccountFetchModel obj) {
                                      return DropdownMenuItem<
                                          AccountFetchModel>(
                                        value: obj,
                                        child: Builder(builder: (context) {
                                          return MediaQuery(
                                            data: MediaQuery.of(context)
                                                .copyWith(
                                                    textScaler:
                                                        const TextScaler.linear(
                                                            1.1)),
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
                                      selectAccount(newValue!);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 20.0),
                        child: Text(
                          "Financial Year",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
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
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String?>(
                                    dropdownColor: AppColors.onPrimary,
                                    value: finYear,
                                    hint: const Text(
                                      'Select Financial Year',
                                      style: TextStyle(
                                        color: Color(0xFF898989),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    icon: const Icon(Icons.arrow_drop_down),
                                    isExpanded: true,
                                    items: yearRanges.map((String? year) {
                                      return DropdownMenuItem<String?>(
                                        value: year,
                                        child: Builder(builder: (context) {
                                          return MediaQuery(
                                            data: MediaQuery.of(context)
                                                .copyWith(
                                                    textScaler:
                                                        const TextScaler.linear(
                                                            1.1)),
                                            child: Text(
                                              "$year",
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
                                        finYear = newValue;
                                      });
                                      // Call your method here, similar to SelectedIndexChanged
                                      selectYearAccount(newValue!);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          bool val = await Utils.netWorkCheck(context);

                          if (val == false) {
                            return;
                          }
                          CertificateDataSave.acc = acc.toString();
                          CertificateDataSave.finyear = finYear.toString();

                          getListShow(acc.toString(), finYear.toString());

                          //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  const DepositeFinal() ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 10.0, right: 10.0, bottom: 15.0),
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
                                  // Add some spacing between the icon and the text

                                  Image.asset(CustomImages.dsviewmore),

                                  const SizedBox(width: 10),

                                  const Text(
                                    "View",
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  List<String> getYearRanges(int currentYear, int numberOfRanges) {
    List<String> ranges = [];

    for (int i = 1; i < numberOfRanges; i++) {
      int startYear = currentYear - (numberOfRanges - i);
      int endYear = startYear + 1;
      ranges.add('$startYear-$endYear');
    }
    return ranges;
  }

//year
  void selectYearAccount(String year) {
    year = year;
  }

  void selectAccount(AccountFetchModel AccountFetchModel) {
    acc = AccountFetchModel.textValue.toString();
  }

  void getAccountList() {
    List<AccountFetchModel> vListSaving = [];
    List<AccountFetchModel> vListCurrent = [];
    int saving = 0;
    int current = 0;
    int fd = 0;
    int rd = 0;

    String Data = AccountListData.accListData;

    Map<String, dynamic> map = jsonDecode(Data);

    List<dynamic> listData = map["accountInformation"];

    for (int i = 0; i < listData.length; i++) {
      var config = listData[i];

      if (config["accountType"] == "S") {
        var vObject = AccountFetchModel();

        vObject.textValue = config["accountNo"];
        vListSaving.insert(saving, vObject);
        //accounts_list.Insert(from, vObject);
        // saving = saving + 1;
        //string svaing = vListSaving.ToString();

        //fAcc.ItemsSource = vListSaving;

        //vListSaving.Add((string)config["accountNo"]);
      } else if (config["accountType"] == "F") {
        //var test[] = new AccountFetchModel();

        var vObject = AccountFetchModel();

        vObject.textValue = config["accountNo"];
        //vListSaving.Add((string)config["accountNo"]);
        // vObject.DataValue = "Fixed Deposit Account";
        vListSaving.insert(fd, vObject);
      } else if (config["accountType"] == "E") {
        //var test[] = new AccountFetchModel();
        var vObject = AccountFetchModel();
        vObject.textValue = config["accountNo"];
        //  vObject.DataValue = "RD Account";
        //vListSaving.Add((string)config["accountNo"]);
        vListSaving.insert(rd, vObject);
      }
    }

    listLoanAcc = vListSaving;
  }

  Future<void> getListShow(String accNum, yearFin) async {


      var fin = yearFin.split("-");
      if (fin[0] == "null") {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertBox(
              title: "Alert",
              description: "Please Select Financial Year",
            );
          },
        );
        return;
      }

      String startdatepicker = fin[0] + "/" + "04/01";
      String dateeeee = fin[1] + "/" + "03/31";

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

    try {


      // String apiUrl ="rest/AccountService/getDepositeCertificate";

      String apiUrl = ApiConfig.getDepositeCertificate;

      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

      String accountNo = context.read<SessionProvider>().get('accountNo');
      String sessionId = context.read<SessionProvider>().get('sessionId');
      String branchCode = context.read<SessionProvider>().get('branchCode');
      String customerId = context.read<SessionProvider>().get('customerId');
      String ACCNO = acc.toString();
      if (accNum == "null") {
        ACCNO = "";
      } else {
        ACCNO = accNum.toString();
      }

      String jsonString = jsonEncode({
        "acc": ACCNO,
        "formdate": startdatepicker,
        "custid": customerId,
        "todate": dateeeee
      });

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "tokenNo": tokenNo,
        "userID": userid,
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonString,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      try {
        if (response.statusCode == 200) {
          if (response.body != null || response.body != "") {
            var res = jsonDecode(response.body);

            if (kDebugMode) {
              print(res);
            }

            if (res["Result"].toString().toLowerCase() == "success") {
              getlist.clear();
              totalIntrest = 0.0;

              var data = jsonDecode(res["Data"]);

              for (var getData in data) {
                InterestModel vObject = InterestModel();

                vObject.accnoo = getData["accno"];
                vObject.tdsdeducted = getData["tds_deducted"].toString();
                // vObject.ROL = (string)bob["brn_brcod"];
                vObject.interestpaid = getData["interest_paid"].toString();

                totalIntrest = totalIntrest + getData["interest_paid"];

                // totalint.Text = vObject.interestt;
                String tdsdetdatee = getData["tdsdetdate"].toString();

                DateTime date = DateTime.parse(tdsdetdatee);

                vObject.tdsdetdatee = DateFormat("dd-MM-yyyy").format(date);

                getlist.add(vObject);
              }

              Loader.hide();

              CertificateDataSave.getlist = getlist;
              CertificateDataSave.totalIntrest = totalIntrest.toString();
              CertificateDataSave.acc = ACCNO;
              CertificateDataSave.toDate = dateeeee;
              CertificateDataSave.endDate = startdatepicker;

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DepositeFinal()));

              //context.push('/DepositeFinal');
            } else if (res["Result"].toString().toLowerCase() == "failure") {
              Loader.hide();
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: res["Message"].toString(),
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
