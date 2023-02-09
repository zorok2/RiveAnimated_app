import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../model/rive_model.dart';

class SlideMenuTile extends StatelessWidget {
  const SlideMenuTile({
    Key? key,
    required this.menu,
    required this.press,
    required this.riveOninit,
    required this.active,
  }) : super(key: key);
  final RiveAssets menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveOninit;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(
            color: Colors.white24,
            thickness: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              left: 0,
              width: active == true ? 288 : 0,
              height: 56,
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xff6792FF),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: RiveAnimation.asset(
                  menu.src,
                  artboard: menu.artBoard,
                  onInit: riveOninit,
                ),
              ),
              title: Text(
                menu.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
