part of 'DrawerWidgetsImports.dart';

class DrawerWallet extends StatelessWidget {
  final String wallet;
  final String price;

  DrawerWallet({this.price, this.wallet});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primary, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                title: wallet,
                size: 14,
                color: MyColors.white,
              ),
              Image.asset(
                Res.wallet,
                width: 32,
                height: 32,
              )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          MyText(
            title: price,
            size: 14,
            color: MyColors.white,
          ),
        ],
      ),
    );
  }
}
