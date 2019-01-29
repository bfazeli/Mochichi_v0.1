import 'package:flutter/material.dart';
import 'scrollindicator.dart';

class BottomBar extends StatefulWidget {
  final int cardCount;
  final double scrollPercent;

  BottomBar({
    this.cardCount,
    this.scrollPercent,
  });

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: Center(
              child: Icon(
                Icons.minimize,
                color: Colors.blueAccent,
              ),
            ),
          ),
          Flexible(
            child: Container(
              width: double.infinity,
              height: 5.0,
              child: ScrollIndicator(
                cardCount: widget.cardCount,
                scrollPercent: widget.scrollPercent,
              ),
            ),
          ),
          Flexible(
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
