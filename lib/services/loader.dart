import 'package:flutter/material.dart';
import 'dart:math';



class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  // Will have three kinds of animations, rotaion,
  // contract & expand, and emerge from center and rotate again
  AnimationController controller;
  Animation<double> rotationAnimation;
  Animation<double> contractAnimation;
  Animation<double> expandAnimation;

  final double initialRadius = 30;
  double _radius = 0.0;
  double _surroundingRadius = 10;

  @override
    void dispose() {
      // TODO: implement dispose
      controller.dispose();
      super.dispose();
    }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = AnimationController(
        vsync: this, duration: Duration(seconds: 5));

    rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2.0,
    ).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.0, 1.0, curve: Curves.linear)));

    contractAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.75, 1.0, curve: Curves.elasticIn)));

    expandAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.25, curve: Curves.elasticOut)));

    // Listens on any changes to the animation to oscilate the dots
    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0) {
          _radius = contractAnimation.value * initialRadius;
        } else if (controller.value >= 0.0 && controller.value <= 0.25) {
          _radius = expandAnimation.value * initialRadius;
        }
      });
    });
    
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Center(
        child: Stack(
          children: <Widget>[
            Dot(imagePath: 'assets/images/cherry.png', radius: 30),
            RotationTransition(
              turns: rotationAnimation,
              child: Stack(
                children: <Widget>[
                  Transform.translate(
                    offset:
                        Offset(_radius * cos(pi / 4), _radius * sin(pi / 4)),
                    child: Dot(
                      imagePath: 'assets/images/blueberry.png',
                      radius: _surroundingRadius,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                        _radius * cos(2 * pi / 4), _radius * sin(2 * pi / 4)),
                    child: Dot(
                      imagePath: 'assets/images/blueberry.png',
                      radius: _surroundingRadius,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                        _radius * cos(3 * pi / 4), _radius * sin(3 * pi / 4)),
                    child: Dot(
                      imagePath: 'assets/images/blueberry.png',
                      radius: _surroundingRadius,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                        _radius * cos(4 * pi / 4), _radius * sin(4 * pi / 4)),
                    child: Dot(
                      imagePath: 'assets/images/blueberry.png',
                      radius: _surroundingRadius,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                        _radius * cos(5 * pi / 4), _radius * sin(5 * pi / 4)),
                    child: Dot(
                      imagePath: 'assets/images/blueberry.png',
                      radius: _surroundingRadius,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                        _radius * cos(6 * pi / 4), _radius * sin(6 * pi / 4)),
                    child: Dot(
                      imagePath: 'assets/images/blueberry.png',
                      radius: _surroundingRadius,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                        _radius * cos(7 * pi / 4), _radius * sin(7 * pi / 4)),
                    child: Dot(
                      imagePath: 'assets/images/blueberry.png',
                      radius: _surroundingRadius,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                        _radius * cos(8 * pi / 4), _radius * sin(8 * pi / 4)),
                    child: Dot(
                      imagePath: 'assets/images/blueberry.png',
                      radius: _surroundingRadius,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final String imagePath;
  final double radius;
  final Color color;

  Dot({this.imagePath, this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(color: this.color, shape: BoxShape.circle),
        child: imagePath != null ? Image.asset(imagePath) : null,
      ),
    );
  }
}
