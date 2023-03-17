import 'package:json_annotation/json_annotation.dart';

part 'asset_chart_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AssetChartModel {
  @JsonKey(fromJson: _fromJsonTimestamp, toJson: _toJsonTimestamp)
  final List<DateTime> timestamp;
  final List<double?> openQuote;

  const AssetChartModel({
    required this.timestamp,
    required this.openQuote,
  });

  static List<DateTime> _fromJsonTimestamp(List<int> times) => times
      .map((time) => DateTime.fromMillisecondsSinceEpoch(time * 1000))
      .toList();

  static List<int> _toJsonTimestamp(List<DateTime> times) => times
      .map((time) => (time.millisecondsSinceEpoch / 1000).round())
      .toList();

  factory AssetChartModel.fromJson(Map<String, dynamic> json) =>
      _$AssetChartModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssetChartModelToJson(this);
}
