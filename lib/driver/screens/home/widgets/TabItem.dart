part of 'HomeWidgetsImports.dart';

class TabItem extends StatelessWidget {
  final String title, count;
  final bool showBadge;
  const TabItem({this.title, this.count, this.showBadge});
  @override
  Widget build(BuildContext context) {
    return Tab(
        iconMargin: const EdgeInsets.all(0),
        child: Badge(
          toAnimate: true,
          shape: BadgeShape.circle,
          badgeColor: Colors.red,
          alignment: Alignment.topLeft,
          elevation: 0,
          ignorePointer: true,
          position: BadgePosition.topEnd(top: -10,end: -20),
          badgeContent: MyText(
            title: "$count",
            size: 8,
            color: MyColors.white,
          ),
          showBadge: showBadge,
          child: MyText(
            title: title,
            size: 10,
            color: MyColors.white,
          ),
        ));
  }
}
