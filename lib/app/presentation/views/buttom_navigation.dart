import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sonia_app/app/core/constants/app_colors.dart';

import '../viewmodels/home_controller.dart';
import 'navigationBarScreen/account_screeen.dart';
import 'navigationBarScreen/home_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(label: "home", icon: Icon(Icons.home)),
      BottomNavigationBarItem(label: "categories", icon: Icon(Icons.abc)),
      BottomNavigationBarItem(label: "cart", icon: Icon(Icons.ad_units)),
      BottomNavigationBarItem(label: "Account", icon: Icon(Icons.person)),
    ];

    var navBody = [HomeScreen(), Container(), Container(), SettingsPage()];

    return Scaffold(
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: navBody.elementAt(controller.currentNavIndex.value),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.secondary,
          selectedItemColor: AppColors.primary,
          //selectedLabelStyle: TextStyle(fontFamily: semibold),
          items: navbarItem,
          onTap: (value) {
            controller.currentNavIndex.value = value;
          },
        ),
      ),
    );
  }
}
