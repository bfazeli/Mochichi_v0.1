import 'package:flutter/material.dart';
import 'selectedphotoindicator.dart';
import './services/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PhotoBrowser extends StatefulWidget {
  final Map<String, String> photoUrlPaths;
  final int visiblePhotoIndex;

  PhotoBrowser({
    this.photoUrlPaths,
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
    if (widget.visiblePhotoIndex != oldWidget.visiblePhotoIndex) {
      setState(() {
        visiblePhotoIndex = widget.visiblePhotoIndex;
      });
    }
  }

  void _prevImage() {
    print("Before $visiblePhotoIndex");
    setState(() {
      visiblePhotoIndex = visiblePhotoIndex > 1 ? visiblePhotoIndex - 1 : 1;
      print("After $visiblePhotoIndex");
    });
    
  }

  void _nextImage() {
    setState(() {
      visiblePhotoIndex = visiblePhotoIndex < widget.photoUrlPaths.length
          ? visiblePhotoIndex + 1
          : visiblePhotoIndex;
    });
  }

  // Implemnent this later
  void _profileInfo() {}

  Widget _buildPhotoControls() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // Previous image, left half
        GestureDetector(
          onTap: _prevImage,
          child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 1.0,
              alignment: Alignment.topLeft,
              child: Container(
                color: Colors.transparent,
              )),
        ),
        // Next image, right half
        GestureDetector(
          onTap: _nextImage,
          child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 0.8,
              alignment: Alignment.topRight,
              child: Container(
                color: Colors.transparent,
              )),
        ),
        // Account info, bottom half
        GestureDetector(
          onTap: _profileInfo,
          child: FractionallySizedBox(
            widthFactor: 1.0,
            heightFactor: 0.2,
            alignment: Alignment.bottomLeft,
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // Photo
        CachedNetworkImage(
          placeholder: Loader(),
          imageUrl: widget.photoUrlPaths["imageUrl$visiblePhotoIndex"],
          fit: BoxFit.cover,
        ),

        // Photo Indicator
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: SelectedPhotoIndicator(
            photoCount: widget.photoUrlPaths.length,
            visiblePhotoIndex: visiblePhotoIndex,
          ),
        ),

        // Photo controll
        _buildPhotoControls()
      ],
    );
  }
}
