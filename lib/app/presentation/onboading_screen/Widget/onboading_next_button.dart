
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sonia_app/app/core/constants/app_colors.dart';

import '../onboading_controller/controller.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Positioned(
        right: 10,
        bottom: 10,
        child: ElevatedButton(
          onPressed: ()=> OnBoardingController.instance.nextPage(),
          style: ElevatedButton.styleFrom(shape: const CircleBorder(),backgroundColor: AppColors.primary),
          child: const Icon(Iconsax.arrow_right_3,weight: 4,color: Colors.white,),
        ));
  }
}