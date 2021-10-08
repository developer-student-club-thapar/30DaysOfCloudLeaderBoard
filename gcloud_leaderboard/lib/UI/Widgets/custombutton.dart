// ignore_for_file: prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  CustomButton({
    this.text,
    this.onTap,
  });
  final text;
  final onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height:  50,
        width:  200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffe7cdf8),
        ),
        child: Center(
          child: Text(
            '$text',
            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18
                            ),
          ),
        ),
      ),
    );
  }
}
