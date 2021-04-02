import 'package:base_structure/general/constants/MyColors.dart';
import 'package:base_structure/general/widgets/AnimationContainer.dart';
import 'package:base_structure/general/widgets/MyText.dart';
import 'package:flutter/material.dart';

class BuildLanguageItem extends StatelessWidget {
  final String title;
  final Function changeLang;

  BuildLanguageItem({this.title, this.changeLang});

  @override
  Widget build(BuildContext context) {
    return AnimationContainer(
      distance: 150,
      vertical: false,
      duration: Duration(seconds: 1),
      child: InkWell(
        onTap: changeLang,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      title: title,
                      size: 12,
                      alien: TextAlign.center,
                      color: MyColors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
