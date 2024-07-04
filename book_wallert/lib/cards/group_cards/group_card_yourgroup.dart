import 'package:flutter/material.dart';
import '../../../../colors.dart';

// class FilterButton extends StatelessWidget {
//   final String label;

//   const FilterButton({super.key, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: label == 'Your Fandoms'
//             ? MyColors.selectedItemColor
//             : MyColors.bgColor,
//       ),
//       onPressed: () {},
//       child: Text(label),
//     );
//   }
// }

class FandomCard extends StatelessWidget {
  const FandomCard({super.key});
  @override
  Widget build(BuildContext context) {
    return const Card(
      color: MyColors.panelColor,
      margin: EdgeInsets.all(5),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                'images/groupImage1.jpg', // Replace with actual image URL
              ),
              radius: 25,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Harry Potter Fans',
                    style: TextStyle(
                      color: MyColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
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
                  SizedBox(height: 7),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
