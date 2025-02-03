// ignore_for_file: non_constant_identifier_names, unused_local_variable, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/config/constants.dart';
import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/models/loginmodel.dart';
import 'package:hpscb/data/models/toothermodel.dart';
import 'package:hpscb/data/models/withinbankquick.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/banktransfer/ToOtherBank/toothertransfer.dart';
import 'package:hpscb/presentation/view/dashboard/payments/tootherbank/IMPS/impscheck.dart';
import 'package:hpscb/presentation/view/dashboard/payments/tootherbank/NEFT&RTGS_Transfer/neft&rtgs.dart';
import 'package:hpscb/presentation/view/dashboard/payments/tootherbank/tootherbank.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class IMPS extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IMPSState();
}

class _IMPSState extends State<IMPS> {
  @override
  void initState() {
    // TODO: implement initState
    FetchSelfAccounts();
    super.initState();
  }

  var fromSelectedValue;
  Payee? benValueState;

  bool _isVisible = false;

  void _toggleVisibility(bool val) {
    setState(() {
      _isVisible = val;
    });
  }

  String fromvalue = "";
  String benValue = "";
  String amount = "";

  static List<AccountFetchModel> fromAccountList = <AccountFetchModel>[];
  static List<AccountFetchModel> accounts_list_for_transfer_new =
      <AccountFetchModel>[];

  var payee_imps_list = BenAdd.BenAddList;

