import 'package:flutter/material.dart';
import 'package:moviequest/screens/signin_screen.dart';
import 'package:moviequest/utils/colors.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
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
              'Password Reset',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'A mail containing an OTP has to your [your_email]',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const Text(
              'Enter the code below',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 55,
              child: OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 60,
                style: const TextStyle(fontSize: 25),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                otpFieldStyle: OtpFieldStyle(
                    borderColor: KColors.lblue,
                    enabledBorderColor: KColors.dblue,
                    backgroundColor: Colors.white,
                    focusBorderColor: KColors.lblue),
                onCompleted: (pin) {
                  debugPrint("Completed: $pin");
                },
                onChanged: (value) {
                  debugPrint(value);
                },
              ),
            ),
            const SizedBox(
              height: 30,
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
                'Reset Password',
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
