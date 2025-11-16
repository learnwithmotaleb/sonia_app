import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sonia_app/app/core/constants/app_colors.dart';
import 'package:sonia_app/swap_screen/swap_screen.dart';

import 'app/app_permission/app_permissions.dart';
import 'app/core/constants/app_colors.dart';
import 'app/core/localization/app_translations.dart';
import 'app/presentation/onboading_screen/onboading.dart';
import 'app/presentation/views/buttom_navigation.dart';
import 'app/presentation/views/login_screen.dart';
import 'app/presentation/views/map_services/map_services.dart';
import 'app/presentation/views/signup_screen.dart';
import 'country_code_phone_otp/phone_number_screen.dart';
import 'firebase_options.dart';
import 'google_map/part1.dart';
import 'google_map/part10.dart';
import 'google_map/part11.dart';
import 'google_map/part2.dart';
import 'google_map/part3.dart';
import 'google_map/part4.dart';
import 'google_map/part5.dart';
import 'google_map/part6.dart';
import 'google_map/part7.dart';
import 'google_map/part8.dart';
import 'google_map/part9.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppLanguages(),
      locale: Locale("en","US"),
      fallbackLocale: Locale("en","US"),
      theme: ThemeData(
        primaryColor: AppColors.primary,
        useMaterial3: false,
      ),
      home:  OnBoardingScreen(),
    );
  }
}
