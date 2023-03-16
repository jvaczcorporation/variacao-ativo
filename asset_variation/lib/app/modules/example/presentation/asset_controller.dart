import 'package:asset_variation/app/commons/domain/enums/visualization_type.dart';
import 'package:asset_variation/app/modules/example/domain/use_cases/get_asset_use_case.dart';
import 'package:asset_variation/app/modules/example/presentation/asset_store.dart';

class AssetController {
  final AssetStore store;
  final GetAssetUseCase getAssetUseCase;

  AssetController({
    required this.store,
    required this.getAssetUseCase,
  });

  fetchAsset() async {
    try {
      store.data = await getAssetUseCase();
    } on Exception catch (e) {
      store.exception = e;
      store.error = e.toString();
    }
  }

  changeViewType(ViewType viewType) {
    store.viewType = viewType;
  }
}
