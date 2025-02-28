
import 'package:citi_guide/screens/Admin/Admin_Login.dart';
import 'package:citi_guide/screens/Admin/admin_dashboard.dart';
import 'package:citi_guide/screens/Dashboard/dashboard.dart';
import 'package:citi_guide/screens/Login/login.dart';
import 'package:citi_guide/screens/SignUpPages/signUp2.dart';
import 'package:citi_guide/screens/SplashScreens/firstSplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const CitiGuide());
}

class CitiGuide extends StatelessWidget {
  const CitiGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //  home: firstSplashScreen(),
       home: const Dashboard(userId: "1", email: "ali@gmail.com", username: "ali", profile: "no"),
      // home: LoginPage(),
      // home: PlaceList(),
      // home: Login(),
      // home: AdminDashboard(),
      // home: AdminScreen(userId: "ali", email: "ali", username: "ali", profile: "abc"),
      // home: CityListScreen(),
      // home: AdminScreen(userId: "1", email: "ali@gmail.com", username: "abc", profile: "abc"),
      // home: MapScreen(),
      // home: SliderScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //Beneath colorScheme is used for background color setting of app
        colorScheme: const ColorScheme.light(
          surface: Colors.white,
        ),
      ),
      routes: {
        // '/home': (context) => Dashboard(),
        '/login': (context) => const Login(),
        '/signup': (context) => const SignUp2(),
      },
    );
  }
}
