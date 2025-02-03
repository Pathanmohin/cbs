// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, use_build_context_synchronously, unused_local_variable, unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/banktransfer/ToOtherBank/confirmdeatilstoother.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/quicktransfer.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: unused_element
final _for = GlobalKey<FormState>();

class ToOtherBank extends StatefulWidget {
  const ToOtherBank({super.key});

  @override
  State<ToOtherBank> createState() => _ToOtherBankState();
}

class UpperCaseTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class _ToOtherBankState extends State<ToOtherBank> {
  var toSelectedValue;
  var fromSelectedValue;
  List<dynamic> countries = [];
  String? countryId;
  String amount = "";
  @override
  // void initState() {
  //   super.initState();

  //   countries.add({"id": 1, "label": "Mobile Number"});
  //   countries.add({"id": 2, "label": "Account Number"});
  // }
  void initState() {
    FetchSelfAccounts();
    super.initState();
  }

  bool showMobileField = false;
  bool showMobile = false;
  bool balance = false;

  final txtpayeename = TextEditingController();
  final txtnickname = TextEditingController();
  final txtamount = TextEditingController();

  final txtaccountnumber = TextEditingController();

  final txtremark = TextEditingController();
  final txtifsccode = TextEditingController();

  final List<AccountFetchModel> toAccountList = AppListData.Allacc;

  static List<AccountFetchModel> accounts_list_for_transfer_new =
      <AccountFetchModel>[];

  List<AccountFetchModel> fromAccountList = <AccountFetchModel>[];

