import 'package:flutter/material.dart';

import '../app/core/constants/app_images.dart';

class SecondPageScreen extends StatefulWidget {
  @override
  State<SecondPageScreen> createState() => _SecondPageScreenState();
}

class _SecondPageScreenState extends State<SecondPageScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _pageController = PageController();

    // Keep TabBar and PageView in sync
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _pageController.jumpToPage(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'A'),
            Tab(text: 'B'),
            Tab( text: 'C'),
            Tab( text: 'D'),

          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            _tabController.animateTo(index); // Keep tab in sync with swipe
          },
          children: [
            Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImage.img5),
                  fit: BoxFit.cover,
                )
            ),
                child: Center(child: Text('Screen 1'))),
            Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                      image: AssetImage(AppImage.img2),
                      fit: BoxFit.cover,
                    )
                ),
                child: Center(child: Text('Screen 2'))),
            Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                      image: AssetImage(AppImage.img3),
                      fit: BoxFit.cover,
                    )
                ),
                child: Center(child: Text('Screen 3'))),
            Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                      image: AssetImage(AppImage.img4),
                      fit: BoxFit.cover,
                    )
                ),
                child: Center(child: Text('Screen 4'))),

          ],
        ),
      ),
    );
  }
}