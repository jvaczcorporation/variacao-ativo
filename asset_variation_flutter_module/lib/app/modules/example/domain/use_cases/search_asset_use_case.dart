import 'package:asset_variation_flutter_module/app/modules/example/domain/entities/asset_chart_entity.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/entities/asset_entity.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/repositories/asset_repository.dart';

abstract class SearchAssetUseCase {
  Future<List<AssetEntity>> call({required String symbol});
}

class SearchAssetUseCaseImpl implements SearchAssetUseCase {
  final AssetRepository repository;

  SearchAssetUseCaseImpl({
    required this.repository,
  });

  @override
  Future<List<AssetEntity>> call({required String symbol}) async {
    return await repository.searchAsset(symbol: symbol);
  }
}
