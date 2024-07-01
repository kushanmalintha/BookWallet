import 'package:flutter/material.dart';
import 'colors.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // Using dark theme similar to your design
      home: FandomsPage(),
    );
  }
}

class FandomsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.navigationBarColor,
        title: Text('Fandoms', style: TextStyle(color: MyColors.titleColor)),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilterButton(label: 'Your Fandoms'),
                FilterButton(label: 'Trending'),
                FilterButton(label: 'Suggestions'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return FandomCard();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Fandoms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;

  FilterButton({required this.label});

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

class FandomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.panelColor,
      margin: EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                'Images/Book Image1.jpg', // Replace with actual image URL
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Members: 23,455'),
                      Text('Discussions: 23,455'),
                    ],
                  ),
                  SizedBox(height: 1),
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
                          child: Text(
                            'Send Request',
                            style: TextStyle(
                                color: MyColors.bgColor, fontSize: 12),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          'Suggested By: Ravindu Pathirage and ...',
                          style: TextStyle(fontSize: 12),
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
    );
  }
}
