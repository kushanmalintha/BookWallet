// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PDFData _$PDFDataFromJson(Map<String, dynamic> json) => PDFData(
      id: json['id'] as String,
      globalId: (json['globalId'] as num?)?.toInt(),
      isVertical: json['isVertical'] as bool? ?? true,
      pageSnap: json['pageSnap'] as bool? ?? true,
      autoSpacing: json['autoSpacing'] as bool? ?? true,
      pageFling: json['pageFling'] as bool? ?? true,
      nightMode: json['nightMode'] as bool? ?? false,
      currentPage: (json['currentPage'] as num?)?.toInt() ?? 0,
      progress: (json['progress'] as num?)?.toDouble() ?? 0,
      bookmarks: (json['bookmarks'] as List<dynamic>?)
              ?.map((e) => Map<String, String>.from(e as Map))
              .toList() ??
          const <Map<String, String>>[],
    );

Map<String, dynamic> _$PDFDataToJson(PDFData instance) => <String, dynamic>{
      'id': instance.id,
      'globalId': instance.globalId,
      'isVertical': instance.isVertical,
      'pageSnap': instance.pageSnap,
      'autoSpacing': instance.autoSpacing,
      'pageFling': instance.pageFling,
      'nightMode': instance.nightMode,
      'currentPage': instance.currentPage,
      'progress': instance.progress,
      'bookmarks': instance.bookmarks,
    };
