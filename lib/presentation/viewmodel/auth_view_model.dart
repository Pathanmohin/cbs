// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import 'package:hpscb/config/constants.dart';
import 'package:hpscb/data/models/loginmodel.dart';
import 'package:hpscb/data/repositories/auth_repository.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/logindatasave.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel with ChangeNotifier {
  
  final _myRepo = AuthRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginAPi(
      dynamic data, dynamic header, BuildContext context) async {
    // setLoading(true);

    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    _myRepo.loginApi(data, header, context).then((value) async {
      // setLoading(false);

      if(kDebugMode){
        print(value.toString());
      }

      Loader.hide();

        

        Map<String, dynamic> responseData = value;

        var getData = responseData["Data"];

        

        var data =
            AESencryption.decryptString(getData, Constants.AESENCRYPTIONKEY);

        print(data);

        Map<String, dynamic> map = jsonDecode(data);

        var myRootNode = Login.fromJson(map);

        if (myRootNode.authorise == "Y" && myRootNode.validUser == "Y") {
          String accountNo = myRootNode.accountNo.toString();
         AppInfoLogin.accountNo = accountNo;
         context.read<SessionProvider>().updateField('accountNo', accountNo);

          String branchCode = myRootNode.branchCode.toString();
          AppInfoLogin.BranchCode = branchCode;
          context.read<SessionProvider>().updateField('branchCode', branchCode);


          String lastLogin = myRootNode.lastlogin.toString();
          AppInfoLogin.lastLogin = lastLogin;
          context.read<SessionProvider>().updateField('lastLogin', lastLogin);


          String cusName = myRootNode.custName.toString();
          AppInfoLogin.cusName = cusName;
          context.read<SessionProvider>().updateField('cusName', cusName);


          String authorise = myRootNode.authorise.toString();
          AppInfoLogin.authorise = authorise;
          context.read<SessionProvider>().updateField('authorise', authorise);


          String userType = myRootNode.userType.toString();
          AppInfoLogin.userType = userType;
          context.read<SessionProvider>().updateField('userType', userType);


          String validUser = myRootNode.validUser.toString();
          AppInfoLogin.validUser = validUser;
          context.read<SessionProvider>().updateField('validUser', validUser);


          String customerId = myRootNode.customerId.toString();
          AppInfoLogin.customerId = customerId;
          context.read<SessionProvider>().updateField('customerId', customerId);


          String sessionId = myRootNode.sessionId.toString();
          AppInfoLogin.sessionId = sessionId;
          context.read<SessionProvider>().updateField('sessionId', sessionId);


          String mobileNo = myRootNode.mobileNo.toString();
          AppInfoLogin.mobileNo = mobileNo;
          context.read<SessionProvider>().updateField('mobileNo', mobileNo);


          String custRoll = myRootNode.custRoll.toString();
          AppInfoLogin.custRoll = custRoll;
          context.read<SessionProvider>().updateField('custRoll', custRoll);


          String ifsc = myRootNode.ifsc.toString();
          AppInfoLogin.ifsc = ifsc;
          context.read<SessionProvider>().updateField('ifsc', ifsc);


          String branchName = myRootNode.branchName.toString();
          AppInfoLogin.branchName = branchName;
          context.read<SessionProvider>().updateField('branchName', branchName);


          String sibusrFor = myRootNode.sibusrFor.toString();
          AppInfoLogin.sibusrFor = sibusrFor;
          context.read<SessionProvider>().updateField('sibusrFor', sibusrFor);


          String tokenNo = myRootNode.tokenNo.toString();
          AppInfoLogin.tokenNo = tokenNo;
          context.read<SessionProvider>().updateField('tokenNo', tokenNo);


          String ibUsrKid = myRootNode.ibUsrKid.toString();
          AppInfoLogin.ibUsrKid = ibUsrKid;
          context.read<SessionProvider>().updateField('ibUsrKid', ibUsrKid);


          String brnemail = myRootNode.brnemail.toString();
          AppInfoLogin.brnemail = brnemail;
          context.read<SessionProvider>().updateField('brnemail', brnemail);


          String custemail = myRootNode.custemail.toString();
          AppInfoLogin.custemail = custemail;
          context.read<SessionProvider>().updateField('custemail', custemail);


          String errorMsg = myRootNode.errorMsg.toString();
          AppInfoLogin.errorMsg = errorMsg;
          context.read<SessionProvider>().updateField('errorMsg', errorMsg);


          String otpget = myRootNode.otp.toString();
          AppInfoLogin.Otp = otpget;
          context.read<SessionProvider>().updateField('otpget', otpget);

          String responseCode = myRootNode.responseCode.toString();
          AppInfoLogin.responseCode = responseCode;
          context.read<SessionProvider>().updateField('responseCode', responseCode);


          String userid = myRootNode.userid.toString();
          AppInfoLogin.Userid = userid;
          context.read<SessionProvider>().updateField('userid', userid);

          String secondusermob = myRootNode.secondusermob.toString();
          AppInfoLogin.secondusermob = secondusermob;
          context.read<SessionProvider>().updateField('secondusermob', secondusermob);


          String branchIFSC = myRootNode.branchIFSC.toString();
          AppInfoLogin.branchIFSC = branchIFSC;
          context.read<SessionProvider>().updateField('branchIFSC', branchIFSC);

          Loader.hide();

          String namebanner = "Bannername";

           final prefs = await SharedPreferences.getInstance();
           prefs.setString("namebanner", namebanner);
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => DashboardPage()));

   
         // context.go('/dashboard');

         Navigator.push(context, MaterialPageRoute(builder: (context) => const Dashboard()));


        } else if (myRootNode.errorMsg == "") {
          await showDialog(
     
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: "Alert",
                description:
                    "The password you entered is incorrect,Please try again.",
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
                description: myRootNode.errorMsg.toString(),
              );
            },
          );
          return;
        }
     
    }).onError((error, stackTrace) async {
      //  setLoading(false);

      Loader.hide();
      if (kDebugMode) {
        print(error.toString());
        // await showDialog(
        //   // ignore: use_build_context_synchronously
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertBox(
        //       title: "Alert",
        //       description: error.toString(),
        //     );
        //   },
        // );
      }
    });
  }
}
