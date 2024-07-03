// import 'package:flutter/material.dart';
// import 'package:book_wallert/colors.dart';
// import '../lib/screens/main_screen/top_panel.dart';
// import 'package:book_wallert/buttons/custom_button.dart';
// import '../lib/screens/main_screen/groups_screen/groups_screen_body.dart';
// import '../lib/screens/main_screen/profile_screen/profile_screen_body.dart';
// import 'package:book_wallert/screens/main_screen/top_panel.dart';
// import '../lib/screens/main_screen/books_screen/book_list_view.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: HomeScreen1(),
//       // theme: ThemeData(
//       //   primarySwatch: Colors.blue,
//       //   scaffoldBackgroundColor: MyColors.bgColor,
//       // ),
//       // routes: {
//       //   '/groups': (context) => const GroupsScreen(),
//       //   '/profile': (context) => const ProfileScreen(),
//       // },
//     );
//   }
// }

// class HomeScreen1 extends StatefulWidget {
//   const HomeScreen1({super.key});
//   @override
//   // ignore: library_private_types_in_public_api
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen1>
//     with SingleTickerProviderStateMixin {
//   // int _selectedIndex = 0;
//   TabController? _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//   }

//   // void _onItemTapped(int index) {
//   //   setState(() {
//   //     _selectedIndex = index;
//   //     switch (index) {
//   //       case 0:
//   //         Navigator.pushReplacementNamed(context, '/');
//   //         break;
//   //       case 1:
//   //         Navigator.pushReplacementNamed(context, '/groups');
//   //         break;
//   //       case 3:
//   //         Navigator.pushReplacementNamed(context, '/profile');
//   //         break;
//   //     }
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // title: TopPanel(
//         //   title: 'Book',
//         // ),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: const [
//             Tab(text: 'Recommended'),
//             Tab(text: 'Trending'),
//             Tab(text: 'Wishlist'),
//             Tab(text: 'Completed'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: const [
//           BookListView(),
//           BookListView(),
//           BookListView(),
//           BookListView(),
//         ],
//       ),
//       // bottomNavigationBar: BottomNavigationBar(
//       //   iconSize: 30,
//       //   backgroundColor: MyColors.navigationBarColor,
//       //   unselectedItemColor: MyColors.nonSelectedItemColor,
//       //   selectedItemColor: MyColors.selectedItemColor,
//       //   currentIndex: _selectedIndex,
//       //   onTap: _onItemTapped,
//       //   items: const <BottomNavigationBarItem>[
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.home),
//       //       label: 'Home',
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.group),
//       //       label: 'Groups',
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.library_books),
//       //       label: 'Books',
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.person_outline_outlined),
//       //       label: 'Profile',
//       //     ),
//       //   ],
//       // ),
//     );
//   }
// }

// // class BookListView extends StatelessWidget {
// //   const BookListView({super.key});
// //   @override
// //   Widget build(BuildContext context) {
// //     return ListView.builder(
// //       itemCount: 10, // Change this to the number of books
// //       itemBuilder: (context, index) {
// //         return Card(
// //           color: MyColors.bgColor, // Ensure card matches background
// //           child: ListTile(
// //             leading: Image.asset(
// //               'Images/Book_Image1.jpg',
// //               scale: 1,
// //             ), // Book cover image
// //             title: const Text(
// //               'Dune Messiah',
// //               style: TextStyle(color: Colors.white), // Ensure text is visible
// //             ),
// //             subtitle: const Text(
// //               'Frank Herbert\nPages: 256\nGenre: Science Fiction\nTotal Rating: 9.8/10',
// //               style: TextStyle(color: Colors.white), // Ensure text is visible
// //             ),
// //             isThreeLine: true,
// //             trailing: IconButton(
// //               icon: const Icon(Icons.favorite_border, color: Colors.white),
// //               onPressed: () {
// //                 // Add to wishlist action
// //               },
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
