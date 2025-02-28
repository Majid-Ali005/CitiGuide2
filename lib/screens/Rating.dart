import 'package:flutter/material.dart';



class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final List<Review> _reviews = [];
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 0;

  void _submitReview() {
    if (_reviewController.text.isNotEmpty && _rating > 0) {
      setState(() {
        _reviews.add(Review(
          comment: _reviewController.text,
          rating: _rating,
          likes: 0,
        ));
        _reviewController.clear();
        _rating = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Reviews and Ratings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Review Input Section
            TextField(
              controller: _reviewController,
              decoration: InputDecoration(
                labelText: 'Write your review',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 10),
            // Star Rating Section
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
            SizedBox(height: 10),
            // Submit Button
            ElevatedButton(
              onPressed: _submitReview,
              child: Text('Submit Review'),
            ),
            SizedBox(height: 20),
            // Display Reviews
            Expanded(
              child: ListView.builder(
                itemCount: _reviews.length,
                itemBuilder: (context, index) {
                  final review = _reviews[index];
                  return ReviewItem(review: review);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Review {
  final String comment;
  final double rating;
  int likes;

  Review({required this.comment, required this.rating, this.likes = 0});
}

class ReviewItem extends StatefulWidget {
  final Review review;

  const ReviewItem({super.key, required this.review});

  @override
  _ReviewItemState createState() => _ReviewItemState();
}

class _ReviewItemState extends State<ReviewItem> {
  bool _isLiked = false;

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked) {
        widget.review.likes++;
      } else {
        widget.review.likes--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Star Rating
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < widget.review.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 20,
                );
              }),
            ),
            SizedBox(height: 8),
            // Review Text
            Text(
              widget.review.comment,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            // Like Button
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    _isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                    color: _isLiked ? Colors.blue : Colors.grey,
                  ),
                  onPressed: _toggleLike,
                ),
                Text('${widget.review.likes} Likes'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}