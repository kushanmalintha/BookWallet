// pdf_data_model.dart

import 'package:json_annotation/json_annotation.dart';

part 'pdf_data_model.g.dart';

@JsonSerializable()
class PDFData {
  String id;
  bool isVertical;
  bool pageSnap;
  bool autoSpacing;
  bool pageFling;
  bool nightMode;
  int currentPage;
  double progress;
  List<Map<String, String>> bookmarks;

  PDFData({
    required this.id,
    this.isVertical = true,
    this.pageSnap = true,
    this.autoSpacing = true,
    this.pageFling = true,
    this.nightMode = false,
    this.currentPage = 0,
    this.progress = 0,
    this.bookmarks = const <Map<String, String>>[],
  });

  factory PDFData.fromJson(Map<String, dynamic> json) =>
      _$PDFDataFromJson(json);
  Map<String, dynamic> toJson() => _$PDFDataToJson(this);
}