  TextEditingController name = TextEditingController();
  TextEditingController namenic = TextEditingController();
  TextEditingController accno = TextEditingController();
  TextEditingController amunt = TextEditingController();
  TextEditingController ifsccode = TextEditingController();
  TextEditingController remark = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        if (SaveGlobalTitleIMNFRT.title == "IMPS Transfer") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Dashboard()));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NEFTRTGS()));
        }

        return false;
      },
      child: Builder(builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.1)),
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  SaveGlobalTitleIMNFRT.title,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                backgroundColor: const Color(0xFF0057C2),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: InkWell(
                      onTap: () {
                        if (SaveGlobalTitleIMNFRT.title == "IMPS Transfer") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Dashboard()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NEFTRTGS()));
                        }
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
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0),
                    child: Container(
                        width: size.width,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 10.0),
                                child: Text(
                                  "Select From Account Number",
                                  style: TextStyle(
                                      color: Color(0xFF0057C2),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 8.0, right: 8.0),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      dropdownColor: AppColors.onPrimary,
                                      value: fromSelectedValue,
                                      hint: const Text(
                                        'From Account Number',
                                        style: TextStyle(
                                          color: Color(0xFF898989),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      icon: const Icon(Icons.arrow_drop_down),
                                      isExpanded: true,
                                      items: fromAccountList
                                          .map((AccountFetchModel obj) {
                                        return DropdownMenuItem<String>(
                                          value: obj.textValue,
                                          child: Builder(builder: (context) {
                                            return MediaQuery(
                                              data: MediaQuery.of(context)
                                                  .copyWith(
                                                      textScaler:
                                                          const TextScaler
                                                              .linear(1.1)),
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
                                          fromSelectedValue = newValue;
                                        });
                                        // Call your method here, similar to SelectedIndexChanged
                                        onFromAccount(newValue!);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: _isVisible,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0,
                                      bottom: 10.0,
                                      left: 10.0,
                                      right: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Available Balance : ",
                                          style: TextStyle(
                                              color: Color(0xFF0057C2),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                      Text(
                                        "\u{20B9} " + "${amount}",
                                        style: const TextStyle(
                                            color: Color(0xFF0057C2),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 5.0, left: 10.0),
                                child: Text(
                                  "Select Beneficiary",
                                  style: TextStyle(
                                      color: Color(0xFF0057C2),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 8.0, right: 8.0),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<Payee>(
                                      dropdownColor: AppColors.onPrimary,
                                      value: benValueState,
                                      hint: const Text(
                                        'Select Beneficiary',
                                        style: TextStyle(
                                          color: Color(0xFF898989),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      icon: const Icon(Icons.arrow_drop_down),
                                      isExpanded: true,
                                      items: payee_imps_list.map((Payee obj) {
                                        return DropdownMenuItem<Payee>(
                                          value: obj,
                                          child: Builder(builder: (context) {
                                            return MediaQuery(
                                              data: MediaQuery.of(context)
                                                  .copyWith(
                                                      textScaler:
                                                          const TextScaler
                                                              .linear(1.1)),
                                              child: Text(
                                                "${obj.nickName}",
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
                                          benValueState = newValue;
                                        });
                                        // Call your method here, similar to SelectedIndexChanged
                                        String? accNo = newValue?.accNo;
                                        String? accType = newValue?.accType;
                                        String? nickName = newValue?.nickName;
                                        String? payeeName = newValue?.payeeName;
                                        String? payeeType = newValue?.payeeType;
                                        String? mobileNo = newValue?.mobileNo;
                                        String? ifsCode = newValue?.ifsCode;
                                        String? kid = newValue?.kid;

                                        selectBeny(
                                            accNo,
                                            accType,
                                            nickName,
                                            payeeName,
                                            payeeType,
                                            mobileNo,
                                            ifsCode,
                                            kid);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 5.0, left: 10.0),
                                child: Text(
                                  "Name",
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
                                    controller: name,
                                    enabled: false,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Name',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 5.0, left: 10.0),
                                child: Text(
                                  "Nick Name",
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
                                    controller: namenic,
                                    enabled: false,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Nick Name',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 5.0, left: 10.0),
                                child: Text(
                                  "Account Number",
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
                                    controller: accno,
                                    enabled: false,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Account Number',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 5.0, left: 10.0),
                                child: Text(
                                  "IFSC Code",
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
                                    controller: ifsccode,
                                    enabled: false,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    decoration: const InputDecoration(
                                      hintText: 'Enter IFSC Code',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 5.0, left: 10.0),
                                child: Text(
                                  "Amount",
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
                                    controller: amunt,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Amount',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 5.0, left: 10.0),
                                child: Text(
                                  "Remark",
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
                                    controller: remark,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Remark',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await getOTP();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0,
                                      left: 10.0,
                                      right: 10.0,
                                      bottom: 10.0),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0057C2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "PROCEED",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]))),
              )),
        );
      }),
    );
  }

// Function Code...............................................

  // Select from account ..........................
  void onFromAccount(String item) {
    OnGeAvailableBalance(item);

    _toggleVisibility(true);

    setState(() {
      fromvalue = item;
    });
  }

// Add Beny. ...........
  void selectBeny(
      String? accNo,
      String? accType,
      String? nickName,
      String? payeeName,
      String? payeeType,
      String? mobileNo,
      String? ifsCode,
      String? kid) {
    name.text = payeeName.toString();
    namenic.text = nickName.toString();
    accno.text = accNo.toString();
    ifsccode.text = ifsCode.toString();

    // string beneficiaryAccNo = AccountNumber.Text;

    // string accNo = sfdd;

    // string Remarks = Remark.Text;

    // string beneficiaryname = PayeeName.Text;

// Pass data from this page.....................................................
// ToIMPSModel.name = name.text;
// ToIMPSModel.fromAC = fromvalue;
// ToIMPSModel.toAcAccount = benValue;
// ToIMPSModel.amountValue = amunt.text;

    setState(() {
      benValue = accNo.toString();
    });
  }

// API Code ..................................................................................

  // FROM Account API
  Future<void> FetchSelfAccounts() async {
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

        if (kDebugMode) {
          print(data);
        }

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

            vObject.textValue = config["accountNo"];
            vObject.dataValue = config["acckid"];
            vObject.customerName = config["customerName"];
            vObject.actEname = config["actEname"];
            vObject.accountType = "Saving Account";

            vObject.availbalance = config["clearBalance"];
            vObject.brancode = config["brancode"];
            vObject.brnEname = config["brnname"];

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

            vObject.textValue = config["accountNo"];
            vObject.dataValue = config["acckid"];
            vObject.customerName = config["customerName"].toString().trim();
            vObject.actEname = config["actEname"];
            vObject.accountType = "Current Account";
            vObject.availbalance = config["clearBalance"];
            vObject.brancode = config["brancode"];
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

            vObject.textValue = config["accountNo"];
            vObject.dataValue = config["acckid"];
            vObject.customerName = config["customerName"].toString().trim();
            vObject.actEname = config["actEname"];
            vObject.accountType = "CC Account";
            vObject.availbalance = config["clearBalance"];
            vObject.brancode = config["brancode"];
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

            vObject.textValue = config["accountNo"];
            vObject.dataValue = config["acckid"];
            vObject.customerName = config["customerName"];
            vObject.actEname = config["actEname"];
            vObject.accountType = "Fixed Deposit Account";
            vObject.availbalance = config["clearBalance"];
            vObject.brancode = config["brancode"];
            vObject.brnEname = config["brnname"];
            accounts_list.insert(all, vObject);
            //  accounts_list_for.Insert(Allacc, vObject);
            accounts_list_for_fd.insert(fd, vObject);
            all = all + 1;
            //  Allacc = Allacc + 1;
            fd = fd + 1;
          } else if (config["accountType"] == "E") {
            //var test[] = new AccountFetchModel();

            AccountFetchModel vObject = AccountFetchModel();

            vObject.textValue = config["accountNo"];
            vObject.dataValue = config["acckid"];
            vObject.customerName = config["customerName"];
            vObject.actEname = config["actEname"];
            vObject.accountType = "RD Account";
            vObject.availbalance = config["clearBalance"];
            vObject.brancode = config["brancode"];
            vObject.brnEname = config["brnname"];
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
            vObject.textValue = config["accountNo"];
            vObject.dataValue = config["acckid"];
            vObject.customerName = config["customerName"];
            vObject.actEname = config["actEname"];
            vObject.accountType = "Loan Account";
            vObject.availbalance = config["clearBalance"];
            vObject.brancode = config["brancode"];
            vObject.brnEname = config["brnname"];
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
        AppListData.Allacc = accounts_list_for;
        AppListData.Accloan = accounts_list_for_loan;
        AppListData.Sav = accounts_list_for_sav;
        AppListData.fd = accounts_list_for_fd;
        AppListData.rd = accounts_list_for_rd;
        AppListData.SavCA = accounts_list_for_SavCA;
        AppListData.SACACC = accounts_list_for_SACACC;
        AppListData.FDR = accounts_list_for_fdr;
        AppListData.fdclose = accounts_list_for_fd_close;
        AppListData.Fundtransfertransfer = accounts_list_for_INtraFund;

        setState(() {
          fromAccountList = AppListData.Fundtransfertransfer;
        });
      } else {
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

// FROM Account amount

  Future<void> OnGeAvailableBalance(String item) async {
    try {
      //   String? deviceId = await PlatformDeviceId.getDeviceId;

// Password Ency.
      // String md5Hash = Crypt().generateMd5("Bank@123");

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      // API endpoint URL

      //String apiUrl = "rest/AccountService/GetAccountBalance";

      String apiUrl = ApiConfig.getAccountBalance;

      String jsonString = jsonEncode({
        "AccNo": item,
      });

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

      // Convert data to JSON

      String encrypted =
          AESencryption.encryptString(jsonString, Constants.AESENCRYPTIONKEY);

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
          Loader.hide();
          Map<String, dynamic> responseData = jsonDecode(response.body);
          //var data = jsonDecode(response.body);
          // Map<String, dynamic> jsonData = jsonDecode(response.body);
          var a = jsonDecode(responseData["Data"].toString());
          var b = responseData["Result"].toString();
          setState(() {
            amount = a.toString();
          });
        } else {
          Loader.hide();

          await showDialog(
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
            },
          );
        }
      } catch (error) {
        Loader.hide();

        await showDialog(
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
          },
        );
      }
    } catch (e) {
      await showDialog(
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

  Future<void> getOTP() async {
    if (fromvalue == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Select From Account Number",
          );
        },
      );

      return;
    } else if (benValue == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Select Beneficiary",
          );
        },
      );

      return;
    } else if (name.text == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Payeename",
          );
        },
      );

      return;
    } else if (namenic.text == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Nickname",
          );
        },
      );

      return;
    } else if (accno.text == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Account no.",
          );
        },
      );

      return;
    } else if (ifsccode.text == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter IFSC Code",
          );
        },
      );

      return;
    } else if (ifsccode.text.contains("HPSC")) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Your IFSC Code is not applicable for IMPS..!",
          );
        },
      );

      return;
    } else if (amunt.text == "" || amunt.text == null) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Amount",
          );
        },
      );
      return;
    } else if (remark.text == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Remark",
          );
        },
      );
      return;
    }

// Pass data from this page.....................................................
    ToIMPSModel.name = name.text;
    ToIMPSModel.fromAC = fromvalue;
    ToIMPSModel.toAcAccount = benValue;
    ToIMPSModel.amountValue = amunt.text;
    ToIMPSModel.ifsccode = ifsccode.text;
    ToIMPSModel.remark = remark.text;

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ImpsCheck()));
  }
}
