import 'package:flutter/material.dart';

import '../utils/colors.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      height: 45,
      width: 70,
      decoration: BoxDecoration(
        color: KColors.lblue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        icon,
        color: Colors.grey[400],
      ),
    );
  }
}
