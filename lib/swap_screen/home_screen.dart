import 'package:flutter/material.dart';

import '../app/core/constants/app_images.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {

  final List<String> items = List.generate(10, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: items.length,
            itemBuilder: (context,int index){
          return ThreeDCard(title: items[index]);
        }),
      ),
    );
  }
}


class ThreeDCard extends StatefulWidget {
  final String title;

  const ThreeDCard({Key? key, required this.title}) : super(key: key);

  @override
  _ThreeDCardState createState() => _ThreeDCardState();
}

class _ThreeDCardState extends State<ThreeDCard> {
  double _angleX = 0;
  double _angleY = 0;

  void _onPointerMove(PointerEvent event) {
    setState(() {
      _angleY = (event.position.dx - 100) / 300;
      _angleX = -(event.position.dy - 100) / 300;
    });
  }

  void _onPointerExit(PointerEvent event) {
    setState(() {
      _angleX = 0;
      _angleY = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: _onPointerMove,
      onPointerDown: _onPointerExit,
      child: Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // perspective
          ..rotateX(_angleX)
          ..rotateY(_angleY),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(20),
          height: 200,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            image: DecorationImage(
              image: AssetImage(AppImage.img3),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.title,
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
        ),
      ),
    );
  }
}
