import 'package:citi_guide/Constants/constants.dart';
import 'package:citi_guide/screens/map/map_page.dart';
import 'package:citi_guide/widgets/blueButton.dart';
import 'package:citi_guide/widgets/card.dart';
import 'package:citi_guide/widgets/transparentButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DestinationDetails extends StatelessWidget {
  final String destinationID;
  final String url;
  const DestinationDetails(
      {super.key, required this.destinationID, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('destinationDetails')
            .doc(destinationID)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          var doc = snapshot.data!;
          var data = doc.data();
          String docId = doc.id;
          String locationString = data!['location'];
          List<String> latLngList = locationString.split(',');
          double latitude = double.parse(latLngList[0]);
          double longitude = double.parse(latLngList[1]);

          return Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  // Existing Content
                  Container(
                    child: CityImgCard(
                      Widthcard: double.infinity,
                      ImgHeight: 270,
                      OpacityHeight: 70,
                      firstOpacityDivRow: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6, left: 10),
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
                                    data['city'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Constants.greyColor,
                                    ),
                                  ),
                                ],
                              ),
                              OntapFunction: () {
                                print("navigation button");
                              },
                              topBottomMargin: 2,
                              leftRightMargin: 0,
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 6, right: 10),
                            child: TransparentButton(
                              OpacitySet: 0.1,
                              topBottomPadding: 3,
                              leftRightPadding: 7,
                              widget_: Row(
                                children: [
                                  Text(
                                    data['distance'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Constants.greyColor,
                                    ),
                                  ),
                                ],
                              ),
                              OntapFunction: () {
                                print("navigation button");
                              },
                              topBottomMargin: 2,
                              leftRightMargin: 0,
                            ),
                          ),
                        ],
                      ),
                      secondOpacityDivRow: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 3),
                            child: Text(
                              data['locationName'],
                              style: TextStyle(
                                color: Constants.greyColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      OpacityAboveRemainingHeightForMargin: 200,
                      cityImg: url,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      data['locationName'],
                      style: TextStyle(
                        color: Constants.OrangeColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      data['description'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      //first column
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.route_sharp,
                                color: Constants.OrangeColor,
                              ),
                              const Text(
                                "Distance",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                data['distance'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      //second column
                      const Spacer(),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_sharp,
                                color: Constants.OrangeColor,
                              ),
                              const Text(
                                "Opening Hours",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                data['timings'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.phone_in_talk_outlined,
                            color: Constants.OrangeColor,
                          ),
                          const Text(
                            "Contact Number",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "         ${data['distance']}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Map Section
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapPage(
                            longitudeDetected: longitude,
                            latitudeDetected: latitude,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(60),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 2)
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Constants.greyColor,
                          ),
                          child: Image.asset(
                            'assets/images/map.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  BlueButton(
                    topBottomPadding: 10,
                    leftRightPadding: 30,
                    widget_: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Let's Go",
                          style: TextStyle(
                            color: Constants.whiteColor,
                          ),
                        ),
                        Icon(
                          Icons.arrow_outward_rounded,
                          color: Constants.whiteColor,
                        ),
                      ],
                    ),
                    OntapFunction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapPage(
                            longitudeDetected: longitude,
                            latitudeDetected: latitude,
                          ),
                        ),
                      );
                    },
                    topBottomMargin: 10,
                    leftRightMargin: 90,
                    onSelected: null,
                  ),

                  // Reviews Section
                  const SizedBox(height: 20),
                  Text(
                    "User Reviews",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Constants.OrangeColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('destinationDetails')
                        .doc(destinationID)
                        .collection('reviews')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      var reviews = snapshot.data!.docs;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: reviews.length,
                        itemBuilder: (context, index) {
                          var review = reviews[index].data() as Map<String, dynamic>;
                          return ReviewItem(
                            comment: review['comment'],
                            rating: review['rating'],
                            likes: review['likes'] + 1,
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  AddReviewSection(destinationID: destinationID),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final String comment;
  final double rating;
  final int likes;

  const ReviewItem({super.key, 
    required this.comment,
    required this.rating,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 20,
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(
              comment,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up),
                  onPressed: () {
                    // Add like functionality
                  },
                ),
                Text('$likes Likes'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddReviewSection extends StatefulWidget {
  final String destinationID;

  const AddReviewSection({super.key, required this.destinationID});

  @override
  _AddReviewSectionState createState() => _AddReviewSectionState();
}

class _AddReviewSectionState extends State<AddReviewSection> {
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 0;

  void _submitReview() {
    if (_reviewController.text.isNotEmpty && _rating > 0) {
      FirebaseFirestore.instance
          .collection('destinationDetails')
          .doc(widget.destinationID)
          .collection('reviews')
          .add({
        'comment': _reviewController.text,
        'rating': _rating,
        'likes': 0,
      });
      _reviewController.clear();
      _rating = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _reviewController,
          decoration: const InputDecoration(
            labelText: 'Write your review',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 10),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < _rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: () {
                setState(() {
                  _rating = index + 1;
                });
              },
            );
          }),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _submitReview,
          child: const Text('Submit Review'),
        ),
      ],
    );
  }
}