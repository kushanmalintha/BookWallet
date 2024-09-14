import 'package:book_wallert/controllers/token_controller.dart';
import 'package:book_wallert/models/group_model.dart';
import 'package:book_wallert/models/user.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/services/group_service.dart';

class GroupController with ChangeNotifier {
  final GroupService _groupService = GroupService();
  List<GroupModel> groups = [];
  List<User> groupMembers = [];
  List<User> memberRequests = []; // List to hold the pending member requests
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

  Future<void> fetchMemberRequestsByGroupId(
      int groupId, Function(List<User>) onSuccess) async {
    try {
      memberRequests = await _groupService.getMemberRequestsByGroupId(groupId);
      onSuccess(memberRequests);
      notifyListeners();
    } catch (e) {
      print('Error fetching member requests: $e');
    }
  }

  // Method to check if the current user is an admin of the group
  Future<void> checkAdminStatus(int groupId, Function(bool) callback) async {
    try {
      final token = await getToken();
      bool isAdmin = await _groupService.checkAdminStatus(groupId, token!);
      callback(isAdmin);
      notifyListeners();
    } catch (e) {
      print('Error checking admin status: $e');
    }
  }

  Future<void> acceptRequest(int groupId, int userId) async {
    try {
      final token = await getToken();
      await _groupService.acceptMemberRequest(groupId, userId, token!);
      notifyListeners(); // Notify UI to update
    } catch (e) {
      print('Error accepting request: $e');
    }
  }

  Future<void> removeRequest(int groupId, int userId) async {
    try {
      final token = await getToken();
      await _groupService.removeMemberRequest(groupId, userId, token!);
      notifyListeners(); // Notify UI to update
    } catch (e) {
      print('Error removing request: $e');
    }
  }
}
