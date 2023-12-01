// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RatingStar extends StatefulWidget {
  const RatingStar({super.key});

  @override
  State<RatingStar> createState() => _RatingStarState();
}

class _RatingStarState extends State<RatingStar> {
  double rating = 0;
  bool onlike = false;

  @override

  void initState() {
    super.initState();
     _loadRating();
  }


  _loadRating() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    rating = prefs.getDouble('rating') ?? 0;
    print('Loaded rating: $rating');
  });
}

_saveRating(double value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble('rating', value);
  print('Saved rating: $value');
}
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Rating star"),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 305,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset("lib/img/download.jpg"),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Mahindra 575",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      onlike = !onlike;
                                    });
                                  },
                                  icon: onlike
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : const Icon(Icons.favorite_border)),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.share_sharp)),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.save_alt_outlined))
                            ],
                          ),
                            Row(
                                  children: [
                                    RatingBar.builder(
                                      itemBuilder: (context, index) =>  Icon(
                                        Icons.star,
                                        color:index <= rating ? Colors.orange : Colors.grey,
                                        size: 100,
                                      ),
                                      onRatingUpdate: (ratingvalue) {
                                        setState(() {
                                          rating = ratingvalue;
                                        });
                                        _saveRating(ratingvalue);
                                      },
                                    
                                      initialRating: rating,
                                      allowHalfRating: true,
                                      minRating: 0.5,
                                      itemCount: 5,
                                      itemSize: 30,
                                      updateOnDrag: true,
                                    ),
                                    Text("(${rating.toString()})"),
                                  ],
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
