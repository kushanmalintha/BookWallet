// import 'package:book_wallert/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:book_wallert/home_screen_body.dart';

// class HomeScreen1 extends StatelessWidget {
//   const HomeScreen1({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('BookWallet'),
//         backgroundColor: MyColors.navigationBarColor,
//         titleTextStyle: const TextStyle(
//           color: MyColors.textColor,
//           fontSize: 20,
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.search),
//             color: MyColors.nonSelectedItemColor,
//             onPressed: () {
//               // search function
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.menu),
//             color: MyColors.nonSelectedItemColor,
//             onPressed: () {
//               // menu function
//             },
//           ),
//         ],
//       ),
//       backgroundColor: MyColors.bgColor,
//       body: const HomeScreenBody(),
//       bottomNavigationBar: BottomAppBar(
//         color: MyColors.navigationBarColor,
//         height: 60,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.home),
//               color: MyColors.nonSelectedItemColor,
//               onPressed: () {
//                 // home function
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.group),
//               color: MyColors.nonSelectedItemColor,
//               onPressed: () {
//                 // group function here
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.book),
//               color: MyColors.nonSelectedItemColor,
//               onPressed: () {
//                 // book function here
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.person),
//               color: MyColors.nonSelectedItemColor,
//               onPressed: () {
//                 // user profile function here
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
