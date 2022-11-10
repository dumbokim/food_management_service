import 'package:flutter/cupertino.dart';

class RotationButton extends StatelessWidget {
  RotationButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

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
      child: const Text(
        '돌리기',
        style: TextStyle(color: CupertinoColors.white),
      ),
    );
  }
}
