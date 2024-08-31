import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/models/share_model.dart';
import 'package:book_wallert/services/user_activity_service.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/services/share_service.dart';

class ShareController extends ChangeNotifier {
  final ShareService _shareService = ShareService();
  List<Map<String, dynamic>> shares = [];
  bool isLoading = false;

  //  ShareController(this.apiService);

  Future<void> shareReview(int reviewId, int userId) async {
    try {
      await _shareService.shareReview(reviewId, userId);
    } catch (e) {
      throw Exception('Failed to share review: $e');
    }
  }

  Future<List<SharedReview>> getSharedReviews(int userId) async {
    try {
      return await _shareService.fetchSharedReviews(userId);
    } catch (e) {
      throw Exception('Failed to fetch shared reviews: $e');
    }
  }

  Future<void> fetchShares(int reviewId) async {
    isLoading = true;
    notifyListeners();

    try {
      shares = await _shareService.fetchShares(reviewId);
    } catch (e) {
      print('Error fetching shares: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<List<ReviewModel>> fetchUserTimeline(int userId) async {
    try {
      return await _shareService.fetchUserTimeline(userId);
    } catch (e) {
      throw Exception('Failed to fetch user timeline: $e');
    }
  }
}

class UserActivityController extends ChangeNotifier {
  final UserActivityService _userActivityService;
  List<dynamic> userActivities = [];
  bool isLoading = false;

  UserActivityController(int userId)
      : _userActivityService = UserActivityService(userId) {
    fetchUserActivity(); // Automatically fetches data on initialization
  }

  Future<void> fetchUserActivity() async {
    isLoading = true;
    notifyListeners();

    try {
      userActivities = await _userActivityService.fetchUserActivity();
      print(userActivities);
    } catch (e) {
      print('Error fetching user activity: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
