import 'package:asset_variation_flutter_module/app/modules/example/data/models/asset_model.dart';

abstract class AssetDatasource {
  Future<AssetModel> getAssetRemote();
}
