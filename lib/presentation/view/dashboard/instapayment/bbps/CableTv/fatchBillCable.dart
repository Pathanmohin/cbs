import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/CableTv/cabletv.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/creditcard/SucessScreenCredit.dart';

import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';

class CableTVFatchBill extends StatefulWidget {
  const CableTVFatchBill({super.key});

  @override
  State<StatefulWidget> createState() => _CableTVFatchBill();
}

class _CableTVFatchBill extends State<CableTVFatchBill> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Fatch Bill",
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CABLETV()),
                );
                //   context.pop(context);

               // Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
            ),
            backgroundColor: const Color(0xFF0057C2),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 10.sp),
                child: Container(
                    width: 80.sp,
                    height: 45.sp,
                    decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.circular(100.0),
                        color: AppColors.appBlueC),
                    child: const Image(
                      image: AssetImage(CustomImages.bbpsconnect),
                    )),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  //width: size.width,
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, right: 8, left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('CONSUMER NAME', 'RONAK NYARIYA'),
                        _buildDetailRow('BILL DUE DATE', '9/10/2024'),
                        _buildDetailRow('BILL DATE', '21/9/2024'),
                        _buildDetailRow('AMOUNT', '₹1,765.61'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SuccessfullyCredit()));

                  // context.push('/SuccessfullyCabletv');
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
                        "PAY NOW",
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
      );
    });
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
