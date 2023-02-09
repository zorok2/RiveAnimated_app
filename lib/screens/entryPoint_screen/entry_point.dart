import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/constants.dart';
import 'package:rive_animation/screens/home_screen/home_page.dart';
import 'package:rive_animation/utils/rive_utils.dart';
import 'package:rive_animation/widgets/slide_menu.dart';

import '../../model/rive_model.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  RiveAssets selectedBottomNav = bottomNavs.first;
  late SMIBool userTigger;
  late SMIBool sideBarClosed;
  bool isSlideMenuclosed = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff17023A),
      body: Stack(
        children: [
          AnimatedPositioned(
              left: isSlideMenuclosed ? -288 : 0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              width: 288,
              height: MediaQuery.of(context).size.height,
              child: const SlideMenu()),
          Transform.translate(
              offset: Offset(isSlideMenuclosed ? 0 : 288, 0),
              child: Transform.scale(
                  scale: isSlideMenuclosed ? 1 : 0.8,
                  child: const ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      child: HomePage()))),
          MenuButton(
            press: () {
              sideBarClosed.value = !sideBarClosed.value;
              setState(() {
                isSlideMenuclosed = sideBarClosed.value;
              });
              // sideBarClosed.change(true);
              // Future.delayed(
              //   const Duration(seconds: 1),
              //   () => sideBarClosed.change(!true),
              // );
            },
            riveOninit: (artboard) {
              StateMachineController controller = RiveUtils.getRiveController(
                  artboard,
                  stateMachineName: 'State Machine');
              sideBarClosed = controller.findSMI('isOpen') as SMIBool;
              sideBarClosed.value = true;
            },
          )
        ],
      ),
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

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key? key,
    required this.press,
    required this.riveOninit,
  }) : super(key: key);
  final VoidCallback press;
  final ValueChanged<Artboard> riveOninit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press,
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, 3), blurRadius: 8)
              ]),
          child: RiveAnimation.asset(
            'assets/RiveAssets/menu_button.riv',
            onInit: riveOninit,
          ),
        ),
      ),
    );
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
