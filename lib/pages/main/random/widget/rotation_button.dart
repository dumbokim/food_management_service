import 'package:flutter/cupertino.dart';

class RotationButton extends StatelessWidget {
  RotationButton({
    Key? key,
    this.text = '',
    this.onPressed,
  }) : super(key: key);

  final String text;
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      color: CupertinoColors.systemPurple,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      borderRadius: BorderRadius.circular(20),
      child: Text(
        text,
        style: const TextStyle(color: CupertinoColors.white),
      ),
    );
  }
}
