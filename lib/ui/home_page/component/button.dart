import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Color color;
  final String text;
  final Color textColor;
  final FontWeight fontWeight;
  final VoidCallback press;

  Button ({
    required this.color,
    required this.text,
    required this.textColor,
    this.fontWeight=FontWeight.w500,
    required this.press
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color:color,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color:const Color(0XFF0087F3).withOpacity(0.22),
                blurRadius: 10,
              spreadRadius: 0,
              offset:const Offset(8,5))
            ]
          ),
          child: Center(
            child: Text(text,style: TextStyle(color:textColor,fontSize: 22,fontWeight: fontWeight )),
          ),
        ),
      ),
    );
  }
}
