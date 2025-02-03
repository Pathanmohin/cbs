import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/liendatamodel.dart';
import 'package:hpscb/data/models/moreline.dart';

import 'package:hpscb/presentation/view/more/fdrdreciptprint/compFDRDView/fdrdComp.dart';

class FdLienData extends StatefulWidget {
  const FdLienData({super.key});

  @override
  State<StatefulWidget> createState() => _FdLienDataState();
}

class _FdLienDataState extends State<FdLienData> {
  @override
  Widget build(BuildContext context) {
    List<LienData> fdlien = SavaDataMore.fdlien;

    var size = MediaQuery.of(context).size;

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        // ignore: deprecated_member_use
        child: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "FD Lien Data",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              backgroundColor: const Color(0xFF0057C2),
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
                      Image.asset("assets/images/rdnewimage.png"),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text("FD Lien Data",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF002E5B),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                  ),
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
                  itemCount: fdlien.length,
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
                                dec: fdlien[index].schemename.toString().trim(),
                              ),
                              FDRDViewComp(
                                title: 'Name:',
                                dec:
                                    fdlien[index].accountname.toString().trim(),
                              ),
                              FDRDViewComp(
                                title: 'Account Number:',
                                dec: fdlien[index]
                                    .accountnumber
                                    .toString()
                                    .trim(),
                              ),
                              FDRDViewComp(
                                title: 'Lien Start Date:',
                                dec: fdlien[index]
                                    .lienenterydate
                                    .toString()
                                    .trim(),
                              ),
                              FDRDViewComp(
                                title: 'Lien End Date:',
                                dec: fdlien[index]
                                    .lienlastdate
                                    .toString()
                                    .trim(),
                              ),
                              FDRDViewComp(
                                title: 'Amount:',
                                dec: fdlien[index].fdamount.toString().trim(),
                              ),
                              FDRDViewComp(
                                title: 'Maturity Date:',
                                dec: fdlien[index].fdmddate.toString().trim(),
                              ),
                              FDRDViewComp(
                                title: 'Fd Start Date:',
                                dec: fdlien[index].fddate.toString().trim(),
                              ),
                              FDRDViewComp(
                                title: 'Maturity Amount:',
                                dec: fdlien[index].fdamount.toString().trim(),
                              ),
                              FDRDViewComp(
                                title: 'FD Interest Rate:',
                                dec: fdlien[index]
                                    .fdinterestrate
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
