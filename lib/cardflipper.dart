import 'package:flutter/material.dart';
import 'profilecard.dart';

class CardFlipper extends StatefulWidget {
  @override
  _CardFlipperState createState() => _CardFlipperState();
}

class _CardFlipperState extends State<CardFlipper> with TickerProviderStateMixin {
  double scrollPercent = 0.0;
  Offset startDrag;
  double startDragPercentScroll;
  double finishScrollStart;
  double finishScrollEnd;
  AnimationController finishScrollController;
  
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
    }

  @override
    void dispose() {
      // TODO: implement dispose
      finishScrollController.dispose();
      super.dispose();
    }

  void _onHorizontalDragStart(DragStartDetails details) {
    startDrag = details.globalPosition;
    startDragPercentScroll = scrollPercent;   // Current percent scroll when user starts dragging
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final currentDrag = details.globalPosition;
    final dragDistance = currentDrag.dx - startDrag.dx;
    final singleCardDragPercent = dragDistance / context.size.width;  // 1:1 displacement as card dragged off screen

    final numCards = 3;

    setState(() {
          scrollPercent = (startDragPercentScroll + (-singleCardDragPercent / numCards)).clamp(0.0, 1.0 - (1/numCards));
        });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    setState(() {
          startDrag = null;
          startDragPercentScroll = null;
        });
  }
  
  // Building the list of cards to be displayed
  List<Widget> _buildCards() {
    return [
      _buildCard(0, 3, scrollPercent),
      _buildCard(1, 3, scrollPercent),
      _buildCard(2, 3, scrollPercent),
    ];
  }

  Widget _buildCard(int cardIndex, int cardCount, double scrollPercent) {
    // Determine how many cards scrolled to the left
    final cardScrollPercent = scrollPercent /
        (1 /
            cardCount); // Amount of scroll representing 1 card moving off screen

    return FractionalTranslation(
        translation: Offset((cardIndex - cardScrollPercent), 0.0),
        child: ProfileCard());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStart,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      behavior: HitTestBehavior.translucent,  // Allow for drag from white area around the card
      child: Stack(
        children: _buildCards(),
      ),
    );
  }
}
