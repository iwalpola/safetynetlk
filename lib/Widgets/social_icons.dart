import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  final IconData iconData;

  const SocialIcon({Key? key, required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: SizedBox(
        width: 40.0,
        height: 40.0,
        child: RawMaterialButton(
          shape: const CircleBorder(),
          onPressed: () {},
          child: Icon(iconData, color: Colors.white),
        ),
      ),
    );
  }
}
