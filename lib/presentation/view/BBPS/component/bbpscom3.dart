import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/data/models/creditcardmodel.dart';
import 'package:hpscb/data/models/creditcardsavedata.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/LPG_Booking/LPG.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/creditcard/CreditCard.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/creditcard/showcreditcard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BbpsCom3 extends StatelessWidget {
  final String titel1;
  final String titel2;

  const BbpsCom3({
    super.key,
    required this.titel1,
    required this.titel2,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: TextScaler.linear(1.sp)),
        child: Container(
          width: size.width,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildOption(
                    context: context,
                    icon: Icons.propane_tank,
                    title: titel1,
                    onTap: () async {
                      bool isConnected = await Utils.netWorkCheck(context);
                      if (!isConnected) return;

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const LPG()));
                    },
                  ),
                  SizedBox(width: 1.sp),
                  _buildOption(
                    context: context,
                    icon: Icons.credit_card,
                    title: titel2,
                    onTap: () async {
                      bool isConnected = await Utils.netWorkCheck(context);
                      if (!isConnected) return;

                      await _fetchCreditCardData(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  /// 🟢 Extracted widget for code reusability
  Widget _buildOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 100.sp,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: AppColors.onPrimary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon, color: AppColors.appBlueC, size: 30.sp),
              ),
            ),
            SizedBox(height: 6.sp),
            Center(
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🟢 Fetch Credit Card Data & Navigate Accordingly
  Future<void> _fetchCreditCardData(BuildContext context) async {
    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    try {
      String apiUrl = ApiConfig.UserFetchCreditCardDetails;
      // String apiUrl = "${AppCongifP.apiurllinkBBPS}/rest/AccountService/UserFetchCreditCardDetails";

      String userid = context.read<SessionProvider>().get('userid');

      String jsonString = jsonEncode({"userid": userid});
      Map<String, String> headers = {"Content-Type": "application/json"};

      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonString,
        headers: headers,
      );

      Loader.hide(); // Hide loader after request

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['Result'] == "Success") {
          List<dynamic> dataList = jsonDecode(responseData['Data']);
          List<CREDITSVAEDATA> cardList = [];

          for (var listData in dataList) {
            cardList.add(CREDITSVAEDATA(
              CREDITCARDNUMBER: listData["crdrd_crdno"].toString(),
              BillerID: listData["crdr_billerid"].toString(),
              BANKNAME: listData["crdr_bnkname"].toString(),
              CustomerName: listData["crdrd_name"].toString(),
              CutomerMobileNumber: listData["crdrd_mobile"].toString(),
            ));
          }

          CreditCARD.CARDNUMBER = cardList;

          if (context.mounted) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ShowCreditCard()));
          }
        } else {
          if (context.mounted) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreditCard()));
          }
        }
      } else {
        debugPrint("API Error: ${response.statusCode}");
      }
    } catch (e) {
      Loader.hide();
      debugPrint("Exception: $e");
    }
  }
}
