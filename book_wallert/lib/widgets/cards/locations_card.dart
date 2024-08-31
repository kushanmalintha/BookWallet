import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:book_wallert/models/shop_model.dart';

class LocationsCard extends StatelessWidget {
  final Shop shop;

  LocationsCard({super.key, required this.shop});

//For open the call
  void _launchCaller(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

//For open the map
  void _launchMaps(String locationLink) async {
    final Uri launchUri = Uri.parse(locationLink);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $locationLink';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[800], // Replace with your color
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shop.name,
                  style: const TextStyle(
                    color: Colors.white, // Replace with your color
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  shop.category,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  shop.locatedCity,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
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
                          onPressed: () =>
                              _launchCaller(shop.phoneNumber), //Launch the call
                        ),
                        const Text("CALL",
                            style: TextStyle(color: Colors.white, fontSize: 13))
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
                          onPressed: () =>
                              _launchMaps(shop.locationLink), //Launch the Map
                        ),
                        const Text("DIRECTIONS",
                            style: TextStyle(color: Colors.white, fontSize: 13))
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
