import 'package:english/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigate() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }

  @override
  void initState() {
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 155, 150),
      body: ListView(children: const [
        Image(image: AssetImage('assets/images/splsh.png')),
        SizedBox(height: 80),
        Center(
          child: Text("TemariCO",
              style: TextStyle(fontSize: 36, color: Colors.white)),
        ),
        CircularProgressIndicator(
          color: Colors.orangeAccent,
          // value: 0.1,
          strokeWidth: 10,
        )
      ]),
    );
  }
}
