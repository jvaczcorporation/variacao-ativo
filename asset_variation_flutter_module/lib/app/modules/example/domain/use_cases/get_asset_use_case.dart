import 'package:asset_variation_flutter_module/app/modules/example/domain/entities/asset_entity.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/repositories/asset_repository.dart';

abstract class GetAssetUseCase {
  Future<AssetEntity> call();
}

class GetAssetUseCaseImpl implements GetAssetUseCase {
  final AssetRepository repository;

  GetAssetUseCaseImpl({
    required this.repository,
  });

  @override
  Future<AssetEntity> call() async {
    return await repository.getAsset();
  }
}
