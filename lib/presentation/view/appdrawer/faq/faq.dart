// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:http/http.dart' as http;

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<StatefulWidget> createState() => faqstateon();
}

// ignore: camel_case_types
class faqstateon extends State<FAQ> {
  List<FAQq> faqs = [];
  bool isLoading = false;
  String Message = "";

  
  Future<bool> _onWillPop() async {


 Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Dashboard()),
                    );

    return false;
  }

  @override
  void initState() {
    super.initState();
    fetchDetailStatement();
    //  Provider.of<SessionTimeoutService>(context, listen: false).startSession();
  }

  @override
  Widget build(BuildContext context) {
    // final sessionTimeoutService = Provider.of<SessionTimeoutService>(context);

    // if (!sessionTimeoutService.isSessionActive) {
    //   // exit(0);
    //   // Navigator.of(context).pushReplacement(
    //   //   MaterialPageRoute(builder: (context) => LoginPage()),
    //   // );
    //   // Message = "Seesion Time Out";
    //   // SeesiontimeOut(Message);
    //   // Navigator.push(
    //   //     context, MaterialPageRoute(builder: (context) => LoginPage()));
    // }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Builder(
        builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.1)),
            child: Scaffold(
              backgroundColor: AppColors.onPrimary,
              appBar: AppBar(
                title: Text(
                  "FAQ",
                  style: TextStyle(color: Colors.white,fontSize: 16.sp),
                ),
                leading: IconButton(
                  onPressed: () {

                       Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Dashboard()),
                    );
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
                backgroundColor: const Color(0xFF0057C2),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                      onTap: () {
                           Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Dashboard()),
                    );
                      },
                      child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Image.asset(
                      "assets/images/dashlogo.png",
                      width: 24.sp,
                      height: 24.sp,
                      color: Colors.white,
                    ),
                  ),
                    ),
                  ),
                ],
              ),
              body: Container(
                color: AppColors.onPrimary,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        
                        children: faqs.map((faq) => FAQItem(faq: faq)).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Future<void> fetchDetailStatement() async {


    String apiUrl = ApiConfig.faq;

    String jsonString = jsonEncode({"Faq": "Faq"});

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
        var jsonResponse = json.decode(response.body);

        if (jsonResponse["Result"].toString() == "Success") {
          var response1 = jsonResponse['message'];
          List<dynamic> responseData = json.decode(response1);
          List<FAQq> trends =
              responseData.map((data) => FAQq.fromJson(data)).toList();

          setState(() {
            faqs = trends;
            isLoading = false;
          });
        } else {
          showMessageDialog(jsonResponse["Message"].toString());
          return;
        }
      } else {
        showMessageDialog(
            'Unable to connect to the server: ${response.statusCode}');
        return;
      }
    } catch (error) {
      showMessageDialog('Unable to connect to the server: $error');
      return;
    }
  }

  void showMessageDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.onPrimary,
          title: const Text(
            'Alert',
            style: TextStyle(fontSize: 18),
          ),
          content: Text(
            message,
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
        );
      },
    );
  }

  void SeesiontimeOut() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.onPrimary,
          title: const Text(
            'Alert',
            style: TextStyle(fontSize: 18),
          ),
          content: const Text(
            "alert",
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {

                 Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Dashboard()),
                    );
              },
              child: const Text(
                'OK',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }
}

class FAQItem extends StatefulWidget {
  final FAQq faq;

  FAQItem({required this.faq});

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.faq.isExpand;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.onPrimary,
      margin: const EdgeInsets.all(5),
      child: ExpansionTile(
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.faq.faqQue,
                style: const TextStyle(
                  fontFamily: 'MontserratMedium',
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            //Icon(_isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
          ],
        ),
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (bool expanding) =>
            setState(() => _isExpanded = expanding),
        children: [
          Container(
            color: AppColors.onPrimary,
            padding: const EdgeInsets.all(5),
            child: Text(
              widget.faq.faqAns,
              style: const TextStyle(
                fontFamily: 'MontserratRegular',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFF5B5D68),
            indent: 4,
            endIndent: 4,
          ),
        ],
      ),
    );
  }
}

class FAQq {
  String faqQue;
  String faqAns;
  bool isExpand;

  FAQq({required this.faqQue, required this.faqAns, this.isExpand = false});

  factory FAQq.fromJson(Map<String, dynamic> json) {
    return FAQq(
      faqQue: "Question: " + json['faq_que'],
      faqAns: "Answer: " + json['faq_ans'],
      isExpand: false,
    );
  }
}
