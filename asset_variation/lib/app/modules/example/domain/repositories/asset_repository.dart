import 'package:asset_variation/app/modules/example/domain/entities/asset_entity.dart';

abstract class AssetRepository {
  Future<AssetEntity> getAsset();
}
