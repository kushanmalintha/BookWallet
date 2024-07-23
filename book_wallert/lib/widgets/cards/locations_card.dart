import 'package:book_wallert/colors.dart';
import 'package:book_wallert/dummy_data/review_dummy_data.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:flutter/material.dart';

const String shopName = "AI STORE";
const String phoneNumber = "0785104489";
const String city = "KADUWELA";
const String shopType = "Book store";

class LocationsCard extends StatelessWidget {
  final ReviewModel review = dummyReview;

  LocationsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.panelColor,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (shopName),
                  style: TextStyle(
                    color: MyColors.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  (shopType),
                  style: TextStyle(color: MyColors.textColor, fontSize: 15),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  (city),
                  style: TextStyle(color: MyColors.textColor, fontSize: 15),
                ),
              ],
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.call,
                              color: MyColors.selectedItemColor,
                              size: 40,
                            ),
                            onPressed: () {},
                          ),
                          const Text("CALL",
                              style: TextStyle(
                                  color: MyColors.textColor, fontSize: 13))
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.directions,
                              color: MyColors.selectedItemColor,
                              size: 40,
                            ),
                            onPressed: () {},
                          ),
                          const Text("DIRECTIONS",
                              style: TextStyle(
                                  color: MyColors.textColor, fontSize: 13))
                        ],
                      ),
                      // Text(
                      //   phoneNumber,
                      //   style: TextStyle(color: MyColors.textColor, fontSize: 16),
                      // ),
                    ],
                  ),
                ])
          ],
        ),
      ),
    );
  }
}
