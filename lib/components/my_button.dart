// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  void Function()? onTap;
  final String btnName;
  MyButton({
    super.key,
    required this.onTap,
    required this.btnName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            btnName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
