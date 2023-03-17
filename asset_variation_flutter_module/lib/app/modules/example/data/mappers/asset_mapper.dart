import 'package:asset_variation_flutter_module/app/modules/example/data/models/asset_model.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/entities/asset_entity.dart';

class AssetMapper {
  static AssetEntity toEntity(
    AssetModel model,
  ) =>
      AssetEntity(
        shortname: model.shortname,
        symbol: model.symbol,
      );

  static AssetModel toModel(
    AssetEntity entity,
  ) =>
      AssetModel(
        shortname: entity.shortname,
        symbol: entity.symbol,
      );
}
