import 'package:book_wallert/controllers/token_controller.dart';
import 'package:book_wallert/models/group_model.dart';
import 'package:book_wallert/models/user.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/services/groupService.dart';

class GroupController with ChangeNotifier {
  final GroupService _groupService = GroupService();
  List<GroupModel> groups = [];
  List<User> groupMembers = [];

  Future<void> createGroup(
      String groupName, String groupDescription, String groupImageUrl) async {
    try {
      final token = await getToken();
      await _groupService.createGroup(
          groupName, groupDescription, groupImageUrl, token!);
      // Notify listeners if needed
      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error creating group: $e');
    }
  }

  Future<void> fetchGroupsByUserId(Function(List<GroupModel>) callback) async {
    try {
      final token =
          await getToken(); // Assuming you have a method to get the token
      List<GroupModel> fetchedGroups =
          await _groupService.getGroupsByUserId(token);
      groups.addAll(fetchedGroups);
      callback(groups);
      notifyListeners();
    } catch (e) {
      print('Error fetching groups: $e');
    }
  }

  Future<void> fetchGroupById(
      String groupId, Function(GroupModel) callback) async {
    try {
      GroupModel group = await _groupService.getGroupById(groupId);
      callback(group);
    } catch (e) {
      print('Error fetching group by ID: $e');
    }
  }

  Future<void> fetchMembersByGroupId(
      int groupId, Function(List<User>) onSuccess) async {
    try {
      groupMembers = await _groupService.getMembersByGroupId(groupId);
      onSuccess(groupMembers);
      notifyListeners();
    } catch (e) {
      print('Error fetching group members: $e');
    }
  }
}
