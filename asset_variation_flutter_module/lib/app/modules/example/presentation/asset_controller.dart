import 'package:asset_variation_flutter_module/app/commons/domain/enums/visualization_type.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/use_cases/get_asset_use_case.dart';
import 'package:asset_variation_flutter_module/app/modules/example/presentation/asset_store.dart';

class AssetController {
  final AssetStore store;
  final GetAssetUseCase getAssetUseCase;

  AssetController({
    required this.store,
    required this.getAssetUseCase,
  });

  fetchAsset(ViewType viewType) async {
    try {
      store.data = await getAssetUseCase();
      store.viewType = viewType;
    } on Exception catch (e) {
      store.exception = e;
      store.error = e.toString();
    }
  }

  changeViewType(ViewType viewType) {
    store.viewType = viewType;
  }
}
