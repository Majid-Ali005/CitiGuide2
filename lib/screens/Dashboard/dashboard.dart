// import 'dart:html';

import 'package:citi_guide/Constants/constants.dart';
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
import 'package:flutter/material.dart';
//this is for carousel
  final List<String> imageUrls = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReJvMyLzuWbkwTuh7NB_deC8X0sUqwrQdALA&s",
    "https://static.vecteezy.com/system/resources/thumbnails/023/929/823/small_2x/world-finally-in-peace-illustration-generative-ai-photo.jpg",
    "https://wallpapers.com/images/hd/travel-hd-4zjwrepl0mzn70nd.jpg",
  ];
//ye variable drop down list k liye hy.


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
                  builder: (context) =>
                       DestinationDetails(destinationID: dID, url: url)));
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
      //Navigation Bar

      body: Container(
         margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: ListView(children: [
          const SizedBox(height: 30),
          Row(
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
                child: ClipOval(
                  child: CircleAvatar(
                    radius: 26,
                    child: Image(
                      image: NetworkImage(widget.username),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcom To Majid Citi Guider App",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                  Text(
                    widget.username,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  ),
                  
                 
                ],
                
              )
              
            ],
            
          ),

        
          //this is the drop down list
          
          Row(
            
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Text("this is for drop down text"),
            DropdownMenu<Color>(
               width: 150,
  hintText: "Profile",
  leadingIcon: Icon(Icons.person, color: Colors.black), // Icon on the left
  menuStyle: MenuStyle(
    backgroundColor: MaterialStateProperty.all(Colors.transparent), // Optional: Make menu transparent
    elevation: MaterialStateProperty.all(0), // Removes shadow
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
    }
    else if (value == Colors.green) {
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
)


            ],
          ),


          // searchbar row //
          Container(
            child: Row(
              children: [
                Expanded(
                  child:TextField(
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
)

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

      //this is the carousle
      Container(
      child:CarouselSlider(
        options: CarouselOptions(
          height: 250, // Overall height of the card
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

       

          
Container(
  padding: EdgeInsets.all(16.0),
  child: Row(
    children: [
      
      // Card 1
      Expanded(
        
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
                  height: 150,
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
                  ],
                ),
              ),
            
            ],
          ),
          
        ),
      ),
      SizedBox(width: 16), // Spacing between cards
      // Card 2
      Expanded(
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
                  height: 150,
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
                  ],
                ),
              ),
            ],
          ),
        ),
        
      ),
    ],

    
  ),
),

//four cards


//one card

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
            height: 150,
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
            ],
          ),
        ),
      ],
    ),
  ),
),

//two card with ontape


          Column(
            children: [
              FutureBuilder<List<Widget>>(
       
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text(''));
          }

          return Column(
            children: snapshot.data!,
          );
        }, future: null,
      ),
            ],
          )
        ]),
      ),

      // Navigation Bar
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Constants.whiteColor, // Set your border color
            width: 1.0, // Set your border width
          ),
          color: Constants.whiteColor,
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 25)],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  Dashboard(userId: widget.userId, email: widget.email, username: widget.username, profile: widget.profile)));
              } else if (index == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  CitiesScreen(userId: widget.userId, email: widget.email, username: widget.username, profile: widget.profile)));
              } else if (index == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  SearchScreen(userId: widget.userId, email: widget.email, username: widget.username, profile: widget.profile)));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  ProfileScreen(userId: widget.userId, email: widget.email, username: widget.username, profile: widget.profile)));
              }
            },
            tabBackgroundColor: Constants.OrangeColor,
            gap: 8,
            padding: const EdgeInsets.all(11),
            tabs: const [
              GButton(icon: Icons.home, text: "Home 22"),
              GButton(icon: Icons.language, text: "Cities"),
              GButton(icon: Icons.search, text: "Search"),
              GButton(
                  icon: Icons.supervised_user_circle_sharp, text: "Profile"),
            ],
          ),
        ),
      ),
    
    );
  }
}
