import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/model/rive_model.dart';
import 'package:rive_animation/utils/rive_utils.dart';
import 'package:rive_animation/widgets/info_card.dart';
import 'package:rive_animation/widgets/slideMenu_tile.dart';

import '../model/menu.dart';

class SlideMenu extends StatefulWidget {
  const SlideMenu({super.key});

  @override
  State<SlideMenu> createState() => _SlideMenuState();
}

class _SlideMenuState extends State<SlideMenu> {
  RiveAssets selectedmenu = slideMenu.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: false,
          child: Container(
            width: 288,
            height: double.infinity,
            color: const Color(0xff17023A),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const InfoCard(),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  'Browse'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...slideMenu
                  .map(
                    (menu) => SlideMenuTile(
                      menu: menu,
                      riveOninit: (artboard) {
                        StateMachineController controller =
                            RiveUtils.getRiveController(artboard,
                                stateMachineName: menu.stateMachineName);
                        menu.input = controller.findSMI("active") as SMIBool;
                      },
                      press: () {
                        menu.input!.change(true);
                        Future.delayed(
                          const Duration(seconds: 1),
                          () => menu.input!.change(false),
                        );
                        setState(() {
                          selectedmenu = menu;
                        });
                      },
                      active: selectedmenu == menu,
                    ),
                  )
                  .toList(),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  'history'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...slideMenu2
                  .map(
                    (menu) => SlideMenuTile(
                      menu: menu,
                      riveOninit: (artboard) {
                        StateMachineController controller =
                            RiveUtils.getRiveController(artboard,
                                stateMachineName: menu.stateMachineName);
                        menu.input = controller.findSMI("active") as SMIBool;
                      },
                      press: () {
                        menu.input!.change(true);
                        Future.delayed(
                          const Duration(seconds: 1),
                          () => menu.input!.change(false),
                        );
                        setState(() {
                          selectedmenu = menu;
                        });
                      },
                      active: selectedmenu == menu,
                    ),
                  )
                  .toList(),
            ]),
          )),
    );
  }
}
