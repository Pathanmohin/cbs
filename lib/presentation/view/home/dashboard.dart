// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, deprecated_member_use
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/appdrawer/SearchBar/searchbar.dart';
import 'package:hpscb/presentation/view/appdrawer/drawer.dart';
import 'package:hpscb/presentation/view/auth/login_view.dart';
import 'package:hpscb/presentation/view/home/deposits_Loan/deposits_loan.dart';
import 'package:hpscb/presentation/view/home/header/header_img.dart';
import 'package:hpscb/presentation/view/home/instabanking/instabanking.dart';
import 'package:hpscb/presentation/view/home/payment/Payment.dart';
import 'package:hpscb/presentation/view/home/security/security.dart';
import 'package:hpscb/presentation/view/more/moreoptions.dart';
import 'package:hpscb/presentation/viewmodel/dashboard_viewmodel.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/presentation/widgets/optionalert.dart';
import 'package:hpscb/presentation/view/home/header/welcome_card.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<EVENTLIST> toAccountListt = BannerShowList.bannerList;

  String brdcst_festivalname = "";
  String brdcst_edate = "";
  String brdcst_ldate = "";
  String brdcst_emessage = "";
  String brdcst_filedata = "";
  String Message = "";
  int _currentPage = 0;

  PageController _pageController =
      PageController(); // Initialize the PageController
  Timer? _timer;
  List<String> dashboardItems = [];
  String Bannername = "";
  bool DashBoardEvent = false;

  @override
  void initState() {
    super.initState();

    if (toAccountListt.isEmpty) {
      DashBoardEvent = false;
    } else {
      DashBoardEvent = true;
    }
    _pageController = PageController(initialPage: _currentPage);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Setup Timer for auto sliding only after the widget is built
      _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
        if (_pageController.hasClients) {
          // Check if the controller is attached to any views
          if (_currentPage < toAccountListt.length - 1) {
            _currentPage++;
          } else {
            _currentPage = 0; // Loop back to the first page
          }

          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
    });

    // FetchCustomerAccounts();

    fetchCustomerAccounts();

    eventBannerApi(context);
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose the controller to prevent memory leaks
     _timer?.cancel(); // Cancel the timer when disposing the widget
    // _timer = null; // Set the timer to null to prevent memory leaks
 
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    Loader.hide();
    return (

      await showDialog(
          context: context,
          builder: (context) => Builder(builder: (context) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.1)),
              child: AlertDialog(
                backgroundColor: AppColors.onPrimary,
                title: const Text('Exit App?'),
                content: const Text(
                  'Are you sure you want to exit this App? You will not be able to continue it.',
                  style: TextStyle(fontSize: 16),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text(
                      'No',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () => {exit(0)},
                    child: const Text(
                      'Yes',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          }),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Builder(builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.1)),
          child: Scaffold(
              // backgroundColor: Colors.white,
              backgroundColor: AppColors.onPrimary,
              appBar: AppBar(
                backgroundColor: AppColors.appBlueC,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: InkWell(
                      child: const Icon(
                        Icons.search, // Search icon
                        color: Colors.white,
                        size: 32,
                      ),
                      onTap: () {
                        // Add the action to perform on search icon tap here
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchScreen()));
                        // For now, prints a message
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: InkWell(
                      child: Icon(
                        Icons.power_settings_new,
                        color: AppColors.onPrimary,
                        size: 26.sp,
                      ),
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return OptionAlertView(
                                title: 'Logout',
                                msg: 'Do you want to Logout?',
                                onSelectNo: () {
                                  Navigator.of(context).pop();
                                },
                                onSelectYes: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginView()));
                                },
                              );
                            });
                      },
                    ),
                  ),
                ],
                leading: Builder(
                  builder: (context) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(textScaler: const TextScaler.linear(1.1)),
                      child: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: AppColors.onPrimary,
                          size: 26.sp,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    );
                  },
                ),
              ),
              drawer: Builder(builder: (context) {
                return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: TextScaler.linear(1.1.sp)),
                    child: DrawerView());
              }),
              body: WillPopScope(
                onWillPop: () => _onWillPop(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const HeaderCard(),
                      WelcomeCard(),

                      Visibility(
                        visible: DashBoardEvent,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 240,
                                width: MediaQuery.of(context).size.width,
                                // Slider height
                                child: Stack(
                                  children: [
                                    PageView.builder(
                                      itemCount: toAccountListt.length,
                                      controller: _pageController,
                                      onPageChanged: (int index) {
                                        setState(() {});
                                      },
                                      itemBuilder: (context, index) {
                                        var item = toAccountListt[index];
                                        var base64Image = item.accountType ??
                                            ''; // Provide default value if null
                                        var userId = item.textValue ?? '';

                                        //   Convert base64Image to Image widget
                                        var imageWidget = base64Image.isNotEmpty
                                            ? Image.memory(
                                                base64Decode(base64Image),
                                                fit: BoxFit.scaleDown,
                                                height: 200,
                                              )
                                            : Container(); // Show empty container if no image

                                        // Pass imageWidget and userId to the card builder
                                        return buildDashboardCard(
                                            imageWidget, userId);
                                      },
                                    ),
                                    Positioned(
                                      bottom: 100,
                                      left: 0,
                                      right: 0,
                                      top: 220,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                          child: SmoothPageIndicator(
                                            controller: _pageController,
                                            count: toAccountListt.length,
                                            effect: const WormEffect(
                                              dotColor: Colors.grey,
                                              activeDotColor: Colors.blue,
                                              dotHeight: 8,
                                              dotWidth: 8,
                                              spacing: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Options Menu ---------------------------------------------------

                      SizedBox(
                        height: 2.sp,
                      ),

                      const InstaBanking(
                        title: "Insta Banking",
                        subTitle:
                            "View Balance, Statement, Quick Transfer, Pay Bills",
                        titel1: "My Accounts",
                        titel2: "Quick Transfer",
                        titel3: "Pay Bills",
                      ),

                      //    Padding(
                      //   padding:  EdgeInsets.only(top: 10.0),
                      //   child: Center(
                      //       child: SizedBox(
                      //     width: dimension.width,
                      //     height: 2,
                      //     child: Center(
                      //         child: Container(
                      //       color: Colors.black26,
                      //     )),
                      //   )),
                      // ),

                      const PaymentComponent(
                        title: "Payment",
                        subTitle: "Transfer Funds To Beneficiary",
                        titel1: "Within Bank",
                        titel2: "To Other Bank",
                        titel3: "Manage\n" "Beneficiary",
                      ),

                      const DepositsLoan(
                        title: "Deposits and Loan",
                        subTitle: "Create FD/RD, Instant Loan",
                        titel1: "Create FD/RD",
                        titel2: "Loan Against FD",
                        titel3: "Close FD/RD",
                      ),

                      //Security Bank
                      const SecurityComp(
                        title: "Security",
                        subTitle: "Generate MPIN, Change Password, Block Card",
                        titel1: "Generate MPIN",
                        titel2: "Change Password",
                        titel3: "Block Card",
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.sp,
                            bottom: 20.sp,
                            right: 15.sp,
                            left: 15.sp),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: AppColors.onPrimary,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MoreOptions()));

                              //  context.push("/more");

                              // GoRouter.of(context).go("/dashboard");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(50.sp),
                                      color: AppColors.onPrimary,
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.grey.withOpacity(0.2.sp),
                                          spreadRadius: 2.sp,
                                          blurRadius: 7.sp,
                                          offset: Offset(0.sp, 3.sp),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Image.asset(
                                        CustomImages.moreOption,
                                        width: 28.sp,
                                        height: 28.sp,
                                        color: AppColors.appBlueC,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.sp,
                                  ),
                                  Text(
                                    "More Services",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp,
                                      color: AppColors.appBlueC,
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          AppColors.appBlueC, // optional
                                      decorationThickness: 2.sp, // optional

                                      decorationStyle:
                                          TextDecorationStyle.solid,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        );
      }),
    );
  }

  void showImagePopup(BuildContext context, String base64ImageData,
      String brdcst_festivalname, String Message) {
    Uint8List imageBytes = base64Decode(base64ImageData);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 20), () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        });
        return Builder(
          builder: (context) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.1)),
              child: AlertDialog(
                backgroundColor: Colors.white,
                contentPadding: EdgeInsets.zero,
                content: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // Minimize unused space
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(Icons.close,
                                  color: AppColors.onSurface),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, right: 10, left: 10),
                      child: ScrollConfiguration(
                        behavior: const ScrollBehavior()
                            .copyWith(overscroll: false, scrollbars: false),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize:
                                MainAxisSize.min, // Minimize unused space
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 20.sp),
                              // Text in the center
                              if (brdcst_festivalname.isNotEmpty)
                                Text(
                                  brdcst_festivalname,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                              if (Message.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    Message,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                ),
                              if (imageBytes.isNotEmpty) ...[
                                SizedBox(height: 20.sp),
                                // Image below the text
                                Image.memory(
                                  imageBytes,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildDashboardCard(Widget imageWidget, String url) {
    return GestureDetector(
      onTap: () async {},
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Wrapping the image inside a container with fixed height
            Container(
              width: MediaQuery.of(context)
                  .size
                  .width, // Make the image take up full width of the card
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.sp),
                border: Border.all(
                  color: AppColors
                      .onPrimary, // Change this to your desired border color
                  width: 2.0, // Adjust the width as needed
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.sp),
                child: imageWidget, // Rounded corners for image
              ),
            ),
            SizedBox(height: 10.sp),
          ],
        ),
      ),
    );
  }

  // API code ...................................................................................
  void fetchCustomerAccounts() {
    final getAccountModel =
        Provider.of<DashboardViewmodel>(context, listen: false);

    String customerId = context.read<SessionProvider>().get('customerId');
    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

    DashAPi userInput =
        DashAPi(custID: customerId, userID: userid, purpose: "fetchDetail");

    String jsonString = jsonEncode(userInput.toJson());

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "tokenNo": tokenNo,
      "userID": userid,
    };

    // Convert data to JSON


    String encrypted = AESencryption.encryptString(jsonString, ibUsrKid);

    final parameters = <String, dynamic>{
      "data": encrypted,
    };

    getAccountModel.fetchAccount(parameters, headers, context);
  }

  Future<void> eventBannerApi(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Bannername = prefs.getString("namebanner") ?? '';
    if (Bannername == "Bannername") {
      //EventApi(context);

      DateTime now = DateTime.now();
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(now);

      String apiUrl = ApiConfig.eventShowBanner;

      String jsonString = jsonEncode({
        "date": "2024-11-01",
      });

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
          Map<String, dynamic> responseData = jsonDecode(response.body);

          var a = jsonDecode(responseData["Data"].toString());
          var b = responseData["Result"].toString();

          if (b == "Success") {
            Map<String, dynamic> billData = a[0];
            // List<dynamic> dataList = a;

            brdcst_festivalname = billData["brdcst_festivalname"].toString();
            brdcst_edate = billData["brdcst_edate"].toString();
            brdcst_ldate = billData["brdcst_ldate"].toString();
            brdcst_emessage = billData["brdcst_emessage"].toString();
            brdcst_filedata = billData["brdcst_filedata"].toString();

            showImagePopup(
                context, brdcst_filedata, brdcst_festivalname, brdcst_emessage);

            prefs.setString("namebanner", "ronak");
          } else {
            return;
          }
        }
      } catch (error) {
        return;
      }
    } else {
      return;
    }
  }
}
