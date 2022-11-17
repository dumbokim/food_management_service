import 'package:flutter/material.dart';

void showDefaultSnackBar(
  BuildContext context, {
  String content = '',
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      duration: const Duration(milliseconds: 1500),
    ),
  );
}
