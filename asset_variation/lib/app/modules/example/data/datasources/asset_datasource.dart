import 'package:asset_variation/app/modules/example/data/models/asset_model.dart';

abstract class AssetDatasource {
  Future<AssetModel> getAssetRemote();
}
