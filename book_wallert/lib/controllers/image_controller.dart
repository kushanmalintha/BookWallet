import 'dart:io';
import 'dart:typed_data';
import 'package:book_wallert/services/image_api_service.dart';
import 'package:book_wallert/models/image_model.dart';

class ImageController {
  final ImageService _imageService = ImageService();

  Future<void> uploadImageController(File imageFile, String imageName) async {
    try {
      await _imageService.uploadImageService(imageFile, imageName);
    } catch (e) {
      print('Error in ImageController upload: $e');
      throw e;
    }
  }

  Future<ImageModel> fetchImageController(String imageName) async {
    try {
      return await _imageService.fetchImageService(imageName);
    } catch (e) {
      print('Error in ImageController fetch: $e');
      return ImageModel(name: 'placeholder', image: Uint8List(0));
    }
  }

  Future<void> deleteImageController(String imageName) async {
    try {
      await _imageService.deleteImageService(imageName);
    } catch (e) {
      print('Error in ImageController delete: $e');
      throw e;
    }
  }
}
