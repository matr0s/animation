import 'package:flutter/material.dart';
import 'dart:math';

import '../widgets/cat.dart';

// ************************************
// * We are using a stateful widget because of state updates for some elements,
// * but thos updates do not related to other screens.
// * As a result, local state management is enough.
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
// ************************************
// * Animation & Controllers declatation. We need two types of animated elements
// * Cat + Flips.

  // * Cat variables
  Animation<double> catAnimation;
  AnimationController catController;
  // * Flip variables
  Animation<double> boxAnimation;
  AnimationController boxController;

  @override
  void initState() {
    super.initState();
// ************************************
// * We init our Animation and Controllers from the very beginning

    // *  Controller ussualy responsable for current animation values and duration
    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    // * We use Tween to define a range for animation values and animate it later
    // * with a selected type of animation
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

    //* Listener for the Box animation status. Depends on status we can have diff actions
    boxAnimation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          boxController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          boxController.forward();
        }
      },
    );
    // * Start Flip animation once the screen rendered
    boxController.forward();
  }

// ************************************
// * Method we are using for the GestureDetector action - onTap in our case
// * This method runs the animation for Cat depends on our Tap action and animation status
  onTap() {
    if (catController.isDismissed) {
      catController.forward();
      boxController.stop();
    } else if (catController.isCompleted) {
      catController.reverse();
      boxController.forward();
    }
  }

// ************************************
// * MAIN METHOD
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

// ************************************
// * Vertical animation for Cat() using builder
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
      // Cat() created separately. Safe recourses
      child: Cat(),
    );
  }

  // * Box body on teh screen
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
