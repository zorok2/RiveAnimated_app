import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/screens/entryPoint_screen/entry_point.dart';
import '../../../utils/rive_utils.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);
  static final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  bool isShowloading = false;
  bool isShowCompeti = false;
  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1")!;
    artboard.addController(controller);
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Form(
                key: SignInForm.formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(color: Colors.black54),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: SvgPicture.asset('assets/icons/email.svg'),
                        )),
                      ),
                    ),
                    const Text(
                      'Password',
                      style: TextStyle(color: Colors.black54),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: SvgPicture.asset('assets/icons/password.svg'),
                        )),
                      ),
                    )
                  ],
                )),
            isShowloading
                ? Positioned.fill(
                    child: Center(
                    child: SizedBox(
                        height: 100,
                        width: 100,
                        child: RiveAnimation.asset(
                          'assets/RiveAssets/check.riv',
                          onInit: (artboard) {
                            StateMachineController controller =
                                RiveUtils.getRiveController(artboard);
                            check = controller.findSMI("Check") as SMITrigger;
                            error = controller.findSMI("Error") as SMITrigger;
                            reset = controller.findSMI("Reset") as SMITrigger;
                          },
                        )),
                  ))
                : const SizedBox(),
          ],
        ),
        ElevatedButton.icon(
            onPressed: () {
              setState(() {
                isShowloading = true;
              });
              Future.delayed(
                const Duration(seconds: 1),
                () {
                  if (SignInForm.formkey.currentState!.validate()) {
                    check.change(true);
                    Future.delayed(
                      const Duration(milliseconds: 2000),
                      () => setState(() {
                        isShowloading = false;
                      }),
                    );
                    Future.delayed(
                      const Duration(seconds: 2),
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EntryPoint(),
                            ));
                      },
                    );
                  } else {
                    error.fire();
                    Future.delayed(
                      const Duration(milliseconds: 2000),
                      () => setState(() {
                        isShowloading = false;
                      }),
                    );
                  }
                },
              );
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                )),
                backgroundColor: const Color(0xfff77d8e)),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text('Sign in')),
      ],
    );
  }
}
