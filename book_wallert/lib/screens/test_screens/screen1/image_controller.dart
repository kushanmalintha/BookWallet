import 'dart:io';
import 'dart:typed_data';
import 'package:book_wallert/screens/test_screens/screen1/image_api_service.dart';
import 'package:book_wallert/screens/test_screens/screen1/image_model.dart';
import 'package:flutter/material.dart';

class ImageController {
  final ImageService _imageService = ImageService();

  Future<void> uploadImage(File imageFile, String imageName) async {
    try {
      await _imageService.uploadImage(imageFile, imageName);
    } catch (e) {
      print('Error in ImageController upload: $e');
      throw e;
    }
  }

  Future<ImageModel> fetchImage(String imageName) async {
    try {
      return await _imageService.fetchImage(imageName);
    } catch (e) {
      print('Error in ImageController fetch: $e');
      return ImageModel(name: 'placeholder', image: Uint8List(0));
    }
  }
}
