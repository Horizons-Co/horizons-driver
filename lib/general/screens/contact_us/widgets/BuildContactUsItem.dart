part of 'ContactUsWidgetsImports.dart';

class BuildContactUsItem extends StatelessWidget {
  final String title, image;
  final Function onTap;

  BuildContactUsItem({this.title, this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                  Image.asset(
                    image,
                    width: 32,
                    height: 32,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
