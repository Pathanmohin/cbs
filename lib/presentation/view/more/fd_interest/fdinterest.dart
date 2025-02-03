import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fdrdmodel/model.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fdrfdatasave/datasave.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
class FDInterestRate extends StatefulWidget {
  const FDInterestRate({super.key});

  @override
  State<FDInterestRate> createState() => _FDInterestRateState();
}

class _FDInterestRateState extends State<FDInterestRate> {

  @override
  Widget build(BuildContext context) {
    final List<InterestRate> interestList = IntRateList.intListShow;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "FD Interest Rate",
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        backgroundColor: const Color(0xFF0057C2),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(CustomImages.rdnewimage),
                  const SizedBox(width: 5),
                  const Text(
                    "View Applicable Interest Rate",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF002E5B),
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.black26, thickness: 1),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Maturity Period",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Interest Rate",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.black26, thickness: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: interestList.length,
                  itemBuilder: (context, index) {
                    final rate = interestList[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${rate.fdprdLdaysss} Days to ${rate.fdprdUdaysss} Days",
                              ),
                              Text(
                                "${rate.fdintRoiii} %",
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        const Divider(color: Colors.black26, thickness: 1),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
