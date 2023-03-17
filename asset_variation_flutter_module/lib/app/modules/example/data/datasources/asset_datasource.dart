import 'package:asset_variation_flutter_module/app/modules/example/data/models/asset_chart_model.dart';
import 'package:asset_variation_flutter_module/app/modules/example/data/models/asset_model.dart';

abstract class AssetDatasource {
  Future<AssetChartModel> getAssetChartRemote({required String symbol});
  Future<List<AssetModel>> searchAssetRemote({required String symbol});
}
