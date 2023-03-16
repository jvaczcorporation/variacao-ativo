import 'package:asset_variation/app/modules/example/data/models/asset_model.dart';
import 'package:asset_variation/app/modules/example/domain/entities/asset_entity.dart';

class AssetMapper {
  static AssetEntity toEntity(
    AssetModel model,
  ) =>
      AssetEntity(
        timestamp: model.timestamp,
        openQuote: model.openQuote,
      );

  static AssetModel toModel(
    AssetEntity entity,
  ) =>
      AssetModel(
        timestamp: entity.timestamp,
        openQuote: entity.openQuote,
      );
}
