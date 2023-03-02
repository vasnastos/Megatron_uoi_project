import 'package:colorful_background/colorful_background.dart';
import 'package:flutter/cupertino.dart';

class Background extends StatelessWidget {
  final Widget? child;

  const Background({Key? key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorfulBackground(
      duration: const Duration(milliseconds: 5000),
      backgroundColors: const [
        Color(0xFF2E2B2B),
        Color(0xFF388186),
        Color.fromARGB(255, 56, 134, 114),
        Color(0xFFA5E9E1),
        Color(0xFFFDF6F6),
      ],
      child: child,
    );
  }
}
