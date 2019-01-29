import 'package:flutter/material.dart';

class ScrollIndicatorPainter extends CustomPainter {
  final int cardCount;
  final double scrollPercent;
  final Paint trackPaint;
  final Paint thumbPaint;

  ScrollIndicatorPainter({
    this.cardCount,
    this.scrollPercent,
  }) : trackPaint = Paint()
    ..color = Colors.lightGreenAccent
    ..style = PaintingStyle.fill,
    thumbPaint = Paint()
    ..color = Colors.lightBlueAccent
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(
          0.0, 
          0.0, 
          size.width, 
          size.height,
        ),
        topLeft: Radius.circular(3.0),
        topRight: Radius.circular(3.0),
        bottomLeft: Radius.circular(3.0),
        bottomRight: Radius.circular(3.0),
      ), 
      trackPaint);

    // Draw thumb
    final thumbWidth = size.width / cardCount;
    final thumbLeft = scrollPercent * size.width;

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(
          thumbLeft, 
          0.0, 
          thumbWidth, 
          size.height,
        ),
        topLeft: Radius.circular(3.0),
        topRight: Radius.circular(3.0),
        bottomLeft: Radius.circular(3.0),
        bottomRight: Radius.circular(3.0),
      ), 
      thumbPaint);
  }

  // Optimize here
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
  
}