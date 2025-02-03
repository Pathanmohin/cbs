// This function returns a list of all ChangeNotifierProviders
import 'package:hpscb/presentation/viewmodel/splashprovider/splash_provider.dart';
import 'package:provider/provider.dart';

List<ChangeNotifierProvider> getProviders() {
  return [
    ChangeNotifierProvider(create: (_) => SplashProvider()),
    // Add more providers here as needed
  ];
}