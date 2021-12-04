part of 'DrawerWidgetsImports.dart';

class DrawerItemCard extends StatelessWidget {
  final Function onTap;
  final String title;
  final String icon;
  final Color color;

  DrawerItemCard({this.icon, this.title, this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: MyColors.grey, width: .5),
            )),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyText(
                      title: title,
                      size: 12,
                      color: color,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Image.asset(
                  icon,
                  width: 25,
                  height: 25,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
