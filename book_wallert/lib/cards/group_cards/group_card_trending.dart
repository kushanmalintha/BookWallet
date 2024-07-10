import 'package:book_wallert/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import '../../../../colors.dart';

class FilterButton extends StatelessWidget {
  final String label;

  const FilterButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: label == 'Your Fandoms'
            ? MyColors.selectedItemColor
            : MyColors.bgColor,
      ),
      onPressed: () {},
      child: Text(label),
    );
  }
}

class TrendingCard extends StatelessWidget {
  final int rank;

  const TrendingCard({super.key, required this.rank});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.panelColor,
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('$rank',
                  style: const TextStyle(
                    color: MyColors.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(width: 10),
            const CircleAvatar(
              backgroundImage: AssetImage(
                'images/groupImage1.jpg', // Replace with actual image URL
              ),
              radius: 25,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Harry Potter Fans',
                    style: TextStyle(
                      color: MyColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Members: 23,455',
                        style: TextStyle(color: MyColors.text2Color),
                      ),
                      Text(
                        'Discussions: 23,455',
                        style: TextStyle(color: MyColors.text2Color),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      SizedBox(
                        height: 40,
                        width: 150,
                        child: CustomToggleButton(
                          beforeText: 'Send Request',
                          afterText: 'Requested',
                          press: () {
                            // Add your onPressed functionality here
                          },
                          backgroundColorSelected: MyColors.selectedItemColor,
                          backgroundColorNotSelected:
                              MyColors.nonSelectedItemColor,
                          textColorSelected: MyColors.bgColor,
                          textColorNotSelected: MyColors.textColor,
                          borderColor: MyColors.nonSelectedItemColor,
                        ),
                      ),
                      const SizedBox(width: 15),
                      // const Expanded(
                      //   // child: Text(
                      //   //   'Suggested By: Ravindu Pathirage and ...',
                      //   //   style: TextStyle(
                      //   //       color: MyColors.text2Color, fontSize: 12),
                      //   //   overflow: TextOverflow.ellipsis,
                      //   // ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
