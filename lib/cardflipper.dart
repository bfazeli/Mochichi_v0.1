import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';
import 'user_data.dart';
import 'profilecard.dart';

class CardFlipper extends StatefulWidget {
  final List<UserViewModel> cards;
  final Function(double scrollPercent) onScroll;

  CardFlipper({
    this.cards,
    this.onScroll,
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
          if (widget.onScroll != null) {
            widget.onScroll(scrollPercent);
          }
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
      if (widget.onScroll != null) {
        widget.onScroll(scrollPercent);
      }
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

  Matrix4 _buildCardProjection(double scrollPercent) {
    // Pre-multiplied matrix of a projection matrix and a view matrix.
    //
    // Projection matrix is a simplified perspective matrix
    // http://web.iitd.ac.in/~hegde/cad/lecture/L9_persproj.pdf
    // in the form of
    // [[1.0, 0.0, 0.0, 0.0],
    //  [0.0, 1.0, 0.0, 0.0],
    //  [0.0, 0.0, 1.0, 0.0],
    //  [0.0, 0.0, -perspective, 1.0]]
    //
    // View matrix is a simplified camera view matrix.
    // Basically re-scales to keep object at original size at angle = 0 at
    // any radius in the form of
    // [[1.0, 0.0, 0.0, 0.0],
    //  [0.0, 1.0, 0.0, 0.0],
    //  [0.0, 0.0, 1.0, -radius],
    //  [0.0, 0.0, 0.0, 1.0]]
    final perspective = 0.002;
    final radius = 1.0;
    final angle = scrollPercent * pi / 8;
    final horizontalTranslation = 0.0;
    Matrix4 projection = new Matrix4.identity()
      ..setEntry(0, 0, 1 / radius)
      ..setEntry(1, 1, 1 / radius)
      ..setEntry(3, 2, -perspective)
      ..setEntry(2, 3, -radius)
      ..setEntry(3, 3, perspective * radius + 1.0);

    // Model matrix by first translating the object from the origin of the world
    // by radius in the z axis and then rotating against the world.
    final rotationPointMultiplier = angle > 0.0 ? angle / angle.abs() : 1.0;
    // print('Angle: $angle');
    projection *= new Matrix4.translationValues(
            horizontalTranslation + (rotationPointMultiplier * 300.0),
            0.0,
            0.0) *
        new Matrix4.rotationY(angle) *
        new Matrix4.translationValues(0.0, 0.0, radius) *
        new Matrix4.translationValues(
            -rotationPointMultiplier * 300.0, 0.0, 0.0);

    return projection;
  }

  Widget _buildCard(UserViewModel viewModel, int cardIndex, int cardCount,
      double scrollPercent) {
    // Determine how many cards scrolled to the left
    final cardScrollPercent = scrollPercent /
        (1 /
            cardCount); // Amount of scroll representing 1 card moving off screen
    final parallax = scrollPercent - (cardIndex / cardCount);

    return FractionalTranslation(
        translation: Offset((cardIndex - cardScrollPercent), 0.0),
        child: Transform(
          transform: _buildCardProjection(cardScrollPercent - cardIndex),
          child: ProfileCard(
            viewModel: viewModel,
            parallaxPercent: parallax,
          ),
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
