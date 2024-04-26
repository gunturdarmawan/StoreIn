import 'package:flutter/material.dart';

import '../theme/style.dart';
import 'home.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
              Column(
                children: [
                  SizedBox(
                    width: 120,
                      height: 120,
                      child: Image.asset('lib/asset/images/Kidvera.png')
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                ],
              ),
            // nama app
              const Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  "We deliver everythings at your doorstep",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "inter",
                    height: 1.5,
                    fontSize: 40,
                  ),
                ),
              ),
            const SizedBox(height: 10,),
            Text(
              "Develop by Guntur Darmawan",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColor.secondarySoft
              ),
            ),
            const SizedBox(height: 50,),
            // get started buttons
            GestureDetector(
              onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context){
                    return const HomePage();
                  })),
              child: Container (
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(12)
                ),
                padding: const EdgeInsets.all(20),
                child: const Text(
                  "Get Started as Guest",
                  style: TextStyle(
                    color: Colors.white
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