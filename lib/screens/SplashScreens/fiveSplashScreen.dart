import 'package:citi_guide/Constants/constants.dart';
import 'package:citi_guide/screens/SignUpPages/signUp1.dart';
import 'package:citi_guide/widgets/blueButton.dart';
import 'package:flutter/material.dart';

class FifthSplashScreen extends StatefulWidget {
  const FifthSplashScreen({super.key});

  @override
  State<FifthSplashScreen> createState() => _FifthSplashScreenState();
}

class _FifthSplashScreenState extends State<FifthSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Create AnimationController
    _animationController = AnimationController(
      vsync: this, // Pass 'this' since _FifthSplashScreenState mixes in TickerProviderStateMixin
      duration: Duration(seconds: 1),
    );

    // Create a curved animation
    CurvedAnimation curve =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

    // Create a Tween to define the begin and end values for the animation
    Tween<Offset> tween = Tween(begin: Offset(1.0, 0.0), end: Offset.zero);

    // Apply the tween and the curved animation to get the final animation
    _slideAnimation = tween.animate(curve);

    // Start the animation after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("Explore. Discover. Navigate – Your Smart City Guide!",
           style: TextStyle(
              fontSize: 18,
              
            ),),
          Center(
            child: Image.asset(
              Constants.appLogo,
              width: 250, // Set your desired width
              height: 250, // Set your desired height
            ),
          ),
          SizedBox(height: 40),
          SlideTransition(
            position: _slideAnimation,
            child: BlueButton(
              topBottomPadding: 15,
              leftRightPadding: 20,
              widget_: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10), // Optional padding
                decoration: BoxDecoration(
                  // color: Colors.yellow, // Background color
                  borderRadius: BorderRadius.circular(5), // Optional rounded corners
              
                ),
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              OntapFunction: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp1()),
                );
              },
              topBottomMargin: 0,
              leftRightMargin: 20,
            ),
          ), // <- This was missing a closing parenthesis
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
