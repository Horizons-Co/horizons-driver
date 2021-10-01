import 'package:auto_route/auto_route.dart';
import 'package:base_structure/general/constants/MyColors.dart';
import 'package:base_structure/res.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageZoom extends StatefulWidget {
  final List images;
  final bool file;

  const ImageZoom({@required this.images, this.file = false});
  @override
  _ImageZoomState createState() => _ImageZoomState();
}

class _ImageZoomState extends State<ImageZoom> {
  var _current;
  final ValueNotifier _notifier = new ValueNotifier<int>(0);
  PageController _controller;

  @override
  void initState() {
    _controller = new PageController(initialPage: 0);
    _current = widget.images.first;
    super.initState();
  }

  _setChangeImage(index) {
    _current = widget.images[index];
    _notifier.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: ImageIcon(
            AssetImage(Res.removeBlack),
            color: MyColors.white,
            size: 40,
          ),
          onPressed: () => ExtendedNavigator.root.pop(),
        ),
      ),
      body: PageView(
        controller: _controller,
        onPageChanged: _setChangeImage,
        children: List.generate(widget.images.length, (index) {
          return Container(
            alignment: Alignment.center,
            child: PhotoView(
              backgroundDecoration: BoxDecoration(
                color: Colors.black87,
              ),
              imageProvider: widget.file
                  ? FileImage(widget.images[index])
                  : NetworkImage(widget.images[index]),
            ),
          );
        }),
      ),
    );
  }
}
