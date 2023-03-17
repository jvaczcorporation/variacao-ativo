import 'package:json_annotation/json_annotation.dart';

part 'asset_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AssetModel {
  final String shortname;
  final String symbol;

  const AssetModel({
    required this.shortname,
    required this.symbol,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) =>
      _$AssetModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssetModelToJson(this);
}
