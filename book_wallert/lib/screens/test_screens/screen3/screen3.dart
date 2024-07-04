import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class Screen3 extends StatelessWidget {
  const Screen3({super.key});
  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Profile'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(),
            ReviewList(),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: MyColors.bgColor, size: 40),
          ),
          const SizedBox(height: 16),
          const Text(
            'Ravindu Pathirage',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(height: 16),
          const Text(
            'I am some one and the onlu one who desidned this application. '
            'im sorry I am runnting out of things to write, so Im just gonna write some Gibbrish '
            'iefb f2ef erf wef wefwe vwer fwerf wefrwerf wwef werf werf wef we fw erfw rf we frw erf '
            'we rfwe rf we rf wer fw frwe rfw erfwerf werfwerfwrfw erfwerfw erfwerfwerf we rfwe frwe rfw erf',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ProfileButton(label: 'Reviews'),
              ProfileButton(label: 'Reading'),
              ProfileButton(label: 'Wishlist'),
              ProfileButton(label: 'Completed'),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  final String label;

  ProfileButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(label),
    );
  }
}

class ReviewList extends StatelessWidget {
  final List<Review> reviews = List.generate(
    3,
    (index) => Review(
      title: 'Dune Messiah',
      author: 'Frank Herbert',
      rating: 8.9,
      reviewText:
          'Dune Messiah continues the story of Paul Atreides, now Emperor of the Known Universe and known as Muad\'Dib. As he grapples with immense power, political enemies, and a conspiracy within his own.',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return ReviewCard(review: reviews[index]);
      },
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;

  ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/en/thumb/4/42/Dune_Messiah_Cover.jpg/220px-Dune_Messiah_Cover.jpg',
                  width: 50,
                  height: 75,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(review.author),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber),
                          Text('${review.rating}/10'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(review.reviewText),
            SizedBox(height: 16),
            const Row(
              children: [
                Icon(Icons.thumb_up_alt_outlined),
                SizedBox(width: 8),
                Text('2344'),
                SizedBox(width: 16),
                Icon(Icons.comment_outlined),
                SizedBox(width: 8),
                Text('465'),
                SizedBox(width: 16),
                Icon(Icons.share_outlined),
                SizedBox(width: 8),
                Text('49'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Review {
  final String title;
  final String author;
  final double rating;
  final String reviewText;

  Review({
    required this.title,
    required this.author,
    required this.rating,
    required this.reviewText,
  });
}
