import 'dart:io';
import 'package:book_wallert/ipaddress.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart'; // Ensure this import is included
import '../models/image_model.dart'; // Import the ImageModel

class ImageService {
  final String _baseUrl =
      'http://${ip}:8000/api'; // Adjust the base URL as necessary

  Future<void> uploadImageService(File imageFile, String imageName) async {
    String uploadUrl = '$_baseUrl/uploadprofileimage';

    // Prepare the multipart request
    var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));

    // Add the text field
    request.fields['name'] = imageName;

    // Determine the MIME type of the file
    var mimeType = lookupMimeType(imageFile.path) ?? 'application/octet-stream';

    // Add the file
    request.files.add(
      await http.MultipartFile.fromPath(
        'testImage',
        imageFile.path,
        contentType: MediaType.parse(mimeType),
      ),
    );

    try {
      // Send the request
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 200) {
        print('Successfully uploaded');
      } else {
        print('Failed to upload image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
      throw e;
    }
  }

  Future<ImageModel> fetchImageService(String imageName) async {
    String fetchUrl = '$_baseUrl/getprofileimage/$imageName';

    try {
      // Send the GET request
      var response = await http.get(Uri.parse(fetchUrl));

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Assuming response.bodyBytes contains image data
        return ImageModel(
          name: imageName,
          image: response.bodyBytes,
        );
      } else {
        print('Failed to fetch image: ${response.statusCode}');
        throw Exception('Failed to fetch image');
      }
    } catch (e) {
      print('Error fetching image: $e');
      throw e;
    }
  }

  Future<void> deleteImageService(String imageName) async {
    String deleteUrl = '$_baseUrl/deleteprofileimage/$imageName';

    try {
      var response = await http.delete(Uri.parse(deleteUrl));
      if (response.statusCode == 200) {
        print('Successfully deleted image');
      } else {
        print('Failed to delete image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting image: $e');
      throw e;
    }
  }
}
