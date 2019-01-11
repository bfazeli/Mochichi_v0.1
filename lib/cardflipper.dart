import 'dart:ui';

import 'package:flutter/material.dart';
import 'user_data.dart';
import 'profilecard.dart';

class CardFlipper extends StatefulWidget {
  final List<UserViewModel> cards;

  CardFlipper({
    this.cards,
  });

  @override
  _CardFlipperState createState() => _CardFlipperState();
}

class _CardFlipperState extends State<CardFlipper>
    with TickerProviderStateMixin {
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

    finishScrollController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    )..addListener(() {
        setState(() {
          scrollPercent = lerpDouble(
              finishScrollStart, finishScrollEnd, finishScrollController.value);
        });
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    finishScrollController.dispose();
    super.dispose();
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    startDrag = details.globalPosition;
    startDragPercentScroll =
        scrollPercent; // Current percent scroll when user starts dragging
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final currentDrag = details.globalPosition;
    final dragDistance = currentDrag.dx - startDrag.dx;
    final singleCardDragPercent = dragDistance /
        context.size.width; // 1:1 displacement as card dragged off screen

    final numCards = widget.cards.length;

    setState(() {
      scrollPercent =
          (startDragPercentScroll + (-singleCardDragPercent / numCards))
              .clamp(0.0, 1.0 - (1 / numCards));
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    // TODO: Resume work on this
    final numCards = widget.cards.length;

    finishScrollStart = scrollPercent;
    finishScrollEnd = (scrollPercent * numCards).round() /
        numCards; // Get back scroll percent between 0 and 1
    finishScrollController.forward(from: 0.0); // Run full animation

    setState(() {
      startDrag = null;
      startDragPercentScroll = null;
    });
  }

  // Building the list of cards to be displayed
  List<Widget> _buildCards() {
    final numCards = widget.cards.length;

    // Mapped the list of cards for building indivi cards
    int index = -1;
    return widget.cards.map((UserViewModel viewModel) {
      ++index;
      return _buildCard(viewModel, index, numCards, scrollPercent);
    }).toList();
  }

  Widget _buildCard(UserViewModel viewModel, int cardIndex, int cardCount, double scrollPercent) {
    // Determine how many cards scrolled to the left
    final cardScrollPercent = scrollPercent /
        (1 /
            cardCount); // Amount of scroll representing 1 card moving off screen

    return FractionalTranslation(
        translation: Offset((cardIndex - cardScrollPercent), 0.0),
        child: ProfileCard(
          viewModel: viewModel,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStart,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      behavior: HitTestBehavior
          .translucent, // Allow for drag from white area around the card
      child: Stack(
        children: _buildCards(),
      ),
    );
  }
}
