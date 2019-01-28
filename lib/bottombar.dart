import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: Center(
              child: Icon(
                Icons.settings,
                color: Colors.blueAccent,
              ),
            ),
          ),
          Flexible(
            child: Container(),
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
