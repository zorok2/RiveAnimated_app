// ignore_for_file: file_names
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class OnbodingScreen extends StatefulWidget {
  const OnbodingScreen({super.key});

  @override
  State<OnbodingScreen> createState() => _OnbodingScreenState();
}

class _OnbodingScreenState extends State<OnbodingScreen> {
  late RiveAnimationController _btnAnimationcontroller;
  @override
  void initState() {
    // TODO: implement initState
    _btnAnimationcontroller = OneShotAnimation("active");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                width: MediaQuery.of(context).size.width * 1.7,
                bottom: 100,
                left: 100,
                child: Image.asset('assets/Backgrounds/Spline.png')),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
                child: const SizedBox(),
              ),
            ),
            const RiveAnimation.asset(
              "assets/RiveAssets/shapes.riv",
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 25),
                child: const SizedBox(),
              ),
            ),
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  SizedBox(
                    width: 260,
                    child: Column(
                      children: const [
                        Text(
                          'Learn design & code',
                          style: TextStyle(
                              fontSize: 60, fontFamily: 'poppins', height: 1.2),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Don’t skip design. Learn design and code, by building real apps with Flutter and Swift. Complete courses about the best tools.",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 65,
                      width: 260,
                      child: Stack(
                        children: [
                          const RiveAnimation.asset(
                              'assets/RiveAssets/button.riv'),
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
                      ))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
