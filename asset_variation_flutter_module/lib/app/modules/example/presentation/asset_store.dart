import 'package:asset_variation_flutter_module/app/commons/domain/enums/visualization_type.dart';
import 'package:asset_variation_flutter_module/app/commons/presentation/stores/state_store.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/entities/asset_chart_entity.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/entities/asset_entity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';

class AssetStore extends StateStore<AssetChartEntity> {
  final Rx<AssetEntity?> _assetSelected = Rx<AssetEntity?>(null);
  AssetEntity? get assetSelected => _assetSelected.value;
  set assetSelected(AssetEntity? value) => _assetSelected.value = value;

  final Rx<List<AssetEntity>?> _assets = Rx<List<AssetEntity>?>(null);
  List<AssetEntity>? get assets => _assets.value;
  set assets(List<AssetEntity>? value) => _assets.value = value;

  final Rx<ViewType?> _viewType = Rx<ViewType?>(null);
  ViewType? get viewType => _viewType.value;
  set viewType(ViewType? value) => _viewType.value = value;

  bool get anythigData => data != null;

  List<FlSpot> get spots => data!.openQuote
      .mapIndexed((index, quote) =>
          FlSpot(double.parse(index.toString()), quote ?? data!.avg))
      .toList();
}
