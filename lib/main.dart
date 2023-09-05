import 'package:flutter/material.dart';
import 'package:moviequest/screens/home_screen.dart';
import 'package:moviequest/screens/landing_screen.dart';
import 'package:moviequest/screens/onboarding_screen.dart';
import 'package:moviequest/statemanagement/dataclass.dart';
import 'package:provider/provider.dart';

main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => DataClass(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Sen'),
      home: SafeArea(child: const OnboardingScreen()),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/home': (context) => const HomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/main': (context) => const LandingPage(),
      },
    );
  }
}
