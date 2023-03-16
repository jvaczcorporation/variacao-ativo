import 'package:asset_variation/app/modules/example/data/datasources/asset_datasource.dart';
import 'package:asset_variation/app/modules/example/data/mappers/asset_mapper.dart';
import 'package:asset_variation/app/modules/example/domain/entities/asset_entity.dart';
import 'package:asset_variation/app/modules/example/domain/repositories/asset_repository.dart';

class AssetRepositoryImpl implements AssetRepository {
  final AssetDatasource datasource;

  AssetRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<AssetEntity> getAsset() async {
    try {
      final model = await datasource.getAssetRemote();

      final entity = AssetMapper.toEntity(model);

      return entity;
    } catch (_) {
      throw Exception(); //TODO
    }
  }
}
