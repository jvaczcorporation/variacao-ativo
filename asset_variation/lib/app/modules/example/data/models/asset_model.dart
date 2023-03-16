import 'package:json_annotation/json_annotation.dart';

part 'asset_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AssetModel {
  @JsonKey(fromJson: _fromJsonTimestamp, toJson: _toJsonTimestamp)
  final List<DateTime> timestamp;
  final List<double?> openQuote;

  const AssetModel({
    required this.timestamp,
    required this.openQuote,
  });

  static List<DateTime> _fromJsonTimestamp(List<int> times) => times
      .map((time) => DateTime.fromMillisecondsSinceEpoch(time * 1000))
      .toList();

  static List<int> _toJsonTimestamp(List<DateTime> times) => times
      .map((time) => (time.millisecondsSinceEpoch / 1000).round())
      .toList();

  factory AssetModel.fromJson(Map<String, dynamic> json) =>
      _$AssetModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssetModelToJson(this);
}
