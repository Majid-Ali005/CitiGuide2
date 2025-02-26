import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  final List<String> imageUrls = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReJvMyLzuWbkwTuh7NB_deC8X0sUqwrQdALA&s",
    "https://static.vecteezy.com/system/resources/thumbnails/023/929/823/small_2x/world-finally-in-peace-illustration-generative-ai-photo.jpg",
    "https://wallpapers.com/images/hd/travel-hd-4zjwrepl0mzn70nd.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: CarouselSlider(
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
    );
  }
}
