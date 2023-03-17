import 'package:asset_variation_flutter_module/app/modules/example/data/datasources/asset_datasource.dart';
import 'package:asset_variation_flutter_module/app/modules/example/data/mappers/asset_chart_mapper.dart';
import 'package:asset_variation_flutter_module/app/modules/example/data/mappers/asset_mapper.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/entities/asset_chart_entity.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/entities/asset_entity.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/repositories/asset_repository.dart';

class AssetRepositoryImpl implements AssetRepository {
  final AssetDatasource datasource;

  AssetRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<AssetChartEntity> getAssetChart({required String symbol}) async {
    try {
      final model = await datasource.getAssetChartRemote(symbol: symbol);

      final entity = AssetChartMapper.toEntity(model);

      return entity;
    } catch (_) {
      throw Exception(); //TODO
    }
  }

  @override
  Future<List<AssetEntity>> searchAsset({required String symbol}) async {
    try {
      final listModel = await datasource.searchAssetRemote(symbol: symbol);

      final listEntity =
          listModel.map((model) => AssetMapper.toEntity(model)).toList();

      return listEntity;
    } catch (_) {
      throw Exception(); //TODO
    }
  }
}
