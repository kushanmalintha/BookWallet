import 'dart:typed_data';

class ImageModel {
  final String name;
  final Uint8List image;

  ImageModel({required this.name, required this.image});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      name: json['name'],
      image: Uint8List.fromList(json['image']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }
}
