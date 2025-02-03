// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/repositories/dashboard_repository.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:provider/provider.dart';

class DashboardViewmodel with ChangeNotifier {
  final _myRepo = DashboardRepository();

    static List<AccountFetchModel> accounts_list_for_transfer_new = <AccountFetchModel>[];

  
  Future<void> fetchAccount(
      dynamic data, dynamic header, BuildContext context) async {
    // setLoading(true);

String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

    _myRepo.fetchAccountDashboard(data, header, context).then((value) async {
      

      if (kDebugMode) {
        print(value);
      }


        if (value != "") {

        //  Map<String, dynamic> responseData = jsonDecode(value);

          if (value["Result"] == "Success") {
            
            var a = value["Data"];

            var data = AESencryption.decryptString(a, ibUsrKid);

            AccountListData.accListData = data.toString();

            Map<String, dynamic> map = jsonDecode(data);

// Initialize lists of AccountFetchModel
            var accounts_list = <AccountFetchModel>[]; // all
            var accounts_list_for_fdr = <AccountFetchModel>[]; // all
            var accounts_list_for_transfer = <AccountFetchModel>[]; // s a c
            var accounts_list_for_transfer_to = <AccountFetchModel>[]; // s a c d t
            var accounts_list_for = <AccountFetchModel>[]; // s a c d t
            var accounts_list_for_loan = <AccountFetchModel>[];
            // s a c d t
            var accounts_list_for_sav = <AccountFetchModel>[];

            // s a c d t
            var accounts_list_for_fd = <AccountFetchModel>[]; // s a c d t
            var accounts_list_for_fd_close = <AccountFetchModel>[]; // s a c d t
            var accounts_list_for_rd_close = <AccountFetchModel>[]; // s a c d t
            var accounts_list_for_rd = <AccountFetchModel>[]; // s a c d t
            var accounts_list_for_SavCA = <AccountFetchModel>[]; // s a c d t
            var accounts_list_for_SACACC = <AccountFetchModel>[]; // s a c d t

            for (int i = 0; i < map.length; i++) {
              
              int all = 0;
              int from = 0;
              int to = 0;
              int Allacc = 0;
              int Accloan = 0;
              int Sav = 0;
              int fd = 0;
              int rd = 0;
              int SavCA = 0;
              int SACACC = 0;
              int FDR = 0;
              int fdclose = 0;
              int rdclose = 0;

              var res = map["accountInformation"];

              for (int i = 0; i < res.length; i++) {
                var config = res[i];

                if (config["accountType"] == "S") {
                  //var test[] = new AccountFetchModel();

                  AccountFetchModel vObject =  AccountFetchModel();

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
                  accounts_list_for_SACACC.insert(SACACC, vObject);
                  accounts_list_for_fd_close.insert(fdclose, vObject);

                  all = all + 1;
                  from = from + 1;
                  to = to + 1;
                  Allacc = Allacc + 1;
                  Sav = Sav + 1;
                  SavCA = SavCA + 1;
                  SACACC = SACACC + 1;
                  SACACC = fdclose + 1;
                } else if (config["accountType"] == "A") {
                  //var test[] = new AccountFetchModel();

                  AccountFetchModel vObject = new AccountFetchModel();

                  vObject.textValue = config["accountNo"];
                  vObject.dataValue = config["acckid"];
                  vObject.customerName =
                      config["customerName"].toString().trim();
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
                  accounts_list_for_SACACC.insert(SACACC, vObject);

                  all = all + 1;
                  from = from + 1;
                  to = to + 1;
                  Allacc = Allacc + 1;
                  SavCA = SavCA + 1;
                  SACACC = SACACC + 1;
                } else if (config["accountType"] == "C") {
                  //var test[] = new AccountFetchModel();

                  AccountFetchModel vObject =  AccountFetchModel();

                  vObject.textValue = config["accountNo"];
                  vObject.dataValue = config["acckid"];
                  vObject.customerName =
                      config["customerName"].toString().trim();
                  vObject.actEname = config["actEname"];
                  vObject.actkid = config["actkid"];
                  vObject.accountType = "CC Account";
                  vObject.availbalance = config["clearBalance"];
                  vObject.brancode = config["brancode"];
                  vObject.brnEname = config["brnname"].toString().trim();
                  if (vObject.actkid == "155") {
                    accounts_list_for_fd_close.insert(fdclose, vObject);
                    accounts_list_for_rd_close.insert(rdclose, vObject);
                    fdclose = fdclose + 1;
                    rdclose = rdclose + 1;
                  }

                  accounts_list.insert(all, vObject);
                  accounts_list_for_transfer.insert(from, vObject);
                  accounts_list_for_transfer_new.insert(from, vObject);
                  accounts_list_for_transfer_to.insert(to, vObject);
                  accounts_list_for.insert(
                      Allacc, vObject); // for transfer: in to Account List
                  accounts_list_for_SavCA.insert(SavCA, vObject);
                  accounts_list_for_SACACC.insert(SACACC, vObject);

                  all = all + 1;
                  from = from + 1;
                  to = to + 1;
                  Allacc = Allacc + 1;
                  SavCA = SavCA + 1;
                  SACACC = SACACC + 1;
                } else if (config["accountType"] == "F") {
                  //var test[] = new AccountFetchModel();

                  AccountFetchModel vObject =  AccountFetchModel();

                  vObject.textValue = config["accountNo"];
                  vObject.dataValue = config["acckid"];
                  vObject.customerName = config["customerName"];
                  vObject.actEname = config["actEname"];
                  vObject.accountType = "Fixed Deposit Account";
                  vObject.availbalance = config["clearBalance"];
                  vObject.brancode = config["brancode"];
                  vObject.brnEname = config["brnname"];
                  accounts_list.insert(all, vObject);
                  //  accounts_list_for.insert(Allacc, vObject);
                  accounts_list_for_fd.insert(fd, vObject);

                  all = all + 1;
                  //  Allacc = Allacc + 1;
                  fd = fd + 1;
                  if (config["fdiseries"] == "eTDR") {
                    vObject.textValue = config["accountNo"];
                    accounts_list_for_fdr.insert(FDR, vObject);

                    FDR = FDR + 1;
                  }
                } else if (config["accountType"] == "E") {
                  //var test[] = new AccountFetchModel();

                  AccountFetchModel vObject =  AccountFetchModel();

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
                  var vObject =  AccountFetchModel();
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
                  //  accounts_list_for_transfer.insert(from, vObject);

                  all = all + 1;
                  to = to + 1;
                  Accloan = Accloan + 1;
                  Allacc = Allacc + 1;
                  //  from = from + 1;
                }
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
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Alert',
                      style: TextStyle(fontSize: 16),
                    ),
                    content: Text(
                      value["Result"],
                      style: const TextStyle(fontSize: 16),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  );
                });
          }
        } else {
          await showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (BuildContext context) {
              return Builder(builder: (context) {
                return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: const TextScaler.linear(1.0)),
                    child: AlertBox(
                      title: "Alert",
                      description: "Connect to Server Failed....!",
                    ));
              });
            },
          );

          return;
        }



    }).onError((error, stackTrace) {
      Loader.hide();
       print(error.toString());
    });
  }
}
