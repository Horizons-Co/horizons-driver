import 'package:flutter/material.dart';

import '../constants/MyColors.dart';
import 'MyText.dart';

// ignore: must_be_immutable
class DefaultAppBar extends PreferredSize {
  String title;
  BuildContext con;
  Widget leading;
  List<Widget> actions = [];
  final Size preferredSize = const Size.fromHeight(kToolbarHeight + 5);

  DefaultAppBar(
      {@required this.title, @required this.con, this.actions, this.leading});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      title: MyText(
        title: "$title",
        size: 12,
        color: MyColors.white,
      ),
      centerTitle: false,
      backgroundColor: MyColors.primary,
      elevation: 0,
      leading: leading ??
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 25,
              color: MyColors.white,
            ),
            onPressed: () => Navigator.of(con).pop(),
          ),
      actions: actions,
    );
  }
}
