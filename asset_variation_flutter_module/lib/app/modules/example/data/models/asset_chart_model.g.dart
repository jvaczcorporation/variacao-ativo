// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_chart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetChartModel _$AssetChartModelFromJson(Map<String, dynamic> json) =>
    AssetChartModel(
      timestamp:
          AssetChartModel._fromJsonTimestamp(json['timestamp'] as List<int>),
      openQuote: (json['openQuote'] as List<dynamic>)
          .map((e) => (e as num?)?.toDouble())
          .toList(),
    );

Map<String, dynamic> _$AssetChartModelToJson(AssetChartModel instance) =>
    <String, dynamic>{
      'timestamp': AssetChartModel._toJsonTimestamp(instance.timestamp),
      'openQuote': instance.openQuote,
    };
