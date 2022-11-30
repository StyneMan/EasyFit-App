// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/state/state_manager.dart';
import 'package:easyfit_app/helper/theme/app_theme.dart';
import 'package:easyfit_app/screens/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Constants.accentColor, // navigation bar color
  ));

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  final _controller = Get.put(StateController());
  Widget? component;
  // PreferenceManager? _manager;

  @override
  void initState() {
    super.initState();
    // _manager = PreferenceManager(context);
    // _init();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const GetMaterialApp(
              debugShowCheckedModeBanner: false, home: Splash());
        } else {
          // Loading is done, return the app:
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'EasyFit',
            theme: appTheme,
            home: Onboarding(),
          );
        }
      },
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Container(
      color: lightMode ? Constants.primaryColor : const Color(0xff042a49),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    await Future.delayed(const Duration(seconds: 3));
  }
}
