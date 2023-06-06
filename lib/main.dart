import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qrapp/core/services/app_helper.dart';
import 'package:qrapp/globals.dart';
import 'package:qrapp/router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/services/firebase_option.dart';
import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDefault();
  Globals.sharedPreferences = await SharedPreferences.getInstance();
  await AppHelper.firstRunCheck();
  configureDependencies();
  runApp(App());
}

Future<void> initializeDefault() async {
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Initialized default app $app');
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = Colors.black45
    ..indicatorSize = 35.0
    ..radius = 10.0
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.purple
    ..textColor = Colors.transparent
    ..toastPosition = EasyLoadingToastPosition.bottom
    ..userInteractions = false
    ..dismissOnTap = false;
}

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.purple,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.purple)),
      title: 'QR',
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
