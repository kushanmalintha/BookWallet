import 'dart:math';

import 'package:book_wallert/models/share_model.dart';
import 'package:book_wallert/services/home_screen_api_service.dart';
import '../models/review_model.dart';
import '../models/book_model.dart';

class HomeScreenController {
  final HomeScreenService _homeScreenService = HomeScreenService();
  List<dynamic> mixedNewContent = [];
  List<dynamic> mixedAllContent = [];
  bool isLoading = false;
  int currentPage = 1;
  int userId;

  HomeScreenController(this.userId);

  Future<void> fetchHomeScreen(
    Function upadateScreen,
  ) async {
    if (isLoading) return;
    isLoading = true;
    try {
      List<dynamic> fetchedHomeScreen =
          await _homeScreenService.fetchHomeScreen(userId, currentPage);

      for (var item in fetchedHomeScreen) {
        // reviews
        if (item is ReviewModel) {
          mixedNewContent.add(item);
          // books
        } else if (item is BookModel) {
          mixedNewContent.add(item);
          // shares
        } else if (item is SharedReview) {
          mixedNewContent.add(item);
        }
      }
      mixedNewContent.shuffle(Random());
      mixedAllContent.addAll(mixedNewContent);
      currentPage++;
      upadateScreen();
    } catch (e) {
      print('Error fetching home screen: $e');
    } finally {
      isLoading = false;
    }
  }
}
