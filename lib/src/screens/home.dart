import 'package:animation/src/widgets/cat.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  @override
  void initState() {
    super.initState();

    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    catAnimation = Tween(begin: -40.0, end: -83.0).animate(CurvedAnimation(
      parent: catController,
      curve: Curves.easeIn,
    ));
  }

  onTap() {
    if (catController.isDismissed) {
      catController.forward();
    } else if (catController.isCompleted) {
      catController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation App'),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: [
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (ctx, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap() {
    return Transform.rotate(
      alignment: Alignment.topLeft,
      angle: pi / 1.8,
      child: Container(
        height: 10.0,
        width: 100.0,
        color: Colors.brown,
      ),
    );
  }
}
