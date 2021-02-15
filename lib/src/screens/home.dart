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
  Animation<double> boxAnimation;
  AnimationController boxController;

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

    boxController = AnimationController(
      duration: Duration(milliseconds: 250),
      vsync: this,
    );

    boxAnimation = Tween(begin: pi * 0.60, end: pi * 0.65).animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.easeInOut,
      ),
    );
    boxAnimation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          boxController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          boxController.forward();
        }
      },
    );
    boxController.forward();
  }

  onTap() {
    if (catController.isDismissed) {
      catController.forward();
      boxController.stop();
    } else if (catController.isCompleted) {
      catController.reverse();
      boxController.forward();
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
              buildRightFlap(),
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
    return Positioned(
      left: 7.0,
      top: 4.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(height: 10.0, width: 100.0, color: Colors.brown),
        builder: (ctx, child) {
          return Transform.rotate(
            alignment: Alignment.topLeft,
            angle: boxAnimation.value,
            child: child,
          );
        },
      ),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 7.0,
      top: 4.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(height: 10.0, width: 100.0, color: Colors.brown),
        builder: (ctx, child) {
          return Transform.rotate(
            alignment: Alignment.topRight,
            angle: -boxAnimation.value,
            child: child,
          );
        },
      ),
    );
  }
}
