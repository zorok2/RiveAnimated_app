import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class animatedBtn extends StatelessWidget {
  const animatedBtn({
    Key? key,
    required RiveAnimationController btnAnimationcontroller,
    required this.press,
  })  : _btnAnimationcontroller = btnAnimationcontroller,
        super(key: key);

  final RiveAnimationController _btnAnimationcontroller;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
          height: 65,
          width: 260,
          child: Stack(
            children: [
              RiveAnimation.asset(
                'assets/RiveAssets/button.riv',
                controllers: [_btnAnimationcontroller],
              ),
              Positioned.fill(
                top: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.arrow_right_alt),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Start the course',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
