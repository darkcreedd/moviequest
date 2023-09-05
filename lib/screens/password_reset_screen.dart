import 'package:flutter/material.dart';
import 'package:moviequest/screens/otp_screen.dart';
import 'package:moviequest/screens/signin_screen.dart';
import 'package:moviequest/utils/colors.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
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
              'Forgot your Password?',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'No worries, we\'ve got your back ',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const Text(
              'Enter the e-mail you used to create your account',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const Text(
              'A link to reset your password will be sent to your email',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 15, 20, 10),
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
            const SizedBox(
              height: 10,
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
                      builder: (context) => const OTPPage(),
                    ));
              },
              child: const Text(
                'Verify E-mail',
                style: TextStyle(fontSize: 16),
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
                      child: const Text('Back to Sign in page')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
