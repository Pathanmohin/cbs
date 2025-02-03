// ignore_for_file: non_constant_identifier_names, deprecated_member_use, unused_local_variable, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/dashboard/payments/withinbank/instabank/instadank.dart';
import 'package:hpscb/presentation/view/dashboard/payments/withinbank/selfaccount/selfaccount.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class WithIn extends StatefulWidget {
  const WithIn({super.key});

  @override
  State<StatefulWidget> createState() => _WithInState();
}

class _WithInState extends State<WithIn>
    with AutomaticKeepAliveClientMixin<WithIn> {
  static List<AccountFetchModel> accounts_list_for_transfer_new =
      <AccountFetchModel>[];
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    saftyTipssss();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final screenWidth = MediaQuery.of(context).size.width;

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title:  Text(
                "Within Bank",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Dashboard()),
                  );

                  // context.go('/dashboard');
                },
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              backgroundColor: const Color(0xFF0057C2),
              actions: [

              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Dashboard()));

                    //  context.pop(context);
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
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20.0),
                    child: Container(
                        width: size.width,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/bnkkk.png",
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 50,
                                    width: screenWidth * 0.70,
                                    color: const Color(0xFF0057C2),
                                    child: const Center(
                                        child: Text(
                                      "WITHIN BANK",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 20.0),
                              child: Center(
                                  child: SizedBox(
                                width: 350,
                                height: 2,
                                child: Center(
                                    child: Container(
                                  color: Colors.black26,
                                )),
                              )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: InkWell(
                                onTap: () async {
                                  bool val = await Utils.netWorkCheck(context);

                                  if (val == false) {
                                    return;
                                  }
                                  await FetchSelfAccounts();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/images/acctrn.png",
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    const Text(
                                      "SELF-ACCOUNT TRANSFER",
                                      style: TextStyle(
                                          color: Color(0xFF0057C2),
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: InkWell(
                                onTap: () async {
                                  Loader.show(context,
                                      progressIndicator:
                                          const CircularProgressIndicator());
                                  Loader.hide();
                                  // await Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => IntraFund()));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const IntraFund()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/images/intr.png",
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    const Text("INTRA BANK",
                                        style: TextStyle(
                                            color: Color(0xFF0057C2),
                                            fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<void> FetchSelfAccounts() async {
    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    //String? deviceId = await PlatformDeviceId.getDeviceId;

// Password Ency.

    // String md5Hash = Crypt().generateMd5(password);

    // API endpoint URL

    //String apiUrl = "rest/AccountService/getFundTrfDebitAcc";

    String apiUrl = ApiConfig.getFundTrfDebitAcc;

    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');
    String customerId = context.read<SessionProvider>().get('customerId');

    SelfFromAccountModel userInput = SelfFromAccountModel(
      custid: customerId,
    );

    String jsonString = jsonEncode(userInput.toJson());

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "tokenNo": tokenNo,
      "userID": userid,
    };

    // Convert data to JSON

    String encrypted = AESencryption.encryptString(jsonString, ibUsrKid);

    final parameters = <String, dynamic>{
      "data": encrypted,
    };

    try {
      // Make POST request
      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      // Check if request was successful
      if (response.statusCode == 200) {
        var data = AESencryption.decryptString(response.body, ibUsrKid);

        var js = jsonDecode(data);

        List<dynamic> jsonResponse = jsonDecode(data);

        //       List<AccountFetchModel> accounts =
        //           jsonResponse.map((account) => AccountFetchModel.fromJson(account)).toList();

// Initialize lists of AccountFetchModel
        var accounts_list = <AccountFetchModel>[]; // all
        var accounts_list_for_fdr = <AccountFetchModel>[]; // all
        var accounts_list_for_transfer = <AccountFetchModel>[]; // s a c
        var accounts_list_for_transfer_to = <AccountFetchModel>[]; // s a c d t
        var accounts_list_for = <AccountFetchModel>[]; // s a c d t
        var accounts_list_for_loan = <AccountFetchModel>[]; // s a c d t
        var accounts_list_for_sav = <AccountFetchModel>[]; // s a c d t
        var accounts_list_for_fd = <AccountFetchModel>[]; // s a c d t
        var accounts_list_for_fd_close = <AccountFetchModel>[]; // s a c d t
        var accounts_list_for_rd_close = <AccountFetchModel>[]; // s a c d t
        var accounts_list_for_rd = <AccountFetchModel>[]; // s a c d t
        var accounts_list_for_SavCA = <AccountFetchModel>[]; // s a c d t
        var accounts_list_for_SACACC = <AccountFetchModel>[]; // s a c d t
        var accounts_list_for_INtraFund = <AccountFetchModel>[]; //s a c d t

        int all = 0;
        int from = 0;
        int to = 0;
        int Allacc = 0;
        int Accloan = 0;
        int Sav = 0;
        int fd = 0;
        int rd = 0;
        int SavCA = 0;
        int intrafund = 0;

        for (var config in jsonResponse) {
          if (config["accountType"] == "S") {
            //var test[] = new AccountFetchModel();

            AccountFetchModel vObject = AccountFetchModel();

            vObject.textValue = config["accountNo"].toString().trim();
            vObject.dataValue = config["acckid"].toString().trim();
            vObject.customerName = config["customerName"].toString().trim();
            vObject.actEname = config["actEname"].toString().trim();
            vObject.accountType = "Saving Account";

            vObject.availbalance = config["clearBalance"].toString().trim();
            vObject.brancode = config["brancode"].toString().trim();
            vObject.brnEname = config["brnname"].toString().trim();

            accounts_list.insert(all, vObject);
            accounts_list_for_transfer.insert(from, vObject);
            accounts_list_for_transfer_new.insert(from, vObject);

            accounts_list_for_transfer_to.insert(to, vObject);
            accounts_list_for.insert(Allacc, vObject);
            accounts_list_for_sav.insert(Sav, vObject);
            accounts_list_for_SavCA.insert(SavCA, vObject);

            accounts_list_for_INtraFund.insert(intrafund, vObject);

            all = all + 1;
            from = from + 1;
            to = to + 1;
            Allacc = Allacc + 1;
            Sav = Sav + 1;
            SavCA = SavCA + 1;
            intrafund = intrafund + 1;
          } else if (config["accountType"] == "A") {
            //var test[] = new AccountFetchModel();

            AccountFetchModel vObject = AccountFetchModel();

            vObject.textValue = config["accountNo"].toString().trim();
            vObject.dataValue = config["acckid"].toString().trim();
            vObject.customerName = config["customerName"].toString().trim();
            vObject.actEname = config["actEname"].toString().trim();
            vObject.accountType = "Current Account";
            vObject.availbalance = config["clearBalance"].toString().trim();
            vObject.brancode = config["brancode"].toString().trim();
            vObject.brnEname = config["brnname"].toString().trim();
            accounts_list.insert(all, vObject);
            accounts_list_for_transfer.insert(from, vObject);
            accounts_list_for_transfer_new.insert(from, vObject);
            accounts_list_for_transfer_to.insert(to, vObject);
            accounts_list_for.insert(Allacc, vObject);
            accounts_list_for_SavCA.insert(SavCA, vObject);
            accounts_list_for_INtraFund.insert(intrafund, vObject);

            all = all + 1;
            from = from + 1;
            to = to + 1;
            Allacc = Allacc + 1;
            SavCA = SavCA + 1;
            intrafund = intrafund + 1;
          } else if (config["accountType"] == "C") {
            //var test[] = new AccountFetchModel();

            AccountFetchModel vObject = AccountFetchModel();

            vObject.textValue = config["accountNo"].toString().trim();
            vObject.dataValue = config["acckid"].toString().trim();
            vObject.customerName = config["customerName"].toString().trim();
            vObject.actEname = config["actEname"].toString().trim();
            vObject.accountType = "CC Account";
            vObject.availbalance = config["clearBalance"].toString().trim();
            vObject.brancode = config["brancode"].toString().trim();
            vObject.brnEname = config["brnname"].toString().trim();
            accounts_list.insert(all, vObject);
            accounts_list_for_transfer.insert(from, vObject);
            accounts_list_for_transfer_new.insert(from, vObject);
            accounts_list_for_transfer_to.insert(to, vObject);
            accounts_list_for.insert(
                Allacc, vObject); // for transfer: in to Account List
            accounts_list_for_SavCA.insert(SavCA, vObject);
            accounts_list_for_INtraFund.insert(intrafund, vObject);

            all = all + 1;
            from = from + 1;
            to = to + 1;
            Allacc = Allacc + 1;
            SavCA = SavCA + 1;
            intrafund = intrafund + 1;
          } else if (config["accountType"] == "F") {
            //var test[] = new AccountFetchModel();

            AccountFetchModel vObject = AccountFetchModel();

            vObject.textValue = config["accountNo"].toString().trim();
            vObject.dataValue = config["acckid"].toString().trim();
            vObject.customerName = config["customerName"].toString().trim();
            vObject.actEname = config["actEname"].toString().trim();
            vObject.accountType = "Fixed Deposit Account";
            vObject.availbalance = config["clearBalance"].toString().trim();
            vObject.brancode = config["brancode"].toString().trim();
            vObject.brnEname = config["brnname"].toString().trim();
            accounts_list.insert(all, vObject);
            //  accounts_list_for.Insert(Allacc, vObject);
            accounts_list_for_fd.insert(fd, vObject);
            all = all + 1;
            //  Allacc = Allacc + 1;
            fd = fd + 1;
          } else if (config["accountType"] == "E") {
            //var test[] = new AccountFetchModel();

            AccountFetchModel vObject = AccountFetchModel();

            vObject.textValue = config["accountNo"].toString().trim();
            vObject.dataValue = config["acckid"].toString().trim();
            vObject.customerName = config["customerName"].toString().trim();
            vObject.actEname = config["actEname"].toString().trim();
            vObject.accountType = "RD Account";
            vObject.availbalance = config["clearBalance"].toString().trim();
            vObject.brancode = config["brancode"].toString().trim();
            vObject.brnEname = config["brnname"].toString().trim();
            accounts_list.insert(all, vObject);
            accounts_list_for.insert(Allacc, vObject);
            accounts_list_for_rd.insert(rd, vObject);

            all = all + 1;
            Allacc = Allacc + 1;
            rd = rd + 1;
          } else if (config["accountType"] == "D" ||
              config["accountType"] == "T") {
            //var test[] = new AccountFetchModel();
            var vObject = AccountFetchModel();
            vObject.textValue = config["accountNo"].toString().trim();
            vObject.dataValue = config["acckid"].toString().trim();
            vObject.customerName = config["customerName"].toString().trim();
            vObject.actEname = config["actEname"].toString().trim();
            vObject.accountType = "Loan Account";
            vObject.availbalance = config["clearBalance"].toString().trim();
            vObject.brancode = config["brancode"].toString().trim();
            vObject.brnEname = config["brnname"].toString().trim();
            accounts_list.insert(all, vObject);
            accounts_list_for_transfer_to.insert(to, vObject);
            accounts_list_for_loan.insert(Accloan, vObject);
            accounts_list_for.insert(Allacc, vObject);
            //  accounts_list_for_transfer.Insert(from, vObject);

            all = all + 1;
            to = to + 1;
            Accloan = Accloan + 1;
            Allacc = Allacc + 1;
            //  from = from + 1;
          }
        }

// Get List

        AppListData.FromAccounts = accounts_list_for_transfer;
        AppListData.ToAccounts = accounts_list_for_transfer_to;
        AppListData.AllAccounts = accounts_list;

//AppListData.Allacc = accounts_list_for;

        AppListData.Accloan = accounts_list_for_loan;
        AppListData.Sav = accounts_list_for_sav;
        AppListData.fd = accounts_list_for_fd;
        AppListData.rd = accounts_list_for_rd;
        AppListData.SavCA = accounts_list_for_SavCA;
        AppListData.SACACC = accounts_list_for_SACACC;
        AppListData.FDR = accounts_list_for_fdr;
        AppListData.fdclose = accounts_list_for_fd_close;
        AppListData.Fundtransfertransfer = accounts_list_for_INtraFund;

        AppListData.fromAccountList.clear();
        AppListData.fromAccountList = AppListData.Fundtransfertransfer;

        Loader.hide();

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SelfTransfer()));
      } else {
        Loader.hide();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Builder(builder: (context) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.1)),
                  child: AlertDialog(
                    backgroundColor: AppColors.onPrimary,
                    title: const Text(
                      'Alert',
                      style: TextStyle(fontSize: 18),
                    ),
                    content: const Text(
                      "Server Failed....!",
                      style: TextStyle(fontSize: 18),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                );
              });
            });
      }
    } catch (error) {
      Loader.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Builder(builder: (context) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.1)),
              child: AlertDialog(
                backgroundColor: AppColors.onPrimary,
                title: const Text(
                  'Alert',
                  style: TextStyle(fontSize: 18),
                ),
                content: const Text(
                  "Unable to Connect to the Server",
                  style: TextStyle(fontSize: 18),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            );
          });
        },
      );
    }
  }

  // ---------------------- Vikas Method -------------

  Future<void> saftyTipssss() async {
    //Loader.show(context, progressIndicator: CircularProgressIndicator());

    // String apiUrl = "$protocol$ip$port/rest/AccountService/fetchSafetytips";

    String apiUrl = ApiConfig.fetchSafetytips;

    String jsonString = jsonEncode({
      "category": "Transaction",
    });

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
    };

    final parameters = <String, dynamic>{
      "data": jsonString,
    };

    try {
      // Make POST request
      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonString,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      // Check if request was successful
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        // Access the first item in the list and its safety_remark field
        var data = jsonDecode(responseData["Data"].toString());

        // Access the first item in the list and its safety_remark field
        var safetyRemark = data[0]["safety_remark"];
        var safetyKid = data[0]["safety_kid"];
        var safetyCategory = data[0]["safety_category"];

        // Show the response data in a popup
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: AppColors.onPrimary,
              title: const Text("Safety Information"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    ListTile(
                      leading: Image.asset(
                        'assets/images/logo1.png', // Replace with an appropriate AnyDesk logo
                        height: 40,
                      ),
                      title: const Text("HPSCB"),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Transaction Related Safety Tips:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      safetyRemark,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 17, color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        if (kDebugMode) {
          print('Failed to get response');
        }
      }
    } catch (error) {
      // Loader.hide();

      return;
    }
  }
}
