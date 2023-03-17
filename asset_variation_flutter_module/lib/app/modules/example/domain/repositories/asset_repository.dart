import 'package:asset_variation_flutter_module/app/modules/example/domain/entities/asset_entity.dart';

abstract class AssetRepository {
  Future<AssetEntity> getAsset();
}
