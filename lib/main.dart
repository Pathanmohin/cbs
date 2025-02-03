import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/data/repositories/user_repository.dart';
import 'package:hpscb/domain/usecases/logout.dart';
import 'package:hpscb/presentation/view/auth/login_view.dart';
import 'package:hpscb/presentation/view/dashboard/SeesionTimer/seesiontimout.dart';
import 'package:hpscb/presentation/view/splash/splash.dart';
import 'package:hpscb/presentation/viewmodel/Saftytipss_viewmodel.dart';
import 'package:hpscb/presentation/viewmodel/activateuser_viewmodel.dart';
import 'package:hpscb/presentation/viewmodel/auth_view_model.dart';
import 'package:hpscb/presentation/viewmodel/contectus_viewmodel.dart';
import 'package:hpscb/presentation/viewmodel/dashboard_viewmodel.dart';
import 'package:hpscb/presentation/viewmodel/drawerprovider/drawer_viewmodel.dart';
import 'package:hpscb/presentation/viewmodel/loginbanner_viewmodel.dart';
import 'package:hpscb/presentation/viewmodel/mpinauth_viewmodel.dart';
import 'package:hpscb/presentation/viewmodel/password_viewmodel.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/presentation/viewmodel/splashprovider/splash_provider.dart';
import 'package:hpscb/utility/secure_screen_manager.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:provider/provider.dart';
import 'domain/usecases/get_user_profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SecureScreenManager.enableSecureScreen();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SessionTimeoutManager _sessionTimeoutManager;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

   

    _sessionTimeoutManager = SessionTimeoutManager(
      timeoutDuration: 2, // Set timeout duration in minutes
      onSessionTimeout: _handleSessionTimeout,
    );
    _sessionTimeoutManager.startTimer();
  }

  Future<void> _handleSessionTimeout() async {
    if (_navigatorKey.currentContext != null) {
      Loader.hide();

      await showDialog(
        context: _navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: AppColors.onPrimary,
          title: const Text(
            'Session Expired',
            style: TextStyle(fontSize: 18),
          ),
          content: const Text(
            'Your session has expired due to inactivity.',
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToLogin();
              },
              child: const Text(
                'OK',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      );
    } else {
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    if (_navigatorKey.currentContext != null) {
      _navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginView()),
      );
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginView()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _sessionTimeoutManager.resetTimer,
      onPanDown: (_) => _sessionTimeoutManager.resetTimer(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690), // Set the default size (from design)
        builder: (context, child) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SplashProvider()),
            ChangeNotifierProvider(create: (_) => AuthViewModel()),
            ChangeNotifierProvider(create: (_) => ContactusViewmodel()),
            ChangeNotifierProvider(create: (_) => ActivateuserViewmodel()),
            ChangeNotifierProvider(create: (_) => MpinauthViewmodel()),
            ChangeNotifierProvider(create: (_) => PasswordVisibilityProvider()),
            ChangeNotifierProvider(create: (_) => LoginbannerViewmodel()),
            ChangeNotifierProvider(create: (_) => DashboardViewmodel()),
            ChangeNotifierProvider(create: (_) => SessionProvider()),
            ChangeNotifierProvider(create: (_) => SaftytipssViewmodel()),
            Provider(create: (_) => UserRepository()),
            Provider(create: (_) => GetUserProfile()),
            Provider(create: (_) => Logout()),
            ChangeNotifierProvider(
              create: (context) => DrawerViewModel(
                getUserProfile: context.read(),
                logout: context.read(),
              ),
            ),
          ],
          child: MaterialApp(
            navigatorKey: _navigatorKey,
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _sessionTimeoutManager.dispose();
    super.dispose();
  }
}
