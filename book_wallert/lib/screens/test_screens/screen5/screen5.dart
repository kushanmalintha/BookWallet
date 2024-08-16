import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/share_controller.dart';
import 'package:book_wallert/dummy_data/user_dummy.dart';
import 'package:book_wallert/models/share_model.dart';
//import 'package:book_wallert/models/shared_review.dart';
import 'package:book_wallert/screens/test_screens/screen5/shareby_frame.dart';
import 'package:book_wallert/widgets/cards/review_card.dart';
//import 'package:book_wallert/widgets/cards/share_by_card.dart';
import 'package:flutter/material.dart';

class Screen5 extends StatefulWidget {
  const Screen5({super.key});

  @override
  _Screen5State createState() => _Screen5State();
}

class _Screen5State extends State<Screen5> {
  final ShareController _shareController = ShareController();
  List<SharedReview>? _sharedReviews;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchSharedReviews();
  }

 Future<void> _fetchSharedReviews() async {
  try {
    final hardcodedUserId = 65; // Replace with your actual user ID
    final sharedReviews = await _shareController.getSharedReviews(hardcodedUserId);
    setState(() {
      _sharedReviews = sharedReviews;
      _isLoading = false;
    });
  } catch (e) {
    print('Error fetching shared reviews: $e'); // Log the error
    setState(() {
      _isLoading = false;
      _hasError = true;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _hasError
              ? Center(child: Text('Failed to load shared reviews'))
              : ListView(
                  children: [
                    // Add your static RankedCard widgets here if needed.
                    ..._sharedReviews!.map((sharedReview) => SharedByCard(
                          sharedBy: [sharedReview.sharerUsername],
                          imagePath: dummyUser.imageUrl, // Assuming this is available in SharedReview
                          child: ReviewCard(review: sharedReview.review),
                        )),
                  ],
                ),
    );
  }
}
