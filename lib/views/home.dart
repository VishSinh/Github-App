import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:github_app/controllers/username.dart';
import 'package:github_app/helpers/components.dart';
import 'package:github_app/helpers/consts.dart';
import 'package:github_app/helpers/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UsernameController usernameCtlr = Get.find<UsernameController>();

  void _handleSubmit() async {
    if (usernameCtlr.username.value.isEmpty) {
      snackbarShowWarning('Username field can\'t be empty');
    } else {
      try {
        usernameCtlr.ctaState.value = CTAState.disabled;
        await usernameCtlr.handleSubmit();
      } on Exception catch (e) {
        snackbarShowWarning(e.toString());
      } finally {
        usernameCtlr.ctaState.value = CTAState.enabled;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      purpleVar3,
      magentaMedium,
      blueMedium,
      tealLightest,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 20.0,
      fontFamily: 'Horizon',
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/logo-github.png', height: 100.0, width: 100.0),
            SizedBox(height: Get.height / 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Enter your ', style: TextStyle(fontSize: 20.0)),
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'Github',
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                ),
                const Text(' username', style: TextStyle(fontSize: 20.0)),
              ],
            ),
            SizedBox(height: Get.height / 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => usernameCtlr.setUsername(value),
                decoration: textDecor('', 'Username'),
              ),
            ),
            SizedBox(height: Get.height / 50),
            InkWell(
              onTap: _handleSubmit,
              child: Obx(
                () => button(
                  usernameCtlr.ctaState.value == CTAState.disabled
                      ? const SpinKitPulse(color: Colors.white, size: 20.0)
                      : const Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
