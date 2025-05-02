import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sonia_app/app/core/constants/app_colors.dart';

import 'app/core/localization/app_translations.dart';
import 'app/presentation/onboading_screen/onboading.dart';
import 'app/presentation/views/login_screen.dart';
import 'app/presentation/views/map_services/map_services.dart';
import 'app/presentation/views/signup_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home:  GeoCodingAddress(),
    );
  }
}
