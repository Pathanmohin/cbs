import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hpscb/data/models/ContactInfo.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/titles/custom_titles.dart';

class ContactUs extends StatelessWidget {
  final ContactInfo contactInfo;

  const ContactUs({super.key, required this.contactInfo});

  @override
  Widget build(BuildContext context) {
    List<String> phoneArray = contactInfo.phone.split(',').map((e) => e.trim()).toList();

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.1)),
      child: Scaffold(
        backgroundColor: AppColors.onPrimary,
        appBar: AppBar(
          title:  Text(
            CustomTitles.contactus,
            style: TextStyle(color: AppColors.onPrimary, fontSize: 16.sp),
          ),
          backgroundColor: AppColors.appBlueC,
          iconTheme: const IconThemeData(color: AppColors.onPrimary),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  CustomImages.contactus,
                  width: 150.sp,
                  height: 150.sp,
                ),
              ),
              SizedBox(height: 10.sp),
              Center(
                child: Text(
                  "For Any Technical Assistance",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                ),
              ),
              SizedBox(height: 10.sp),
              Padding(
                padding: EdgeInsets.only(left: 60.sp),
                child: Text(
                  "Please Contact:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                ),
              ),
              SizedBox(height: 10.sp),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: phoneArray.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.sp, vertical: 5.sp),
                    child: ListTile(
                      leading: Icon(
                        Icons.call,
                        color: AppColors.appBlueC,
                        size: 28.sp,
                      ),
                      title: Text(
                        phoneArray[index],
                        style: const TextStyle(color: AppColors.appBlueC, fontSize: 14),
                      ),
                      onTap: () {
                        _makePhoneCall(phoneArray[index]);
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 10.sp),

              Padding(
                padding: EdgeInsets.only(left: 60.sp),
                child:   Text(
                  "For Any Disputes, Please Call On:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 40.sp),
                child: ListTile(
                  leading: Icon(
                    Icons.call,
                    color: AppColors.appBlueC,
                    size: 28.sp,
                  ),
                  title: Text(
                    contactInfo.mobile,
                    style: const TextStyle(color: AppColors.appBlueC, fontSize: 14),
                  ),
                  onTap: () {
                    _makePhoneCall(contactInfo.mobile);
                  },
                ),
              ),
              Center(
                child: Text(
                  "OR",
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60.sp, top: 5.sp),
                child: Text(
                  "Email ID:",
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.sp),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: AppColors.appBlueC,
                    size: 26.sp,
                  ),
                  title: Text(
                    contactInfo.email,
                    style: const TextStyle(color: AppColors.appBlueC, fontSize: 14),
                  ),
                  onTap: () {
                    _sendEmail(contactInfo.email);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60.sp, top: 5.sp),
                child: Text(
                  "Address:",
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.sp),
                child: ListTile(
                  leading: Icon(
                    Icons.location_on,
                    color: AppColors.appBlueC,
                    size: 28.sp,
                  ),
                  title: Text(
                    contactInfo.address,
                    style: const TextStyle(color: AppColors.appBlueC, fontSize: 14),
                  ),
                  onTap: () {
                    _openMapWithAddress(contactInfo.address);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    if (phoneNumber.isEmpty) return;
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _sendEmail(String emailAddress) async {
    if (emailAddress.isEmpty) return;
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {'subject': 'Your Subject Here', 'body': 'Your email body here'},
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _openMapWithAddress(String address) async {
    if (address.isEmpty) return;
    final Uri mapUri = Uri(scheme: 'geo', path: '0,0', queryParameters: {'q': address});

    if (await canLaunchUrl(mapUri)) {
      await launchUrl(mapUri, mode: LaunchMode.externalApplication);
    }
  }
}
