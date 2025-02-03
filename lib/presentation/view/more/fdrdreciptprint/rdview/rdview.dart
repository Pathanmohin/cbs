import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/liendatamodel.dart';
import 'package:hpscb/data/models/moreline.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/view/more/fdrdreciptprint/compFDRDView/fdrdComp.dart';
import 'package:hpscb/presentation/view/more/moreoptions.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';

class RdView extends StatefulWidget {
  const RdView({super.key});

  @override
  State<RdView> createState() => _RdViewState();
}

class _RdViewState extends State<RdView> {
  @override
  Widget build(BuildContext context) {
    List<FdReceipt> dataShowList = SavaDataMore.rdListForView;
    var size = MediaQuery.of(context).size;

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        // ignore: deprecated_member_use
        child: WillPopScope(
          onWillPop: () async{

            Navigator.pop(context);

            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "RD Receipt",
                style: TextStyle(color: Colors.white,fontSize: 16.sp),
              ),
              backgroundColor: const Color(0xFF0057C2),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Dashboard()));
                     // context.go('/dashboard');

                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const MoreOptions()));
                        
                      },
                      child: Image.asset(
                      CustomImages.home,
                      width: 24.sp,
                      height: 24.sp,
                      color: Colors.white,
                    ),),
                ),
              ],
              iconTheme: const IconThemeData(
                color: Colors.white,
                //change your color here
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20.0),
                  child: Row(
                    children: [
                      Image.asset(CustomImages.rdnewimage),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text("RD Receipt View",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF002E5B),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Account Number",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text(SavaDataMore.accNoFDRe,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                  child: Center(
                      child: SizedBox(
                    width: size.width,
                    height: 2,
                    child: Center(
                        child: Container(
                      color: Colors.black26,
                    )),
                  )),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: dataShowList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FDRDViewComp(
                                title: 'Scheme Name:',
                                dec:
                                    dataShowList[index].schcode.toString().trim(),
                              ),
                              FDRDViewComp(
                                title: 'Serial No:',
                                dec: dataShowList[index]
                                    .fdistrsrno
                                    .toString()
                                    .trim(),
                              ),
                              FDRDViewComp(
                                title: 'Date:',
                                dec:
                                    dataShowList[index].fdidate.toString().trim(),
                              ),
                              FDRDViewComp(
                                title: 'Amount:',
                                dec: dataShowList[index]
                                    .fdiamount
                                    .toString()
                                    .trim(),
                              ),
                              FDRDViewComp(
                                title: 'Int. Paid Amt:',
                                dec: dataShowList[index]
                                    .fdiintpaid
                                    .toString()
                                    .trim(),
                              ),
                              FDRDViewComp(
                                title: 'Maturity Date:',
                                dec: dataShowList[index]
                                    .fdimdate
                                    .toString()
                                    .trim(),
                              ),
                              FDRDViewComp(
                                title: 'Interest:',
                                dec:
                                    "${dataShowList[index].fdiint.toString().trim()}%",
                              ),
                              FDRDViewComp(
                                title: 'Maturity Amount:',
                                dec: dataShowList[index]
                                    .fdimamount
                                    .toString()
                                    .trim(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
              ],
            ),
          ),
        ),
      );
    });
  }
}
