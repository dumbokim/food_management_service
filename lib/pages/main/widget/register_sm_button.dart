import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ppopgi/common/common.dart';

class RegisterSmButton extends StatelessWidget {
  const RegisterSmButton({
    Key? key,
    this.onTap,
    this.text = '',
  }) : super(key: key);

  final VoidCallback? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
          border: Border.all(
            color: defaultColor,
            width: 2,
          ),
          // shape: BoxShape.circle
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/logo.svg',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: defaultColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
