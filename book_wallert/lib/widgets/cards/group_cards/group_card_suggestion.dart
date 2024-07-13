import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/screens/main_screen/group_profile_screen/group_profile_screen_body.dart';
import 'package:flutter/material.dart';
import '../../../../../colors.dart';

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

class SuggestionCard extends StatelessWidget {
  const SuggestionCard({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        screenChange(context, const GroupProfileScreenBody());
      },
      child: Card(
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
                          height: 30,
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () {
                              // Add your onPressed functionality here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  MyColors.selectedItemColor, // Button color
                            ),
                            child: const Text(
                              'Send Request',
                              style: TextStyle(
                                  color: MyColors.bgColor, fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Expanded(
                          child: Text(
                            'Suggested By: Ravindu Pathirage and ...',
                            style: TextStyle(
                                color: MyColors.text2Color, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
