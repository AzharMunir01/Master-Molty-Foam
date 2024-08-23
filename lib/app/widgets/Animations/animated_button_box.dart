import 'package:flutter/material.dart';


class AnimatedButton extends StatelessWidget {
  AnimatedButton(
      {Key? key,
      this.bgColor = Colors.red,
      this.onTap,
      this.isFavorited = false,
      this.borderColor = Colors.transparent,
      this.radius = 50,
      this.size = 20})
      : super(key: key);
  final Color borderColor;
  final Color? bgColor;
  final bool isFavorited;
  final double radius;
  final double size;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            // color: isFavorited ? kBgCardColor : kBgCardColor,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black87.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: isFavorited
              ? Icon(
                  Icons.my_location,
                  color: Colors.black,
                  size: size,
                )
              : Icon(
                  Icons.my_location,
                  color: Colors.black,
                  size: size,
                )),
    );
  }
}
