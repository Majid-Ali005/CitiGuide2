import 'package:citi_guide/Constants/constants.dart';

import 'package:citi_guide/Header_Nav/Detialss.dart';
import 'package:citi_guide/Header_Nav/Eventss.dart';
import 'package:citi_guide/Header_Nav/Popular_Cities.dart';
import 'package:citi_guide/Header_Nav/Restaurant.dart';
import 'package:citi_guide/screens/Cities/cities.dart';
import 'package:citi_guide/screens/Details/details.dart';
import 'package:citi_guide/screens/SearchScreen/searchScreen.dart';
import 'package:citi_guide/screens/SignOut/signOut.dart';
import 'package:citi_guide/screens/profile/profile.dart';
import 'package:citi_guide/slider_screen.dart';
import 'package:citi_guide/widgets/blueButton.dart';
import 'package:citi_guide/widgets/card.dart';
import 'package:citi_guide/widgets/destinationCards.dart';
import 'package:citi_guide/widgets/greyButton.dart';
import 'package:citi_guide/widgets/transparentButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';

// This is for carousel
final List<String> imageUrls = [
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmhQ3UgaT_ovzTfqfkMReEJPbotBbjIC8vzQ&s",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrD3Y9CSgQdO4lcZaHBgpDUyyinpL9q14Qtw&s",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqgdJxsHRjOpeGUbdGUn5h8ryQFxMJiLdOYQ&s",
];

class Dashboard extends StatefulWidget {
  final String userId;
  final String email;
  final String username;
  final String profile;

  const Dashboard({super.key, required this.userId, required this.email, required this.username, required this.profile});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;

