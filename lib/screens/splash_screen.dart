import 'package:cancerdetection/screens/login_screen.dart';
import 'package:cancerdetection/utils/custom_navbar.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart'; // Import your HomeScreen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait for 3 seconds and then navigate to HomeScreen
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff8AABBF),
        body: Column(
          children: [
            SizedBox(height: 60),
            // Text at the top
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Empowering early cancer detection with AI precision—saving lives, one scan at a time.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1F4C6B),
                  ),
                ),
              ),
            ),
            // Image at the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset("assets/—Pngtree—a robot is docter_16323861 (1) (1).png"), // Ensure correct asset path
            ),
          ],
        ),
      ),
    );
  }
}
