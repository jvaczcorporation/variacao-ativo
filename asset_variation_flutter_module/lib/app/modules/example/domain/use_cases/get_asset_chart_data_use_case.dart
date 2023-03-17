import 'package:asset_variation_flutter_module/app/modules/example/domain/entities/asset_chart_entity.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/repositories/asset_repository.dart';

abstract class GetAssetChartDataUseCase {
  Future<AssetChartEntity> call({required String symbol});
}

class GetAssetChartDataUseCaseImpl implements GetAssetChartDataUseCase {
  final AssetRepository repository;

  GetAssetChartDataUseCaseImpl({
    required this.repository,
  });

  @override
  Future<AssetChartEntity> call({required String symbol}) async {
    return await repository.getAssetChart(symbol: symbol);
  }
}
