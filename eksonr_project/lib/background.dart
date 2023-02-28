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
        Color(0xFF3e204f),
        Color(0xFF5a4565),
        Color(0xFFcec9d6),
        Color(0xFFe2dbe9),
        Color(0xFFbcaecc),
      ],
      child: child,
    );
  }
}
