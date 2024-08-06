import 'package:flutter/material.dart';
import 'package:book_wallert/services/review_likes_api_service.dart';

class LikesController extends ChangeNotifier {
  final LikesApiService apiService;
  List<Map<String, dynamic>> likes = [];
  bool isLoading = false;

  LikesController(this.apiService);

  Future<void> fetchLikes(int reviewId) async {
    isLoading = true;
    notifyListeners();

    try {
      likes = await apiService.fetchLikes(reviewId);
    } catch (e) {
      print('Error fetching likes: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
