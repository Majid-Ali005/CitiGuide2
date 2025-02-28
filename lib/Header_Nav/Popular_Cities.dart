import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double rating;
  final int reviews;

  const PlaceCard({super.key, 
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.rating,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    
    return Card(
      
      elevation: 5, // Add elevation for shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image with Title
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          // Description
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
          // Rating and Reviews
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20),
                SizedBox(width: 5),
                Text(
                  rating.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  "($reviews reviews)",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          // See Details Button
          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the details screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaceDetailsScreen(
                      imageUrl: imageUrl,
                      title: title,
                      description: description,
                      rating: rating,
                      reviews: reviews,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFADA5EFF), // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "See Details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceDetailsScreen extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double rating;
  final int reviews;

  const PlaceDetailsScreen({super.key, 
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.rating,
    required this.reviews,
  });

  @override
  _PlaceDetailsScreenState createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  final TextEditingController _reviewController = TextEditingController();
  double _userRating = 0;
  final List<Map<String, dynamic>> _userReviews = [];

  void _submitReview() {
    if (_reviewController.text.isNotEmpty && _userRating > 0) {
      setState(() {
        _userReviews.add({
          "comment": _reviewController.text,
          "rating": _userRating,
        });
        _reviewController.clear();
        _userRating = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            // Title
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            // Rating and Reviews
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20),
                SizedBox(width: 5),
                Text(
                  widget.rating.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  "(${widget.reviews + _userReviews.length} reviews)",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Description
            Text(
              widget.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            // Add Review Section
            Text(
              "Add a Review",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            // Star Rating
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _userRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      _userRating = index + 1;
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 10),
            // Review Comment
            TextField(
              controller: _reviewController,
              decoration: InputDecoration(
                labelText: "Write your review",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 10),
            // Submit Review Button
            ElevatedButton(
              onPressed: _submitReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Submit Review",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 20),
            // User Reviews
            Text(
              "User Reviews",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            // Display User Reviews
            Column(
              children: _userReviews.map((review) {
                return Card(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Star Rating
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < review["rating"] ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: 20,
                            );
                          }),
                        ),
                        SizedBox(height: 5),
                        // Review Comment
                        Text(
                          review["comment"],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}



class PopularCitiesList extends StatelessWidget {
  const PopularCitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      
      padding: EdgeInsets.all(16),
      children: [
        
        PlaceCard(
          imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmnGeUKb-sM8TEG4Df4emTcUNPORhbHA8d8Q&s",
          title: "Karachi City of Lights",
          description: "Karachi is the city of lights and the city of love.",
          rating: 4.5,
          reviews: 120,
        ),
        SizedBox(height: 16),
        PlaceCard(
          
          imageUrl: "https://blog.pressreader.com/hs-fs/hubfs/woman-eating-breakfast-in-the-hotel-room.jpg?width=830&name=woman-eating-breakfast-in-the-hotel-room.jpg",
          title: "Islamabad Capital City",
          description: "Islamabad is the capital city of Pakistan.",
          rating: 4.8,
          reviews: 200,
        ),
        SizedBox(height: 16),
        PlaceCard(
          imageUrl: "https://thumbs.dreamstime.com/b/winter-holiday-luxury-modern-glass-igloo-hotel-ai-generated-content-design-background-instagram-facebook-wall-painting-323151321.jpg",
          title: "Lahore City of Gardens",
          description: "Lahore is the city of gardens and the city of love.",
          rating: 4.7,
          reviews: 150,
        ),
        SizedBox(height: 16),
        PlaceCard(
          imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHM113_guPJwg-hmK-mKzlYlF9WEppg9qXxDiSIH0ebAJMPGr5u4ShNxTGieQ7JYt6oA4&usqp=CAU",
          title: "Peshawar City of Flowers",
          description: "peshwar is the city of flowers and the city of love.",
          rating: 4.9,
          reviews: 300,
        ),
        SizedBox(height: 16),
        PlaceCard(
          imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmnGeUKb-sM8TEG4Df4emTcUNPORhbHA8d8Q&s",
          title: "Murree City of Mountains",
          description: "Murree is the city of mountains and the city of love.",
          rating: 4.6,
          reviews: 180,
        ),
      ],
    );
  }
}