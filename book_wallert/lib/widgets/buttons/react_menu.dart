import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class ReactMenu {
  static void show(BuildContext context) {
    List<User> users = [
      User('User 1', 'images/user1.jpg'),
      User('User 2', 'images/user2.jpg'),
      User('User 3', 'images/user3.jpg'),
      User('User 4', 'images/user4.jpg'),
      User('User 5', 'images/user5.jpg'),
      User('User 6', 'images/user6.jpg'),
      User('User 7', 'images/user7.jpg'),
      User('User 8', 'images/user8.jpg'),
      User('User 9', 'images/user9.jpg'),
      User('User 10', 'images/user10.jpg'),
      User('User 11', 'images/user11.jpg'),
      User('User 12', 'images/user12.jpg'),
      // Add more users if needed
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shadowColor: MyColors.bgColor,
          backgroundColor: MyColors.nonSelectedItemColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 200, // Adjust height as needed
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage(users[index].imagePath),
                              radius: 20,
                            ),
                            title: Text(users[index].name),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class User {
  final String name;
  final String imagePath;

  User(this.name, this.imagePath);
}










// import 'package:book_wallert/colors.dart';
// import 'package:flutter/material.dart';

// class ReactMenu {
//   static void show(BuildContext context, Offset position) {
//     showMenu(
//       context: context,
//       elevation: 10,
//       shadowColor: MyColors.bgColor,
//       color: MyColors.nonSelectedItemColor,
//       position: RelativeRect.fromLTRB(
//           position.dx, position.dy, position.dx, position.dy),
//       items: [
//         const PopupMenuItem(
//           child: Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: AssetImage('images/user1.jpg'),
//                 radius: 10,
//               ),
//               SizedBox(width: 10),
//               Text('User 1'),
//             ],
//           ),
//         ),
//         const PopupMenuItem(
//           child: Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: AssetImage('images/user2.jpg'),
//                 radius: 10,
//               ),
//               SizedBox(width: 10),
//               Text('User 2'),
//             ],
//           ),
//         ),
//         // Add more PopupMenuItem for additional users
//       ],
//     );
//   }
// }
