import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:http/http.dart' as http;
import 'package:book_wallert/models/group_model.dart';

class GroupService {
  final String _baseUrl =
      'http://${ip}:3000/api/groups'; // Replace with your API base URL

  Future<void> createGroup(String groupName, String groupDescription,
      String groupImageUrl, String token) async {
    final url = Uri.parse('$_baseUrl/create');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'group_name': groupName,
        'group_description': groupDescription,
        'group_image_url': groupImageUrl,
        'token': token,
      }),
    );

    if (response.statusCode == 200) {
      // Group created successfully
      print('Group created successfully');
    } else {
      // Handle errors
      print('Failed to create group: ${response.statusCode}');
      throw Exception('Failed to create group');
    }
  }

  Future<List<GroupModel>> getGroupsByUserId(String? token) async {
    final url = Uri.parse('$_baseUrl/user-groups');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> groupData = jsonDecode(response.body);
      return groupData.map((json) => GroupModel.fromJson(json)).toList();
    } else {
      print('Failed to fetch groups: ${response.statusCode}');
      throw Exception('Failed to fetch groups');
    }
  }

  Future<GroupModel> getGroupById(String groupId) async {
    final url = Uri.parse('$_baseUrl/$groupId');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final groupData = jsonDecode(response.body);
      return GroupModel.fromJson(groupData);
    } else {
      print('Failed to fetch group: ${response.statusCode}');
      throw Exception('Failed to fetch group');
    }
  }
}
