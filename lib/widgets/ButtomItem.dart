import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonItem extends StatelessWidget {
  const ButtonItem(
      {required Key key,
      required this.imagePath,
      required this.onClick,
      required this.text,
      required this.iconData,
      required this.size})
      : super(key: key);
  final String text;
  final String imagePath;
  final Function onClick;
  final IconData iconData;
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width - 60,
        child: Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  imagePath,
                  height: size,
                  width: size,
                  // color: Colors.white,
                ),
                // Icon(iconData),
                const SizedBox(width: 15),
                Text(
                  text,
                  style: const TextStyle(fontSize: 17, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}