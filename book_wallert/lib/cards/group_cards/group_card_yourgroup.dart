
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

  final String groupName;
  final String memberCount;
  final int discussionCount;
  

  const FandomCard({super.key, required this.groupName, required this.memberCount, required this.discussionCount});
  @override
  Widget build(BuildContext context) {
    return  Card(
      color: MyColors.panelColor,
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  Text(
                    groupName,
                    style: const TextStyle(
                      color: MyColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 7),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
