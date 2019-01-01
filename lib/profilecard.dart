import 'package:flutter/material.dart';
import 'photobrowser.dart';

class ProfileCard extends StatefulWidget {
  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  
  Widget _buildBackground() {
    return PhotoBrowser(
      photoAssetPaths: [
        'assets/images/pic1.jpg',
        'assets/images/pic2.jpg'
      ],
      visiblePhotoIndex: 1,
    );
  }

  Widget _buildProfileSynopsis() {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.8),
            ]
          )
        ),
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'First Last',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0
                      ),
                    ),
                  ),
                  Text(
                    'Some description',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.info,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: const Color(0x11000000),
                blurRadius: 5.0,
                spreadRadius: 2.0,
              )
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  _buildBackground(),
                  _buildProfileSynopsis(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}