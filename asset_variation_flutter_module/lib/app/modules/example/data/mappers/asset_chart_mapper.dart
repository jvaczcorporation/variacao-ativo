import 'package:asset_variation_flutter_module/app/modules/example/data/models/asset_chart_model.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/entities/asset_chart_entity.dart';

class AssetChartMapper {
  static AssetChartEntity toEntity(
    AssetChartModel model,
  ) =>
      AssetChartEntity(
        timestamp: model.timestamp,
        openQuote: model.openQuote,
      );

  static AssetChartModel toModel(
    AssetChartEntity entity,
  ) =>
      AssetChartModel(
        timestamp: entity.timestamp,
        openQuote: entity.openQuote,
      );
}
