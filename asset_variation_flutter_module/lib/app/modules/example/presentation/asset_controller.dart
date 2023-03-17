import 'package:asset_variation_flutter_module/app/commons/domain/enums/store_state.dart';
import 'package:asset_variation_flutter_module/app/commons/domain/enums/visualization_type.dart';
import 'package:asset_variation_flutter_module/app/commons/domain/erros/errors.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/use_cases/get_asset_chart_data_use_case.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/use_cases/search_asset_use_case.dart';
import 'package:asset_variation_flutter_module/app/modules/example/presentation/asset_store.dart';
import 'package:collection/collection.dart';

class AssetController {
  final AssetStore store;
  final GetAssetChartDataUseCase getAssetChartDataUseCase;
  final SearchAssetUseCase searchAssetUseCase;

  AssetController({
    required this.store,
    required this.getAssetChartDataUseCase,
    required this.searchAssetUseCase,
  });

  fetchAsset(ViewType viewType, {String? symbol}) async {
    store.viewType = viewType;
    store.state = StoreState.loading;
    try {
      store.assets = await searchAssetUseCase(symbol: symbol ?? "PETR4.SA");
      store.assetSelected = store.assets!.first;

      store.data =
          await getAssetChartDataUseCase(symbol: store.assetSelected!.symbol);

      store.state = StoreState.completed;
    } on Failure catch (e) {
      store.state = StoreState.error;
      store.exception = e;
      store.error = e.message;
    } catch (e) {
      store.state = StoreState.error;
      store.exception = e as Exception;
      store.error = e.toString();
    }
  }

  changeViewType(ViewType viewType) {
    store.viewType = viewType;
  }

  chooseAsset(String value) {
    var assetChoosed = store.assets!.firstWhereOrNull(
      (element) => element.symbol == value,
    );

    store.assetSelected = assetChoosed;
    fetchAsset(store.viewType ?? ViewType.chart, symbol: value);
  }

  searchAssets(String pattern) async {
    final assets = await searchAssetUseCase(symbol: pattern);
    store.assets = assets;

    return assets.map((asset) => asset.symbol);
  }
}
