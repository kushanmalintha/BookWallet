import 'package:book_wallert/services/notification_api_service.dart';

class NotificationController {
  final NotificationApiService _apiService = NotificationApiService();

  Future<List<AppNotificationShare>> getShareNotifications(int userId) async {
    return await _apiService.fetchShareNotifications(userId);
  }

  Future<List<AppNotificationLike>> getLikeNotifications(int userId) async {
    return await _apiService.fetchLikeNotifications(userId);
  }
   Future<List<AppNotificationComment>> getCommentNotifications(int userId) async {
    return await _apiService.fetchcommentNotifications(userId);
  }
}
