import 'package:flutter/material.dart';

class PhotoBrowser extends StatefulWidget {
  final List<String> photoAssetPaths;
  final int visiblePhotoIndex;

  PhotoBrowser({
    this.photoAssetPaths,
    this.visiblePhotoIndex,
  });

  @override
  _PhotoBrowserState createState() => _PhotoBrowserState();
}

class _PhotoBrowserState extends State<PhotoBrowser> {
  int visiblePhotoIndex; 

  @override
    void initState() {
      super.initState();
      visiblePhotoIndex = widget.visiblePhotoIndex;
    }

  // Widget may update so want to change the index of the image
  @override
    void didUpdateWidget(PhotoBrowser oldWidget) {
      // TODO: implement didUpdateWidget
      super.didUpdateWidget(oldWidget);
      if(widget.visiblePhotoIndex != oldWidget.visiblePhotoIndex) {
        setState(() {
                  visiblePhotoIndex = widget.visiblePhotoIndex;
                });
      }
    }

  void _prevImage() {
    setState(() {
          visiblePhotoIndex = visiblePhotoIndex > 0 ? visiblePhotoIndex - 1 : 0;
        });
  }

  void _nextImage() {
    setState(() {
          visiblePhotoIndex = visiblePhotoIndex < widget.photoAssetPaths.length - 1
            ? visiblePhotoIndex + 1 : visiblePhotoIndex;
        });
  }

  Widget _buildPhotoControls() {
    return new Container();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // Photo
        Image.asset(
          widget.photoAssetPaths[visiblePhotoIndex],
          fit: BoxFit.cover,
        ),

        // Photo Indicator
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(),
        ),

        // Photo controll
        _buildPhotoControls()
      ],
    );
  }
}