  // Asynchronous function to fetch URLs
  Future<List<Widget>> fetchPC() async {
    // Fetching document data from Firestore
    var docSnapshot = await FirebaseFirestore.instance.collection('destinationDetails').doc("wWuqSjoeHtre6w8hegIN").get();

    if (!docSnapshot.exists) {
      return []; // Return empty list if document doesn't exist
    }

    var data = docSnapshot.data();
    String dID = docSnapshot.id;

    // Fetching image URL from Firebase Storage
    final ref = FirebaseStorage.instance.ref().child('locations/$dID');
    var url = await ref.getDownloadURL();

    return [
      GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DestinationDetails(destinationID: dID, url: url)));
        },
        child: CityImgCard(
          Widthcard: double.infinity,
          ImgHeight: 300,
          OpacityHeight: 50,
          firstOpacityDivRow: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                child: Text(
                  data?['locationName'] ?? 'Unknown Location',
                  style: TextStyle(
                    color: Constants.greyColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          secondOpacityDivRow: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TransparentButton(
                  OpacitySet: 0.1,
                  topBottomPadding: 2,
                  leftRightPadding: 7,
                  widget_: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Constants.greyColor,
                        size: 10,
                      ),
                      Text(
                        data?['city'] ?? 'Unknown City',
                        style: TextStyle(
                          fontSize: 10,
                          color: Constants.greyColor,
                        ),
                      ),
                    ],
                  ),
                  OntapFunction: () {},
                  topBottomMargin: 2,
                  leftRightMargin: 0,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: TransparentButton(
                  OpacitySet: 0.1,
                  topBottomPadding: 2,
                  leftRightPadding: 7,
                  widget_: Row(
                    children: [
                      Text(
                        '${data?['distance'] ?? 'Unknown Distance'}',
                        style: TextStyle(
                          fontSize: 10,
                          color: Constants.greyColor,
                        ),
                      ),
                    ],
                  ),
                  OntapFunction: () {},
                  topBottomMargin: 2,
                  leftRightMargin: 0,
                ),
              ),
            ],
          ),
          OpacityAboveRemainingHeightForMargin: 250,
          cityImg: url,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Navigation Bar
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: ListView(children: [
          // const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DropdownMenu<Color>(
                width: 150,
                hintText: "Profile",
                leadingIcon: Icon(Icons.person, color: Colors.black), // Icon on the left
                menuStyle: MenuStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.transparent), // Optional: Make menu transparent
                  elevation: WidgetStateProperty.all(0), // Removes shadow
                ),
                inputDecorationTheme: InputDecorationTheme(
                  border: InputBorder.none, // ✅ Removes the outline
                  enabledBorder: InputBorder.none, // ✅ Removes enabled border
                  focusedBorder: InputBorder.none, // ✅ Removes focused border
                ),
                onSelected: (Color? value) {
                  if (value == Colors.red) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          userId: widget.userId,
                          email: widget.email,
                          username: widget.username,
                          profile: widget.profile,
                        ),
                      ),
                    );
                  } else if (value == Colors.green) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignOutScreen(), // Navigate to Settings screen
                      ),
                    );
                  }
                },
                dropdownMenuEntries: <DropdownMenuEntry<Color>>[
                  DropdownMenuEntry(
                    value: Colors.red,
                    label: "Edit Profile",
                  ),
                  DropdownMenuEntry(
                    value: Colors.green,
                    label: "Sign Out",
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(19)),
                  border: Border.all(
                    color: Constants.greyColor,
                  ),
                ),
                margin: const EdgeInsets.only(right: 20, bottom: 5, top: 5),
              
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  const Text(
                    "Welcome To Majid Citi Guider App",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, ),
                  ),
                  // Text(
                  //   widget.username,
                  //   style: const TextStyle(fontWeight: FontWeight.w400),
                  //   textAlign: TextAlign.left,
                  // ),
                ],
              ),
            ],
          ),

          // This is the drop down list
          

          // Searchbar row
          Container(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: true, // Set readOnly to true to prevent typing
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(
                            userId: widget.userId,
                            email: widget.email,
                            username: widget.username,
                            profile: widget.profile,
                          ),
                        ),
                      );
                    },
                    cursorColor: Constants.greyTextColor,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: Colors.transparent,
                        ),
                      ),
                      filled: true,
                      helperText: "",
                      hintText: "Search Destination",
                      prefixIcon: Icon(
                        Icons.search,
                        color: Constants.greyTextColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Constants.buttonBorderRadius),
                        borderSide: BorderSide(color: Constants.greyColor),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: Constants.searchBarButtonHeight,
                      ),
                    ),
                    style: TextStyle(
                      color: Constants.greyTextColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 7,
          ),

          //header nav bar hy ye
           Row(
  mainAxisSize: MainAxisSize.min,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
   Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    InkWell(
      onTap: () {
        Navigator.push(
  context,
  MaterialPageRoute(builder: (context) =>  PlaceList()),
);
        print("Hotel tapped!");
      },
      borderRadius: BorderRadius.circular(10), // Match the container's border radius
      child: Card(
        elevation: 5, // Add elevation here
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color:Color(0xFADA5EFF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.hotel, size: 30, color: Colors.white),
        ),
      ),
    ),
    SizedBox(height: 5),
    Text(
      "Hotel",
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
    ),
  ],
),
    SizedBox(width: 30), // Add some spacing between the two columns
    Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    InkWell(
      onTap: () {
        Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => EventList()),
);
        print("Hotel tapped!");
      },
      borderRadius: BorderRadius.circular(10), // Match the container's border radius
      child: Card(
        elevation: 5, // Add elevation here
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color:Color(0xFADA5EFF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.event, size: 30, color: Colors.white),
        ),
      ),
    ),
    SizedBox(height: 5),
    Text(
      "Events",
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
    ),
  ],
),
    SizedBox(width: 30),
    Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    InkWell(
      onTap: () {
        Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => RestaurantList()),
);
        print("Hotel tapped!");
      },
      borderRadius: BorderRadius.circular(10), // Match the container's border radius
      child: Card(
        elevation: 5, // Add elevation here
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color:Color(0xFADA5EFF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.restaurant, size: 30, color: Colors.white),
        ),
      ),
    ),
    SizedBox(height: 5),
    Text(
      "Restaurants",
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
    ),
  ],
),
    SizedBox(width: 30),
   Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    InkWell(
      onTap: () {
        Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => PopularCitiesList()),
);
        print("Hotel tapped!");
      },
      borderRadius: BorderRadius.circular(10), // Match the container's border radius
      child: Card(
        elevation: 5, // Add elevation here
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color:Color(0xFADA5EFF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.location_city, size: 30, color: Colors.white),
        ),
      ),
    ),
    SizedBox(height: 5),
    Text(
      "Popular Cities",
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
    ),
  ],
),
    
    
  ],
),

          // This is the carousel
          Container(
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200, // Overall height of the card
                autoPlay: true, // Enable autoplay
                autoPlayCurve: Curves.easeInOut, // Autoplay animation curve
                aspectRatio: 16 / 9, // Aspect Ratio
                autoPlayAnimationDuration: const Duration(seconds: 2), // Slide duration
                enlargeCenterPage: true, // Effect to enlarge the center image
              ),
              items: imageUrls.map((imageUrl) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover, // Cover the whole card
                    width: double.infinity,
                  ),
                );
              }).toList(),
            ),
          ),
