import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/cat.dart';

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation, boxAnimation;
  AnimationController catController, boxController;

  initState() {
    super.initState();

    boxController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    boxAnimation = Tween(
      begin: pi * 0.6,
      end: pi * 0.65,
    ).animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.bounceIn,
      ),
    );

    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });

    boxController.forward();

    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    catAnimation = Tween(
      begin: -35.0,
      end: -80.0,
    ).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );
  }

  onTap() {
    if (catAnimation.status == AnimationStatus.completed) {
      boxController.forward();
      catController.reverse();
    } else if (catAnimation.status == AnimationStatus.dismissed) {
      boxController.stop();
      catController.forward();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation!'),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            // alignment: AlignmentDirectional.center,
            children: <Widget>[
              buildCatAnimation(),
              buildBox(),
              buildLeftFlat(),
              buildRightFlat(),
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
      builder: (context, child) {
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

  Widget buildLeftFlat() {
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        builder: (context, child) {
          return Transform.rotate(
            angle: boxAnimation.value,
            alignment: Alignment.topLeft,
            child: child,
          );
        },
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
      ),
    );
  }

  Widget buildRightFlat() {
    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        builder: (context, child) {
          return Transform.rotate(
            angle: -boxAnimation.value,
            alignment: Alignment.topRight,
            child: child,
          );
        },
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
      ),
    );
  }
}
