import 'package:flutter/material.dart';

import '../../res.dart';
import '../constants/MyColors.dart';
import 'MyText.dart';

Widget headerLogo({BuildContext context, String title}) {
  return Container(
    child: Column(
      children: [
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: MyColors.primary,
              image: DecorationImage(
                  image: AssetImage(Res.header,),
                  fit: BoxFit.cover,
              ),
          ),
        ),
        Visibility(
          visible: title != null,
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child: MyText(
              title: title,
              size: 12,
              alien: TextAlign.start,
              color: MyColors.black,
            ),
          ),
        ),
      ],
    ),
  );
}
