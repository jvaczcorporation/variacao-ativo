// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetModel _$AssetModelFromJson(Map<String, dynamic> json) => AssetModel(
      timestamp: AssetModel._fromJsonTimestamp(json['timestamp'] as List<int>),
      openQuote: (json['openQuote'] as List<dynamic>)
          .map((e) => (e as num?)?.toDouble())
          .toList(),
    );

Map<String, dynamic> _$AssetModelToJson(AssetModel instance) =>
    <String, dynamic>{
      'timestamp': AssetModel._toJsonTimestamp(instance.timestamp),
      'openQuote': instance.openQuote,
    };
