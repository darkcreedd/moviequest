import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moviequest/screens/signin_screen.dart';
import 'package:moviequest/utils/colors.dart';

import '../custom_widgets/social_login_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool passwordIsVisible = false;
  bool passwordIsVisible1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.dark1,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Create a Movie Quest account',
              style: TextStyle(color: KColors.pyellow, fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 30, 20, 10),
              child: SizedBox(
                height: 55,
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey[400],
                    ),
                    hintText: 'E-mail',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    fillColor: KColors.lblue,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 5),
              child: SizedBox(
                height: 55,
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  obscureText: !passwordIsVisible,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.grey[400],
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          passwordIsVisible = !passwordIsVisible;
                        });
                      },
                      child: Icon(
                        (passwordIsVisible)
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        size: 20,
                        color: Colors.grey[400],
                      ),
                    ),
                    hintText: 'Create Password',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    fillColor: KColors.lblue,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
              child: SizedBox(
                height: 55,
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  obscureText: !passwordIsVisible1,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.grey[400],
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          passwordIsVisible1 = !passwordIsVisible1;
                        });
                      },
                      child: Icon(
                        (passwordIsVisible1)
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        size: 20,
                        color: Colors.grey[400],
                      ),
                    ),
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    fillColor: KColors.lblue,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInPage(),
                            ));
                      },
                      child: const Text('Already have an account? Login')),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: KColors.lblue1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: const Size(350, 53)),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInPage(),
                    ));
              },
              child: const Text(
                'Create Account',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 2,
                      // width: 100,
                      color: KColors.pyellow,
                    ),
                  ),
                  Text(
                    '  OR using  ',
                    style: TextStyle(color: KColors.pyellow, fontSize: 14),
                  ),
                  Expanded(
                    child: Container(
                      height: 2,
                      // width: 100,
                      color: KColors.pyellow,
                    ),
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SocialLoginButton(
                  icon: FontAwesomeIcons.googlePlusG,
                ),
                SocialLoginButton(
                  icon: FontAwesomeIcons.instagram,
                ),
                SocialLoginButton(
                  icon: FontAwesomeIcons.facebookF,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
