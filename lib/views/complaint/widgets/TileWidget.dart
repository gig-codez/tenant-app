import '../../../exports/exports.dart';

class TileWigdet extends StatelessWidget {
  final String title;
  final String description;
  const TileWigdet({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 18.0, bottom: 10, top: 18, right: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyles(context).getRegularStyle(),
          ),
          Text(
            description,
            softWrap: true,
            style: TextStyles(context).getRegularStyle(),
          )
        ],
      ),
    );
  }
}
