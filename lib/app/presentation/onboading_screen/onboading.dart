
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:sonia_app/app/core/constants/app_images.dart';
import '../../core/constants/app_strings.dart';
import 'Widget/onboading_dot_navigation.dart';
import 'Widget/onboading_next_button.dart';
import 'Widget/onboading_page.dart';
import 'Widget/onboading_skip.dart';

import 'onboading_controller/controller.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 30,bottom: 30, left: 5,right: 5),
        child: Stack(
          children: [
            //Horizontal Scrollable Pages
            PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children:  [
                OnBoardingPage(
                    image: AppImage.image1,
                    title: title1,
                    subtitle: sub_Title1
                ),
                OnBoardingPage(
                    image: AppImage.image2,
                    title:title2,
                    subtitle: sub_Title2
                ),
                OnBoardingPage(
                    image: AppImage.image3,
                    title:title3,
                    subtitle: sub_Title3
                ),
                OnBoardingPage(
                    image: AppImage.image4,
                    title: title4,
                    subtitle:sub_Title4
                ),
                OnBoardingPage(
                    image: AppImage.image5,
                    title: title5,
                    subtitle: sub_Title5
                ),
              ],
            ),
            //skip Button
            const OnBoardingSkip(),

            //Dot Navigation SmoothPageIndicator
            const OnBoardingDotNavigation(),

            //Circular Button
            const OnBoardingNextButton()
          ],
        ),
      ),
    );
  }
}