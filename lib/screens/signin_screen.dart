import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moviequest/screens/landing_screen.dart';
import 'package:moviequest/screens/password_reset_screen.dart';
import 'package:moviequest/screens/signup_screen.dart';
import 'package:moviequest/utils/colors.dart';

import '../custom_widgets/social_login_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool passwordIsVisible = false;
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
              'Log in to Movie Quest',
              style: TextStyle(color: KColors.pyellow, fontSize: 26),
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
                    hintText: 'Password',
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
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ));
                      },
                      child: const Text('New here? Create an account')),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PasswordResetPage(),
                            ));
                      },
                      child: const Text('Forgot Password'))
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
                      builder: (context) => const LandingPage(),
                    ));
              },
              child: const Text(
                'Login',
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
