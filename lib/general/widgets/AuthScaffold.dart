import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../constants/MyColors.dart';

class AuthScaffold extends StatelessWidget {
  final Widget child;
  final bool showAppBar;
  final GlobalKey<ScaffoldState> scaffold;

  AuthScaffold({
    this.child,
    this.showAppBar = true,
    @required this.scaffold,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                // image: AssetImage(
                //   Res.backGround,
                // ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  showAppBar
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 40),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: MyColors.black,
                              size: 27,
                            ),
                            onPressed: () {
                              ExtendedNavigator.of(context).pop();
                            },
                          ),
                        )
                      : Container(
                          width: 20,
                          height: 20,
                        ),
                ],
              ),
              Flexible(
                child: child,
              ),
            ],
          )
        ],
      ),
    );
  }
}
