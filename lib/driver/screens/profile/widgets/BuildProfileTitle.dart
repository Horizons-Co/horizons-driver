part of 'BuildProfileImports.dart';

class BuildProfileTitle extends StatelessWidget {
  final String title;
  final String value;
  const BuildProfileTitle({this.value, this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          title: "$title : ",
          size: 14,
          color: MyColors.black,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: MyText(
            title: value,
            size: 12,
            color: MyColors.black,
            alien: TextAlign.start,
          ),
          decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: MyColors.black, width: 1)),
        )
      ],
    );
  }
}
