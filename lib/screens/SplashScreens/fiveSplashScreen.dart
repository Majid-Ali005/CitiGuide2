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
  bool isDarkMode = false; // Track the theme state

  @override
  void initState() {
    super.initState();

    // Detect system brightness initially
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isDarkMode = Theme.of(context).brightness == Brightness.dark;
      });
    });

    // Create AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 0),
    );

    // Create a curved animation
    CurvedAnimation curve =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

    // Create a Tween to define the begin and end values for the animation
    Tween<Offset> tween = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero);

    // Apply the tween and the curved animation to get the final animation
    _slideAnimation = tween.animate(curve);

    // Start the animation after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white, // Dynamic background
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode; // Toggle dark/light mode
              });
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black, // Dynamic text color
            ),
          ),
          Text(
            "Explore. Discover. Navigate – Your Smart City Guide!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
          Center(
            child: Image.asset(
              Constants.appLogo,
              width: 250,
              height: 250,
            ),
          ),
          const SizedBox(height: 40),
          SlideTransition(
            position: _slideAnimation,
            child: BlueButton(
              topBottomPadding: 15,
              leftRightPadding: 20,
              widget_: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "Let's Explore",
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              OntapFunction: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp1()),
                );
              },
              topBottomMargin: 0,
              leftRightMargin: 20, onSelected: null,
            ),
          ),
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
