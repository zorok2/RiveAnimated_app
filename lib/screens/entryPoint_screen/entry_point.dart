import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/constants.dart';
import 'package:rive_animation/screens/home_screen/home_page.dart';
import 'package:rive_animation/utils/rive_utils.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  RiveAssets selectedBottomNav = bottomNavs.first;
  late SMIBool userTigger;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomePage(),
      bottomNavigationBar: SafeArea(
          child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: backgroundColor2.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(24))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(bottomNavs.length, (index) {
              return itemsWidget(index);
            })
          ],
        ),
      )),
    );
  }

  GestureDetector itemsWidget(int index) {
    return GestureDetector(
      onTap: () {
        if (bottomNavs[index] != selectedBottomNav) {
          setState(() {
            selectedBottomNav = bottomNavs[index];
          });
        }
        bottomNavs[index].input!.change(true);
        Future.delayed(
          const Duration(seconds: 1),
          () {
            bottomNavs[index].input!.change(false);
          },
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 300),
            height: 4,
            width: selectedBottomNav == bottomNavs[index] ? 20 : 0,
            decoration: BoxDecoration(
                color: selectedBottomNav == bottomNavs[index]
                    ? const Color(0xff81B4ff)
                    : Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(14))),
          ),
          SizedBox(
              height: 36,
              width: 36,
              child: Opacity(
                opacity: bottomNavs[index] == selectedBottomNav ? 1 : 0.5,
                child: RiveAnimation.asset(
                  bottomNavs.first.src,
                  artboard: bottomNavs[index].artBoard,
                  onInit: (art) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(art,
                            stateMachineName:
                                bottomNavs[index].stateMachineName);
                    bottomNavs[index].setInput =
                        controller.findInput<bool>('active') as SMIBool;
                  },
                ),
              )),
        ],
      ),
    );
  }
}

class RiveAssets {
  final String src;
  final String artBoard, stateMachineName, title;
  late SMIBool? input;

  RiveAssets(this.src,
      {required this.artBoard,
      required this.stateMachineName,
      required this.title,
      this.input});
  set setInput(SMIBool input) {
    this.input = input;
  }
}

List<RiveAssets> bottomNavs = [
  RiveAssets("assets/RiveAssets/icons.riv",
      artBoard: "CHAT", stateMachineName: "CHAT_Interactivity", title: "Chat"),
  RiveAssets("assets/RiveAssets/icons.riv",
      artBoard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity",
      title: "Search"),
  RiveAssets("assets/RiveAssets/icons.riv",
      artBoard: "TIMER",
      stateMachineName: "TIMER_Interactivity",
      title: "Timer"),
  RiveAssets("assets/RiveAssets/icons.riv",
      artBoard: "BELL",
      stateMachineName: "BELL_Interactivity",
      title: "Notifications"),
  RiveAssets("assets/RiveAssets/icons.riv",
      artBoard: "USER",
      stateMachineName: "USER_Interactivity",
      title: "Profile"),
];
