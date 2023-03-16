import 'package:asset_variation/app/commons/domain/enums/visualization_type.dart';
import 'package:asset_variation/app/commons/presentation/stores/state_store.dart';
import 'package:asset_variation/app/modules/example/domain/entities/asset_entity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';

class AssetStore extends StateStore<AssetEntity> {
  final Rx<ViewType?> _viewType = Rx<ViewType?>(null);
  ViewType? get viewType => _viewType.value;
  set viewType(ViewType? value) => _viewType.value = value;

  bool get anythigData => data != null;

  double get total => data!.openQuote
      .map((e) => e ?? 0.0)
      .toList()
      .reduce((value, element) => value + element);

  double get avg => total / data!.openQuote.length;

  List<FlSpot> get spots => data!.openQuote
      .mapIndexed((index, quote) =>
          FlSpot(double.parse(index.toString()), quote ?? avg))
      .toList();
}
