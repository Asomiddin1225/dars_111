import 'package:flutter/material.dart';
import 'package:recipe_app/ui/screens/splash/splash_screen2.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/image/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Color(0xff3FB4B1)
                .withOpacity(0.5), // Green tint with transparency
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  color: Colors.white,
                  "assets/image/meals_on_demand_picture.png",
                  width: 300,
                  height: 200,
                ),
                const Text(
                  "Meals On \n Demand",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(
                        Size(209, 62)), // Set width and height
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Set border radius
                    )),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const SplashScreen2(),
                      ),
                    );
                  },
                  child: const Text(
                    "Let's start",
                    style: TextStyle(fontSize: 16), // Optional: set text size
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
