import 'package:flutter/material.dart';
import 'package:book_wallert/services/GroupService.dart';

class GroupController with ChangeNotifier {
  final GroupService _groupService = GroupService();

  Future<void> createGroup(String groupName, String groupDescription, String groupImageUrl, int userId) async {
    try {
      await _groupService.createGroup(groupName, groupDescription, groupImageUrl, userId);
      // Notify listeners if needed
      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error creating group: $e');
    }
  }
}