// two cards
          Container(
  padding: EdgeInsets.all(16.0),
  child: Row(
    children: [
      // Card 1
      Expanded(
        child: GestureDetector(
          onTap: () {
            // Define dID and url here or fetch them
            String dID = "your_destination_id";
            String url = "your_image_url";
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DestinationDetails(
                  destinationID: dID, // Pass your destination ID for Card 1
                  url: url, // Pass your URL for Card 1
                ),
              ),
            );
          },
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPIVIFMOOZUzJxTCrHU1-q3TM2egCkav4-rw&s',
                    height: 80,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nature',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Experience the beauty of nature.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      // Star Rating Icons
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          Icon(Icons.star_half, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text(
                            '4.5',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(width: 16), // Spacing between cards
      // Card 2
      Expanded(
        child: GestureDetector(
          onTap: () {
            // Define dID and url here or fetch them
            String dID = "your_destination_id";
            String url = "your_image_url";
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DestinationDetails(
                  destinationID: dID, // Pass your destination ID for Card 2
                  url: url, // Pass your URL for Card 2
                ),
              ),
            );
          },
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  child: Image.network(
                    'https://i.ytimg.com/vi/8txXRzBWzI0/maxresdefault.jpg',
                    height: 80,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cityscape',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Explore the vibrant city life.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      // Star Rating Icons
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          Icon(Icons.star_border, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text(
                            '4.0',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  ),
),

// One card
Container(
  padding: EdgeInsets.all(16.0),
  child: Card(
    elevation: 5.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPIVIFMOOZUzJxTCrHU1-q3TM2egCkav4-rw&s',
            height: 80,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nature',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Experience the beauty of nature.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8),
              // Star Rating Icons
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  SizedBox(width: 4),
                  Text(
                    '5.0',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
),

          // Two cards with onTap
         
        ]),
      ),

      // Navigation Bar
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 5, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          border: Border.all(
            color: Constants.whiteColor, // Set your border color
            width: 1.0, // Set your border width
          ),
          color: Constants.whiteColor,
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 25)],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: GNav(
            backgroundColor: Constants.whiteColor,
            color: Constants.greyTextColor,
            activeColor: Constants.whiteColor,
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              // Update the selected index
              setState(() {
                selectedIndex = index;
              });
              // Handle tab change
              if (index == 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Dashboard(
                            userId: widget.userId,
                            email: widget.email,
                            username: widget.username,
                            profile: widget.profile)));
              } else if (index == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CitiesScreen(
                            userId: widget.userId,
                            email: widget.email,
                            username: widget.username,
                            profile: widget.profile)));
              } else if (index == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchScreen(
                            userId: widget.userId,
                            email: widget.email,
                            username: widget.username,
                            profile: widget.profile)));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                            userId: widget.userId,
                            email: widget.email,
                            username: widget.username,
                            profile: widget.profile)));
              }
            },
            tabBackgroundColor: Constants.OrangeColor,
            gap: 8,
            padding: const EdgeInsets.all(11),
            tabs: const [
              GButton(icon: Icons.home, text: "Home"),
              GButton(icon: Icons.language, text: "Cities"),
              GButton(icon: Icons.search, text: "Search"),
              GButton(icon: Icons.supervised_user_circle_sharp, text: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}