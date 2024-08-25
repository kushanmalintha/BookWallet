import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:http/http.dart' as http;

class GroupService {
  final String _baseUrl = 'http://${ip}:3000/api/groups';  // Replace with your API base URL

  Future<void> createGroup(String groupName, String groupDescription, String groupImageUrl,int userId) async {
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
        'user_id': userId,
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
}
