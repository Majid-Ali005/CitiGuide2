import 'package:citi_guide/api_gogole.dart';
import 'package:citi_guide/screens/Admin/admin.dart';
import 'package:citi_guide/screens/Admin/admin_dashboard.dart';
import 'package:citi_guide/screens/Admin/fetchData.dart';
import 'package:citi_guide/screens/Cities/cities.dart';
import 'package:citi_guide/screens/CityDestinations/cityDestinations.dart';
import 'package:citi_guide/screens/Dashboard/dashboard.dart';
import 'package:citi_guide/screens/Login/login.dart';
import 'package:citi_guide/screens/SearchScreen/searchScreen.dart';
import 'package:citi_guide/screens/SignUpPages/signUp1.dart';
import 'package:citi_guide/screens/SignUpPages/signUp2.dart';
import 'package:citi_guide/screens/SplashScreens/firstSplashScreen.dart';
import 'package:citi_guide/screens/add_city_screen.dart';
import 'package:citi_guide/screens/city_list_screen.dart';
import 'package:citi_guide/screens/map/map_page.dart';
import 'package:citi_guide/screens/profile/profile.dart';
import 'package:citi_guide/slider_screen.dart';
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
      // home: firstSplashScreen(),
      // home: const Dashboard(userId: "1", email: "ali@gmail.com", username: "ali", profile: "no"),
      home: AdminDashboard(),
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
