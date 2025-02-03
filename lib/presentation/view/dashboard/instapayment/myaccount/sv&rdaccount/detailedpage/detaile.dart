// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_final_fields, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/myaccountmodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/myaccount/sv&rdaccount/detailedpage/detailmodel.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/myaccount/sv&rdaccount/detailedpage/finalstatemnet/finalstatemnt.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});
  @override
  State<StatefulWidget> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

   List<FinalDetailsStatement> getListFinal = <FinalDetailsStatement>[];

  DateTime _selectedStartDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now();

  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();

  String outAvBal = "Available Balance";

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    if (DetailsModel.titleDetails == "CC Accounts" ||
        DetailsModel.titleDetails == "Loan Accounts") {
      outAvBal = "Outstanding Balance";
    } else {
      outAvBal = "Available Balance";
    }

    final today = DateFormat('dd-MM-yyyy').format(DateTime.now());
    _dateStartController.text = today;
    _dateEndController.text = today;
  }

  Future<void> _selectDate({
    required BuildContext context,
    required DateTime initialDate,
    required ValueChanged<DateTime> onDatePicked,
    required String errorMessage,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      
    );

    if (picked != null) {
      if ((onDatePicked == _updateStartDate && picked.isAfter(_selectedEndDate)) ||
          (onDatePicked == _updateEndDate && picked.isBefore(_selectedStartDate))) {
        _showAlertDialog(context, "Alert", errorMessage);
        return;
      }
      onDatePicked(picked);
    }
  }

  void _updateStartDate(DateTime date) {
    setState(() {
      _selectedStartDate = date;
      _dateStartController.text = DateFormat('dd-MM-yyyy').format(date);
    });
  }

  void _updateEndDate(DateTime date) {
    setState(() {
      _selectedEndDate = date;
      _dateEndController.text = DateFormat('dd-MM-yyyy').format(date);
    });
  }

  void _showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.onPrimary,
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20.0),
      child: Row(
        children: [
          Image.asset(
            "assets/images/saving_ac.png",
            color: const Color.fromARGB(255, 163, 17, 6),
          ),
          const SizedBox(width: 5),
          Text(
            DetailsModel.titleDetails,
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 163, 17, 6),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          TextField(
            readOnly: true,
            controller: controller,
            onTap: onTap,
            decoration: InputDecoration(
              labelText: label,
              suffixIcon: const Icon(Icons.calendar_today),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return InkWell(
      onTap: () {
        getStatement(); // Call the desired function here
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
                Image.asset("assets/images/next.png"),
                const SizedBox(width: 8),
                Text(
                  "Detail Statement",
                  style: const TextStyle(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: AppColors.onPrimary,
        appBar: AppBar(
          title: Text(
            DetailsModel.titleDetails,
            style: TextStyle(color: AppColors.onPrimary, fontSize: 16.sp),
          ),
          backgroundColor: AppColors.appBlueC,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Dashboard()));
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
        body: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            return false;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  _buildAccountInfo(
                      "Account Number", DetailsModel.accNumberDetails),
                  _buildAccountInfo(outAvBal, DetailsModel.accBalanceDetails),
                  const Divider(),
                  _buildDateField(
                    label: "Start Date",
                    controller: _dateStartController,
                    onTap: () => _selectDate(
                      context: context,
                      initialDate: _selectedStartDate,
                      onDatePicked: _updateStartDate,
                      errorMessage:
                          "Start Date must be less than or equal to End Date.",
                    ),
                  ),
                  _buildDateField(
                    label: "End Date",
                    controller: _dateEndController,
                    onTap: () => _selectDate(
                      context: context,
                      initialDate: _selectedEndDate,
                      onDatePicked: _updateEndDate,
                      errorMessage:
                          "End Date must be greater than or equal to Start Date.",
                    ),
                  ),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


   getStatement() async{
    DateTime startDate = _selectedStartDate;
    DateTime endDate = _selectedEndDate;

    if (startDate != null && endDate != null) {
      int monthsDifference = (endDate!.year - startDate!.year) * 12 +
          endDate!.month -
          startDate!.month;

      if (monthsDifference > 6){
      await  showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: AppColors.onPrimary,
            title: const Text(
              'Alert',
              style: TextStyle(fontSize: 18),
            ),
            content: const Text(
              'Please Generate Account Statement Upto 6 Month Only.',
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'OK',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        );

        return;
      }

      getListItem();
    }
  }

  Future<void> getListItem() async {
    String fromPickDate = convertDateString(_dateStartController.text);
    String toPickDate = convertDateString(_dateEndController.text);

    if (fromPickDate.isEmpty) {
      fromPickDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    }
    if (toPickDate.isEmpty) {
      toPickDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    }

    try {
      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      String sessionId = context.read<SessionProvider>().get('sessionId');

      // Get application properties (Replace these with actual implementations)
      String passbookAccount = DetailsModel.accNumberDetails;
      // Example account number

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      String apiUrl =
          "${ApiConfig.minidetails}getDetailStatementv3?accNo=$passbookAccount&fromDate=$fromPickDate&toDate=$toPickDate&sessionID=$sessionId&userID=$userid&tokenNo=$tokenNo";

      if (kDebugMode) {
        print(apiUrl);
      }

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

      var response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      try {
        if (response.statusCode == 200) {
          getListFinal.clear();

          var getdataList = jsonDecode(response.body);

          if (getdataList.length != 0) {
            for (int i = 0; i < getdataList.length; i++) {
              Map<String, dynamic> lastdata = getdataList[i];

              print(lastdata);

              FinalDetailsStatement details = FinalDetailsStatement();

              details.trdDate = lastdata["trddate"];

              if (lastdata["drcr"] == "D") {
                if (lastdata["description"] == "Opening Balance" ||
                    lastdata["description"] == "Closing Balance") {
                  details.trdamt = "- " + "\u{20B9}" + lastdata["curbalance"];
                } else {
                  details.trdamt = "- " + "\u{20B9}" + lastdata["trdamt"];
                }

                details.color = Color(0xFFFF0000);
              } else {
                if (lastdata["description"] == "Opening Balance" ||
                    lastdata["description"] == "Closing Balance") {
                  details.trdamt = "+ " + "\u{20B9}" + lastdata["curbalance"];
                } else {
                  details.trdamt = "+ " + "\u{20B9}" + lastdata["trdamt"];
                }

                details.color = Color(0xFF3DA625);
              }

              details.narration = lastdata["description"].toString();
              details.trAccID = lastdata["trAccID"].toString();
              details.curbalance = lastdata["curbalance"].toString();

              getListFinal.add(details);
            }

            Loader.hide();

            FinalStatementData.title = DetailsModel.titleDetails;
            FinalStatementData.accNo = DetailsModel.accNumberDetails;
            FinalStatementData.startDate = _dateStartController.text;
            FinalStatementData.endDate = _dateEndController.text;
            FinalStatementData.getListFinal = getListFinal;

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FinalStatement()));

            //  context.push('/finalsatement');
          } else {
            Loader.hide();
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertBox(
                  title: "Alert",
                  description: "No Data Avaliable",
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
              return Builder(builder: (context) {
                return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: const TextScaler.linear(1.0)),
                    child: AlertBox(
                      title: "Alert",
                      description: "Unable to Connect to the Server",
                    ));
              });
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

  String convertDateString(String dateStr) {
    // Correct the year part by taking the last 4 digits
    String correctedYear = dateStr.substring(0, dateStr.length);

    // Parse the corrected date string to a DateTime object
    DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(correctedYear);

    // Format the DateTime object to the desired format
    String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

    return formattedDate;
  }
}
