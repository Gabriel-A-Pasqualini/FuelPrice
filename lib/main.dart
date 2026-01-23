
import 'package:fuelprice/helper/colors_helper.dart';
import 'package:fuelprice/services/location_background_service.dart';
import 'package:fuelprice/widgets/index.dart';
import 'package:fuelprice/widgets/index_teste.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final service = FlutterBackgroundService();
  final appColor = AppColors.appMainColor;

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: false,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: onStart,
    ),
  );  

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: appColor,
      focusColor: appColor,
    ),
    home: const IndexPageTeste(), 
  ));
}
