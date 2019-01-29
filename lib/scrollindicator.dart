import 'package:flutter/material.dart';
import 'services/scrollindicatorpainter.dart';

class ScrollIndicator extends StatefulWidget {
  final int cardCount;
  final double scrollPercent;

  ScrollIndicator({
    this.cardCount,
    this.scrollPercent
  });

  @override
  _ScrollIndicatorState createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<ScrollIndicator> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ScrollIndicatorPainter(
        cardCount: widget.cardCount,
        scrollPercent: widget.scrollPercent,
      ),
      child: Container(),
    );
  }
}