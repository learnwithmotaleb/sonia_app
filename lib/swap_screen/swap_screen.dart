import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sonia_app/app/core/constants/app_images.dart';

import 'home_screen.dart';
import 'new_swap_page.dart';

class SwipeScreen extends StatelessWidget {
  final PageController _controller = PageController();

  final List<Widget> _pages = [
    FadeIn(duration: Duration(seconds: 1), child: HomeScreenPage()),
    FadeIn(
      duration: Duration(seconds: 1),
      child: SecondPageScreen(),
    ),
    FadeIn(
      duration: Duration(seconds: 1),
      child: Container(

  decoration: BoxDecoration(
  color: Colors.indigo,
  image: DecorationImage(
  image: AssetImage(AppImage.img1),
  fit: BoxFit.cover,
  )),
        child: Center(child: Text("Swap Page 3")),

      ),
    ),
    FadeIn(
      duration: Duration(seconds: 1),
      child: Container(

        child: Center(child: Text("Swap Page 4")),
        decoration: BoxDecoration(
            color: Colors.blue,            image: DecorationImage(
              image: AssetImage(AppImage.img2),
              fit: BoxFit.cover,
            )),
      ),
    ),
    FadeIn(
      duration: Duration(seconds: 1),
      child: Container(

        child: Center(child: Text("Swap Page 5")),
  decoration: BoxDecoration(
      color: Colors.pink,            image: DecorationImage(
  image: AssetImage(AppImage.img3),
  fit: BoxFit.cover,
  )),
      ),
    ),
    FadeIn(
      duration: Duration(seconds: 1),
      child: Container(

        child: Center(child: Text("Swap Page 6")),
        decoration: BoxDecoration(
            color: Colors.orange,
            image: DecorationImage(
          image: AssetImage(AppImage.img4),
          fit: BoxFit.cover,
        )
        ),
      ),
    ),
    FadeIn(
      duration: Duration(seconds: 1),
      child: Container(


            decoration: BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                  image: AssetImage(AppImage.img5),
                  fit: BoxFit.cover,
                )
            ),
          child: Center(child: Text("Swap Page 7"),



      )),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.horizontal, // default is horizontal
        children: _pages,
      ),
    );
  }
}
