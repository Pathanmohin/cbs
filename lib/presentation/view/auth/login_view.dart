// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_launcher_icons/config/config.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:hpscb/config/constants.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/domain/models/login_api_model.dart';
import 'package:hpscb/presentation/view/auth/activate/activateuser.dart';
import 'package:hpscb/presentation/view/auth/mpin/mpin.dart';
import 'package:hpscb/presentation/viewmodel/Saftytipss_viewmodel.dart';
import 'package:hpscb/presentation/viewmodel/auth_view_model.dart';
import 'package:hpscb/presentation/viewmodel/loginbanner_viewmodel.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/presentation/view/auth/widgets/bottomsheet.dart';
import 'package:hpscb/presentation/view/auth/widgets/header.dart';
import 'package:hpscb/presentation/view/auth/widgets/passfield.dart';
import 'package:hpscb/presentation/view/auth/widgets/userfield.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class ListEvent {
  List<Map<String, dynamic>> childModel;

  ListEvent(this.childModel);
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String _address = '';
  String _error = '';

  String lat = "";
  String log = "";

  Future<void> _handleLogin() async {
    final permissionStatus = await _requestPermission();

    if (permissionStatus != PermissionStatus.granted) {
      setState(() {
        _error = 'Location permission is not granted.';
      });
      await _showSettingsDialogON();
      return;
    }

    final isLocationEnabled = await checkLocationServices();
    if (!isLocationEnabled) {
      setState(() {
        _error = 'Location services are not enabled.';
      });
      //   await  _showSettingsDialogON();
      return;
    }

    try {
      final position = await getCurrentLocation();

      lat = position.latitude.toString();
      log = position.longitude.toString();

      final address = await getAddressFromCoordinates(
          position.latitude, position.longitude);
      setState(() {
        _address = address;
        _error = '';
      });

      // postData(userID.text, passWord.text);
    } catch (e) {
      setState(() {
        _error = 'Failed to get location or address.';
      });
    }
  }

  Future<PermissionStatus> _requestPermission() async {
    var status = await Permission.location.request();

    if (status.isDenied) {
      if (await Permission.location.shouldShowRequestRationale) {
        return status;
      } else {
        await _showSettingsDialog();
        return status;
      }
    } else if (status.isPermanentlyDenied) {
      await _showSettingsDialog();
      return status;
    }

    return status;
  }

  Future<void> _showSettingsDialogON() async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Builder(builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.1)),
            child: AlertDialog(
              backgroundColor: AppColors.onPrimary,
              title: const Text(
                'Alert',
                style: TextStyle(fontSize: 18),
              ),
              content: Text(
                _error,
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
            ),
          );
        });
      },
    );
  }

  Future<void> _showSettingsDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Builder(builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.1)),
            child: AlertDialog(
              backgroundColor: AppColors.onPrimary,
              title: const Text(
                'Permission Required',
                style: TextStyle(fontSize: 18),
              ),
              content: const Text(
                'Location permission is needed to fetch the address. Please enable it in settings.',
                style: TextStyle(fontSize: 18),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'Settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    openAppSettings();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
      },
    );
  }

  Future<bool> checkLocationServices() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high),
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    return '${place.street}, ${place.locality}, ${place.country}';
  }

  //  List<AccountDetails> getApplyDetailsList = [];
  // List<AccountDetailsFirst> listFirstPage = [];
  static const platform = MethodChannel(
      'com.nscspl.mbanking.hpscb.usb_debugging_detection/debugging');
  static const platform1 =
      MethodChannel('com.nscspl.mbanking.hpscb/suspicious_apps');

  List<Image> images = [];
  Timer? _timer;

  //bool _isLoading = true;

  Future<void> _checkUsbDebugging() async {
    bool usbDebuggingEnabled;
    try {
      usbDebuggingEnabled =
          await platform.invokeMethod('isUsbDebuggingEnabled');
    } on PlatformException catch (e) {
      usbDebuggingEnabled = false;
      if (kDebugMode) {
        print("Failed to get USB debugging status: '${e.message}'.");
      }
    }

    if (usbDebuggingEnabled) {
      _showDebuggingStatus();
    }
  }

  Future<void> checkForSuspiciousApps() async {
    try {
      // Invoke the method channel to get the list of installed apps
      final List<dynamic> installedAppsDynamic =
          await platform1.invokeMethod('getInstalledApps');

      // Cast the result to a List<String>
      final List<String> installedApps = installedAppsDynamic.cast<String>();

      // List of suspicious apps to check against
      List<String> suspiciousApps = [
        // General Suspicious Apps
        "com.anydesk.anydeskandroid",
        "com.example.malwareapp", // Example for a known malware app
        "com.spyware.tracker", // Example for a spyware or tracking app
        "com.fakebanking.app", // Example for a phishing or fake banking app
        "com.freemium.hacktool", // Example for a hacking tool disguised as a freemium app
        "com.rootkit.hider", // Example for a rootkit or system-hiding tool
        "com.pirated.software", // Example for a pirated or cracked software distribution
        "com.ransomware.encryption", // Example for ransomware that encrypts files
        "com.keylogger.stealer", // Example for a keylogger or password-stealing app
        "com.adware.intrusive", // Example for adware that shows intrusive ads
        "com.fakeantivirus.scanner", // Example for a fake antivirus app that prompts unnecessary actions,

        // Suspicious VPN Apps
        "com.example.malwarevpn", // Example for a VPN app associated with malware
        "com.vpnfree.untrusted", // Example for a free VPN with questionable security
        "com.vpnproxy.fake", // Example for a VPN that falsely advertises security features
        "com.vpnhider.spy", // Example for a VPN app that secretly tracks user data
        "com.vpnservice.trojan", // Example for a VPN app that acts as a trojan
        "com.vpn.unsecure", // Example for a VPN app known for data leaks
        "com.fakevpn.ads", // Example for a VPN app that shows intrusive ads and lacks security
        "com.vpntracker.malicious", // Example for a VPN app that includes tracking and spyware components
        "com.piratevpn.illegal", // Example for a VPN app used for accessing illegal content
        "com.vpnhack.tool", // Example for a VPN app used as a hacking tool

        // Suspicious Remote Desktop Apps
        "com.example.remotedesktopmalware", // Example for a remote desktop app associated with malware
        "com.remotedesktop.spy", // Example for a remote desktop app that may spy on users
        "com.rdp.hacker", // Example for a remote desktop app used for hacking
        "com.remotecontrol.untrusted", // Example for an untrusted remote control app
        "com.remotedesktop.trojan", // Example for a remote desktop app that acts as a trojan
        "com.remoteaccess.unsecure", // Example for a remote desktop app known for security vulnerabilities
        "com.fake.rdpapp", // Example for a fake remote desktop app that performs malicious activities
        "com.spyware.remotedesktop", // Example for a remote desktop app that includes spyware components
        "com.unverified.remotedesktop", // Example for an unverified or untrusted remote desktop app
        "com.malicious.rdp", // Example for a remote desktop app associated with malicious activities
      ];

      // Check if any installed apps match the suspicious apps
      bool foundSuspicious = false;
      for (var app in installedApps) {
        if (suspiciousApps.contains(app)) {
          foundSuspicious = true;
          break;
        }
      }

      _showInstallationStatusDialog(foundSuspicious);

      // If suspicious apps are found, show an alert
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to get installed apps: '${e.message}'.");
      }
    }
  }

  void _showInstallationStatusDialog(bool foundSuspicious) {
    if (foundSuspicious) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Builder(
            builder: (context) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.1)),
                child: AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Fixed header section
                      Container(
                        color: Colors.blue,
                        padding: const EdgeInsets.all(16.0),
                        child: const Row(
                          children: [
                            Icon(Icons.warning, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              "Security Alert",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Scrollable section below the header
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: const Text(
                                    "Security Alert!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Remote access apps installed on your device can be used to steal the app information.",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Suspicious Apps on your device:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                ListTile(
                                  leading: Image.asset(
                                    'assets/images/anydesk.png',
                                    height: 40,
                                  ),
                                  title: const Text("AnyDesk"),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "As per regulatory guidelines, the remote access application may be misused to steal your information.",
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "To continue using your app, please uninstall these applications from your device:",
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "1. Go to device settings\n2. Find these apps\n3. Tap on Uninstall",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: const Text("EXIT"),
                      onPressed: () {
                        SystemNavigator.pop(); // This will close the app
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }
  }

  _showDebuggingStatus() async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Builder(builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.1)),
            child: AlertDialog(
              backgroundColor: AppColors.onPrimary,
              title: const Text("Turn Off USB Debugging"),
              content: const Text(
                "We have detected USB Debugging mode is on. Please Switch it off. Go to settings and disable developer mode to use HPSCB Mobile Application.                     1. Go to developer mode\n2. Find USB Debugging Mode\n3. Turn OFF USB Debugging",
                style: TextStyle(fontSize: 15),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    "EXIT",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    SystemNavigator.pop(); // Closes the application
                  },
                ),
              ],
            ),
          );
        });
      },
    );
  }

  Future<bool> _onWillPop() async {
    Loader.hide();
    return (await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => Builder(builder: (context) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.1)),
              child: AlertDialog(
                backgroundColor: AppColors.onPrimary,
                title: const Text('Exit Page?'),
                content: const Text(
                  'Are you sure you want to exit this App? You will not be able to continue it.',
                  style: TextStyle(fontSize: 18),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text(
                      'No',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () => {exit(0)},
                    child: const Text(
                      'Yes',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            );
          }),
        )) ??
        false;
  }

  final PageController _pageController =
      PageController(); // Initialize the PageController

  FocusNode userIDFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();

  int _currentPage = 0;

  //Timer? _timer;

  @override
  void initState() {
    super.initState();

    _handleLogin();

    //Config.sessionStop = false;

    checkForSuspiciousApps();
    // userIDFocusNode = FocusNode();

    //  _checkUsbDebugging();
    // showbanner(context);
    // _checkUsbDebugging();
    // showbanner(context);
    saftyTipssss(context);
    //  WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // Setup Timer for auto sliding only after the widget is built
    //   _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
    //     if (_pageController.hasClients) {
    //       // Check if the controller is attached to any views
    //       if (_currentPage < BannerShowList.beforeList.length - 1) {
    //         _currentPage++;
    //       } else {
    //         _currentPage = 0; // Loop b vcack to the first page
    //       }

    //       _pageController.animateToPage(
    //         _currentPage,
    //         duration: Duration(milliseconds: 300),
    //         curve: Curves.easeInOut,
    //       );
    //     }
    //   });
    // });
  }

  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);

  // final ValueNotifier<bool> _bannerShow = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isPasswordVisible.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    userIDFocusNode.dispose();
    passFocusNode.dispose();
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  bool _isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom != 0;
  }

  @override
  Widget build(BuildContext context) {
// Model

    final authViewModel = Provider.of<AuthViewModel>(context);

    return WillPopScope(
      onWillPop: () async {
        await _onWillPop();
        return false;
      },
      child: Builder(builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: WillPopScope(
            onWillPop: () async {
              Loader.hide();
              return (await showDialog(
                    context: context,
                    builder: (context) => Builder(builder: (context) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaler: const TextScaler.linear(1.1)),
                        child: AlertDialog(
                          backgroundColor: AppColors.onPrimary,
                          title: const Text('Exit Page?'),
                          content: const Text(
                            'Are you sure you want to exit this App? You will not be able to continue it.',
                            style: TextStyle(fontSize: 18),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text(
                                'No',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            TextButton(
                              onPressed: () => {exit(0)},
                              child: const Text(
                                'Yes',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  )) ??
                  false;
            },
            child: Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: AppColors.onPrimary,
              bottomSheet:
                  !_isKeyboardVisible(context) ? const BottomSheetShow() : null,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: SizedBox(
                                  height: 80.sp,
                                  width: 150.sp,
                                  child:
                                      Image.asset(CustomImages.loginPageLogo))),
                          const HeaderSection(),
                          SizedBox(height: 10.sp),
                          UsernameField(
                            controller: _usernameController,
                            focusNodeUser: userIDFocusNode,
                            nextFocusNode: passFocusNode,
                          ),
                          SizedBox(height: 5.sp),
                          ValueListenableBuilder<bool>(
                              valueListenable: _isPasswordVisible,
                              builder: (context, isVisible, child) {
                                return PasswordField(
                                  controller: _passwordController,
                                  passwordVisible: !isVisible,
                                  passFocusNode: passFocusNode,
                                  togglePasswordVisibility: () {
                                    _isPasswordVisible.value =
                                        !_isPasswordVisible.value;
                                  },
                                );
                              }),
                          SizedBox(
                            height: 2.sp,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () async {
                                // Handle "Forgot Password" functionality here

                                bool val = await Utils.netWorkCheck(context);

                                if (val == false) {
                                  return;
                                }

                                // Active User -----------------------------------------------------------------------------------------------

                                // context.push("/activateuser");

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Activate()));
                              },
                              child: const Text(
                                'Activate User',
                                style: TextStyle(
                                    fontSize: 18, color: AppColors.appBlueC),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.sp),
                          Center(
                              child: InkWell(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                // print("Logging in with username: ${usernameController.text}");

                                bool val = await Utils.netWorkCheck(context);

                                if (val == false) {
                                  return;
                                }

                                String md5Hash = Crypt()
                                    .generateMd5(_passwordController.text);

                                final prefs =
                                    await SharedPreferences.getInstance();

                                prefs.setString("latitude", lat.toString());
                                prefs.setString("longitude", log.toString());
                                prefs.setString("address", _address.toString());

                                DeviceInfoPlugin deviceInfo =
                                    DeviceInfoPlugin();
                                AndroidDeviceInfo androidInfo =
                                    await deviceInfo.androidInfo;

                                LoginApiModel data = LoginApiModel(
                                  userID: _usernameController.text,
                                  encPassword: md5Hash,
                                  SIMNO: androidInfo.id.toString(),
                                  Type: 'WITHPASS',
                                  MobVer: '26',
                                  longitude: log.toString(),
                                  latitude: lat.toString(),
                                  address: _address.toString(),
                                );

                                String jsonString = jsonEncode(data.toJson());

                                Map<String, String> headers = {
                                  "Content-Type":
                                      "application/x-www-form-urlencoded",
                                };

                                String encrypted = AESencryption.encryptString(
                                    jsonString, Constants.AESENCRYPTIONKEY);

                                final parameters = <String, dynamic>{
                                  "data": encrypted,
                                };

                                authViewModel.loginAPi(
                                    parameters, headers, context);
                              }

                              // context.go('/dashboard');
                            },
                            child: Container(
                              height: 45.sp,
                              decoration: BoxDecoration(
                                color: AppColors.appBlueC,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    color: AppColors.onPrimary,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          )),
                          Padding(
                            padding: EdgeInsets.only(top: 5.sp, bottom: 5.sp),
                            child: Center(
                              child: Text(
                                "OR",
                                style: TextStyle(
                                    color: AppColors.onSurface,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Center(
                              child: InkWell(
                            onTap: () async {
                              bool val = await Utils.netWorkCheck(context);

                              if (val == false) {
                                return;
                              }

                              _handleLogin();

                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString("latitude", lat.toString());
                              prefs.setString("longitude", log.toString());
                              prefs.setString("address", _address.toString());

                              //context.push('/mpin');

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Mpin()));

                              // Button for MPIN ......................................................................
                            },
                            child: Container(
                              height: 45.sp,
                              decoration: BoxDecoration(
                                color: AppColors.appBlueC,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "LOGIN With MPIN",
                                  style: TextStyle(
                                    color: AppColors.onPrimary,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          )),
                          Padding(
                            padding: EdgeInsets.only(top: 5.sp, bottom: 5.sp),
                            child: Center(
                              child: Text(
                                "App Ver 3.5",
                                style: TextStyle(
                                    color: AppColors.onSurface,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Consumer<LoginbannerViewmodel>(
                              builder: (context, provider, child) {
                            return Visibility(
                              visible: provider.loading,
                              child: Padding(
                                padding: EdgeInsets.all(10.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 200.sp,
                                      // Slider height
                                      child: Stack(
                                        children: [
                                          PageView.builder(
                                            itemCount: BannerShowList
                                                .beforeList.length,
                                            controller: _pageController,
                                            onPageChanged: (int index) {
                                              setState(() {});
                                            },
                                            itemBuilder: (context, index) {
                                              var item = BannerShowList
                                                  .beforeList[index];
                                              var base64Image = item
                                                      .accountType ??
                                                  ''; // Provide default value if null
                                              var userId = item.textValue ?? '';

                                              // Convert base64Image to Image widget
                                              var imageWidget = base64Image
                                                      .isNotEmpty
                                                  ? Image.memory(
                                                      base64Decode(base64Image),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : Container(); // Show empty container if no image

                                              // Pass imageWidget and userId to the card builder
                                              return buildDashboardCard(
                                                  imageWidget, userId);
                                            },
                                          ),
                                          Positioned(
                                            bottom: 90.sp,
                                            left: 0.sp,
                                            right: 0.sp,
                                            top: 160.sp,
                                            child: Center(
                                              child: SmoothPageIndicator(
                                                controller: _pageController,
                                                count: BannerShowList
                                                    .beforeList.length,
                                                effect: WormEffect(
                                                  dotColor: AppColors.onGrey,
                                                  activeDotColor:
                                                      AppColors.onBlue,
                                                  dotHeight: 8.sp,
                                                  dotWidth: 8.sp,
                                                  spacing: 16.sp,
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
                            );
                          }),
                          SizedBox(
                            height: 8.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
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
              height: 140.sp,

              width: double
                  .infinity, // Make the image take up full width of the card
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
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

  // API Code............................................................

  Future<void> saftyTipssss(BuildContext context) async {
    final Tipss = Provider.of<SaftytipssViewmodel>(context, listen: false);

    String jsonString = jsonEncode({
      "category": "Login",
    });

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
    };

    final parameters = <String, dynamic>{
      "data": jsonString,
    };

    await Tipss.SaftytippApi(jsonString, headers, context);

    //   try {
    //     // Make POST request
    //     var response = await http.post(
    //       Uri.parse(apiUrl),
    //       body: jsonString,
    //       headers: headers,
    //       encoding: Encoding.getByName('utf-8'),
    //     );

    //     // Check if request was successful
    //     if (response.statusCode == 200) {
    //       Map<String, dynamic> responseData = jsonDecode(response.body);

    //       // Access the first item in the list and its safety_remark field
    //       var data = jsonDecode(responseData["Data"].toString());

    //       // Access the first item in the list and its safety_remark field
    //       var safetyRemark = data[0]["safety_remark"];
    //       var safetyKid = data[0]["safety_kid"];
    //       var safetyCategory = data[0]["safety_category"];

    //       // Show the response data in a popup
    //       showDialog(
    //         context: context,
    //         builder: (BuildContext context) {
    //           return AlertDialog(
    //             title: Text("Login Related Safety Information"),
    //             content: SingleChildScrollView(
    //               child: ListBody(
    //                 children: <Widget>[
    //                   ListTile(
    //                     leading: Image.asset(
    //                       'assets/images/logo1.png', // Replace with an appropriate AnyDesk logo
    //                       height: 40,
    //                     ),
    //                     title: const Text("HPSCB"),
    //                   ),
    //                   SizedBox(height: 10),
    //                   Text(
    //                     "Safety Tips:",
    //                     style:
    //                         TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //                   ),
    //                   Text(
    //                     safetyRemark,
    //                     style: TextStyle(fontSize: 15),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             actions: <Widget>[
    //               TextButton(
    //                 child: Text(
    //                   'OK',
    //                   style: TextStyle(
    //                       fontSize: 17,
    //                       color: const Color.fromARGB(255, 109, 156, 196)),
    //                 ),
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 },
    //               ),
    //             ],
    //           );
    //         },
    //       );
    //     } else {
    //       print('Failed to get response');
    //     }
    //   } catch (error) {
    //     //Loader.hide();

    //     return;
    //   }
    // }
  }
}