  @override
  Widget build(BuildContext context) {
    //FetchSelfAccounts();

    var size = MediaQuery.of(context).size;
    String Message;

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "To Other Bank(Upto 25000)",
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickTransfer()),
                );

                //  context.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
            ),
            backgroundColor: const Color(0xFF0057C2),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
                  );

                  //context.go('/dashboard');
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Image.asset(
                    CustomImages.home,
                    width: 24.sp,
                    height: 24.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
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
                        "From Account",
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
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: AppColors.onPrimary,
                            value: fromSelectedValue,
                            hint: const Text(
                              'From Account',
                              style: TextStyle(
                                color: Color(0xFF898989),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            icon: const Icon(Icons.arrow_drop_down),
                            isExpanded: true,
                            items: fromAccountList.map((AccountFetchModel obj) {
                              return DropdownMenuItem<String>(
                                value: obj.textValue,
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
                                fromSelectedValue = newValue!;
                              });
                              // Call your method here, similar to SelectedIndexChanged
                              //onFromAccount(newValue);

                              onFromAccount(newValue!);
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: balance,
                            child: const Text(
                              "Available Balance",
                              style: TextStyle(
                                  color: Color(0xFF0057C2),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Visibility(
                            visible: balance,
                            child: Text(
                              "\u{20B9} $amount",
                              style: const TextStyle(
                                  color: Color(0xFF0057C2),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Visibility(
                      visible: true,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "Payee Name",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: true,
                      child: Padding(
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
                          child: TextFormField(
                            controller: txtpayeename,
                            decoration: const InputDecoration(
                              hintText: "Enter Payee Name",
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Visibility(
                      visible: true,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "Nick Name",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: true,
                      child: Padding(
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
                          child: TextFormField(
                            controller: txtnickname,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6)
                            ],
                            decoration: const InputDecoration(
                              hintText: " Enter Nick Name",
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Visibility(
                      visible: true,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          "Payee Account Number",
                          style: TextStyle(
                              color: Color(0xFF0057C2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: true,
                      child: Padding(
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
                          child: TextFormField(
                            controller: txtaccountnumber,
                            decoration: const InputDecoration(
                              hintText: " Enter Payee Account Number",
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        "Amount",
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
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: txtamount,
                          decoration: const InputDecoration(
                            hintText: "Enter Amount",
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        "IFSC Code",
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
                        child: TextFormField(
                          inputFormatters: <TextInputFormatter>[
                            UpperCaseTextInputFormatter(),
                          ],
                          controller: txtifsccode,
                          decoration: const InputDecoration(
                            hintText: "Enter IFSC Code",
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        "Remark",
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
                        child: TextFormField(
                          controller: txtremark,
                          decoration: const InputDecoration(
                            hintText: "Enter Remark",
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        bool val = await Utils.netWorkCheck(context);

                        if (val == false) {
                          return;
                        }
                        if (fromSelectedValue == null ||
                            fromSelectedValue == "") {
                          Message = "Please Select Account Number";
                          Dialgbox(Message);
                          return;
                        } else if (txtpayeename.text == null ||
                            txtpayeename.text == "") {
                          Message = " Please Enter Name";
                          Dialgbox(Message);
                          return;
                        } else if (txtnickname.text == null ||
                            txtnickname.text == "") {
                          Message = "Please Enter Nick Name";
                          Dialgbox(Message);
                          return;
                        } else if (txtaccountnumber.text == null ||
                            txtaccountnumber.text == "") {
                          Message = "Please Enter payee Account Number";
                          Dialgbox(Message);
                          return;
                        } else if (txtamount.text == null ||
                            txtamount.text == "") {
                          Message = "Please Enter Amount";
                          Dialgbox(Message);
                          return;
                        } else if (txtifsccode.text == null ||
                            txtifsccode.text == "") {
                          Message = "Please Enter IFSC Code";
                          Dialgbox(Message);
                          return;
                        } else if (txtremark.text == null ||
                            txtremark.text == "") {
                          Message = "Please Enter Remark";
                          Dialgbox(Message);
                          return;
                        } else if (txtamount.text != null ||
                            txtamount.text != "") {
                        var amt = double.parse(txtamount.text.toString());
                          if (amt > 25000) {
                            Message = "MaxiMum amount of Transfer Rs.25000";
                            Dialgbox(Message);
                            return;
                          }
                        }

                        final prefs = await SharedPreferences.getInstance();
                        String beneficiaryAccNo = txtaccountnumber.text;
                        String accNo = fromSelectedValue;
                        String transferAmt = txtamount.text;
                        String Remarks = txtremark.text;
                        String beneMobile = "Null";
                        String IFSCcode = txtifsccode.text;
                        String beneficiaryname = txtpayeename.text;
                        prefs.setString("beneficiaryAccNo", beneficiaryAccNo);
                        prefs.setString("transferAmt", transferAmt);
                        prefs.setString("Remarks", Remarks);
                        prefs.setString("beneMobile", beneMobile);
                        prefs.setString("accno", accNo);
                        prefs.setString("IFSCcode", IFSCcode);
                        prefs.setString("beneficiaryname", beneficiaryname);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConfirmDeatilsToOther()));

                        // context.push('/ConfirmDeatilsToOther');

                        //     tittle: MobileNo.toString(),
                        // Email: Email.toString(),
                        // PhoneNoFirst: First,
                        // PhoneNoSecond: Second
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                        child: Container(
                          height: 50.sp,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  void onFromAccount(var item) {
    // Handle the selection change
    // print('Selected value: $item');
    OnGeAvailableBalance(item);
    balance = true;
  }

  void Dialgbox(String MESSAGE) {
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
              content: Text(
                MESSAGE,
                style: const TextStyle(fontSize: 18),
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

// API Code............................................................

  Future<void> FetchSelfAccounts() async {
    // String apiUrl = "$protocol$ip$port/rest/AccountService/getFundTrfDebitAcc";

    String apiUrl = ApiConfig.getFundTrfDebitAcc;

    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

    // String branchCode = context.read<SessionProvider>().get('branchCode');
    String customerId = context.read<SessionProvider>().get('customerId');
    String accountNo = context.read<SessionProvider>().get('accountNo');

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

  Future<void> OnGeAvailableBalance(String item) async {
    try {
      // String apiUrl = "$protocol$ip$port/rest/AccountService/GetAccountBalance";

      String apiUrl = ApiConfig.getAccountBalance;

      String jsonString = jsonEncode({
        "AccNo": item,
      });

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
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
          //var data = jsonDecode(response.body);
          // Map<String, dynamic> jsonData = jsonDecode(response.body);
          var a = jsonDecode(responseData["Data"].toString());
          var b = responseData["Result"].toString();
          setState(() {
            amount = a.toString();
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
            },
          );
        }
      } catch (error) {
        // Loader.hide();

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
          },
        );
      }
    } catch (e) {
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
}
