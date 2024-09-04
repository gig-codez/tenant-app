import '../exports/exports.dart';

class CustomRichText extends StatelessWidget {
  final List<TextSpan> children;
  const CustomRichText({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: children,
      ),
    );
  }
}
