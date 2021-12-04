part of 'DrawerImports.dart';

class DrawerData {
  showLogoutAlert(
      {BuildContext context,
      String title,
      String acceptTitle,
      Function onAccept}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        actions: [
          Container(
            width: MediaQuery.of(context).size.width * .35,
            child: DefaultButton(
              title: tr("back"),
              onTap: () => ExtendedNavigator.root.pop(),
              textColor: MyColors.white,
              color: MyColors.grey.withOpacity(.3),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .35,
            child: DefaultButton(
              title: acceptTitle,
              onTap: onAccept,
              textColor: MyColors.white,
              color: Colors.red,
            ),
          ),
        ],
        content: Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: ImageIcon(
                      AssetImage(Res.removeBlack),
                      size: 40,
                    ),
                    onPressed: () => ExtendedNavigator.root.pop(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    title: title,
                    size: 12,
                    color: MyColors.black,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
