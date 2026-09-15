import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ImageSliderFirebase extends StatefulWidget {
  const ImageSliderFirebase({super.key});

  @override
  State<ImageSliderFirebase> createState() => _ImageSliderFirebaseState();
}

class _ImageSliderFirebaseState extends State<ImageSliderFirebase> {
  late Stream<QuerySnapshot> imageStream;
  int currentSlideIndex = 0;
  

  @override
  void initState() {
    super.initState();
    imageStream = FirebaseFirestore.instance.collection("Image_Slider").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: StreamBuilder<QuerySnapshot>(
              stream: imageStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  return CarouselSlider.builder(
                    
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index, realIdx) {
                      DocumentSnapshot sliderImage = snapshot.data!.docs[index];
                      return Image.network(
                        sliderImage['img'], // Make sure the field name is correct
                        fit: BoxFit.contain,
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentSlideIndex = index;
                        });
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error loading images'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Current Slide Index: $currentSlideIndex',
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
