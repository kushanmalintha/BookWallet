import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:http/http.dart' as http;

class NotificationApiService {
  static String baseUrl = 'http://${ip}:3000/api/notification';

  Future<List<AppNotificationShare>> fetchShareNotifications(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/share/$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> notificationData = json.decode(response.body);
      return notificationData
          .map((data) => AppNotificationShare.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  Future<List<AppNotificationLike>> fetchLikeNotifications(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/Like/$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> notificationData = json.decode(response.body);
      return notificationData
          .map((data) => AppNotificationLike.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  Future<List<AppNotificationComment>> fetchcommentNotifications(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/comment/$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> notificationData = json.decode(response.body);
      return notificationData
          .map((data) => AppNotificationComment.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  Future<List<AppNotificationAll>> fetchAllNotifications(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/all/$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> notificationData = json.decode(response.body);
      return notificationData
          .map((data) => AppNotificationAll.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }
}

class AppNotificationLike {
  final String message;

  final String likedUserName;

  final String bookname;

  AppNotificationLike(
      {required this.message,
      required this.likedUserName,
      required this.bookname});

  factory AppNotificationLike.fromJson(Map<String, dynamic> json) {
    return AppNotificationLike(
      message: json['message'],
      likedUserName: json['likedUserName'],
      bookname: json['bookName'],
    );
  }
}
class AppNotificationShare {

  final String message;

  final String sharedUserName;

  final String bookname;
  
  final String date;

  AppNotificationShare(
      {required this.message,
      required this.sharedUserName,
      required this.bookname, required this.date});

  factory AppNotificationShare.fromJson(Map<String, dynamic> json) {
    return AppNotificationShare(
      message: json['message'],
      sharedUserName: json['sharedUserName'],
      bookname: json['bookName'],
      date: json['date'],
    );
  }
}

class AppNotificationComment {
  final String message;

  final String CommentedUserName;

  final String bookname;

  AppNotificationComment(
      {required this.message,
      required this.CommentedUserName,
      required this.bookname});

  factory AppNotificationComment.fromJson(Map<String, dynamic> json) {
    return AppNotificationComment(
      message: json['message'],
      CommentedUserName: json['commentedUserName'],
      bookname: json['bookName'],
    );
  }
}

class AppNotificationAll {
  final String message;

  final String CommentedUserName;

  final String bookname;
  
  final String sharedUserName;
  
  final String likedUserName;

  AppNotificationAll(
      {required this.message,
      required this.CommentedUserName,
      required this.bookname, required this.sharedUserName, required this.likedUserName});

  factory AppNotificationAll.fromJson(Map<String, dynamic> json) {
    return AppNotificationAll(
      message: json['message'],
      CommentedUserName: json['commentedUserName'],
      sharedUserName: json['sharedUserName'],
      likedUserName: json['likedUserName'],
      bookname: json['bookName'],
    );
  }
}