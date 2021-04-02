part of 'BuildProfileImports.dart';

class BuildProfileImage extends StatelessWidget {
  final String title;
  final String image;
  const BuildProfileImage({this.image, this.title});
  @override
  Widget build(BuildContext context) {
    return AnimationContainer(
      distance: 150,
      vertical: false,
      duration: Duration(seconds: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            title: "$title : ",
            size: 14,
            color: MyColors.black,
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            width: MediaQuery.of(context).size.width * .9,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: MyColors.black, width: 1),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.fill)),
          )
        ],
      ),
    );
  }
}
