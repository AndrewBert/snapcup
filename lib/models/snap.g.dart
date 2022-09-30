// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Snap _$SnapFromJson(Map<String, dynamic> json) => Snap(
      id: json['id'] as String,
      message: json['message'] as String,
      imageId: json['imageId'] as String?,
    );

Map<String, dynamic> _$SnapToJson(Snap instance) => <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'imageId': instance.imageId,
    };
