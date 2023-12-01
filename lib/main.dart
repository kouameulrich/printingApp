import 'dart:io';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:printer_app/di/service_locator.dart';
import 'package:printer_app/model/dto/facture.dart';
import 'package:printer_app/ui/pages/facture.page.dart';
import 'package:printer_app/ui/pages/home.page.dart';
import 'package:printer_app/ui/pages/splash_screen.page.dart';
import 'package:printer_app/widgets/navigator_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  HttpOverrides.global = DevHttpOverrides();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const HomePage(),
          '/facture': (context) => const FacturePage(),
          // '/transfert': (context) => const TransfertDonnees(),
          // '/miseajour': (context) => const UpdateDataPage(),
        },
        title: 'Cabinet Dentaire Ivoire',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
      ),
    );
  }
}
