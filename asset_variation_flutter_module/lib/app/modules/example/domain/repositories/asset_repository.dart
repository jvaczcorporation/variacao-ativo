import 'package:asset_variation_flutter_module/app/modules/example/domain/entities/asset_chart_entity.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/entities/asset_entity.dart';

abstract class AssetRepository {
  Future<AssetChartEntity> getAssetChart({required String symbol});

  Future<List<AssetEntity>> searchAsset({required String symbol});
}
