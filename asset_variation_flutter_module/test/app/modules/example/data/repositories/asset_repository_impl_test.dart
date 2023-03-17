import 'package:asset_variation_flutter_module/app/commons/domain/erros/errors.dart';
import 'package:asset_variation_flutter_module/app/modules/example/data/datasources/asset_datasource.dart';
import 'package:asset_variation_flutter_module/app/modules/example/data/repositories/asset_repository_impl.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/entities/asset_chart_entity.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/entities/asset_entity.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/repositories/asset_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mocks.dart';

class AssetDatasourceSpy extends Mock implements AssetDatasource {}

void main() {
  late AssetDatasource datasource;
  late AssetRepository sut;

  setUp(() {
    datasource = AssetDatasourceSpy();
    sut = AssetRepositoryImpl(
      datasource: datasource,
    );
  });

  group("getAssetChart", () {
    test(
      "Should call get assert chart datasource with success",
      () async {
        when(
          () => datasource.getAssetChartRemote(symbol: any(named: "symbol")),
        ).thenAnswer((_) async => Mocks.assetChartModelMock);

        final result = await sut.getAssetChart(symbol: "symbol");

        expect(result, isA<AssetChartEntity>());
        expect(result.openQuote, Mocks.assetChartEntityMock.openQuote);
        expect(result.timestamp, Mocks.assetChartEntityMock.timestamp);
      },
    );

    test(
      "Should failure repository get assert chart datasource",
      () async {
        when(
          () => datasource.getAssetChartRemote(symbol: any(named: "symbol")),
        ).thenThrow(
          FailureRepository(message: ""),
        );

        final result = sut.getAssetChart(symbol: "symbol");

        expect(result, throwsA(isA<FailureRepository>()));
      },
    );
  });

  group("searchAsset", () {
    test(
      "Should call get assert data datasource with success",
      () async {
        when(
          () => datasource.searchAssetRemote(symbol: any(named: "symbol")),
        ).thenAnswer((_) async => [Mocks.assetModelMock]);

        final result = await sut.searchAsset(symbol: "symbol");

        expect(result, isA<List<AssetEntity>>());
        expect(result.length, equals(1));
        expect(result.first.shortname, Mocks.assetEntityMock.shortname);
        expect(result.first.symbol, Mocks.assetEntityMock.symbol);
      },
    );

    test(
      "Should failure repository get assert chart datasource",
      () async {
        when(
          () => datasource.searchAssetRemote(symbol: any(named: "symbol")),
        ).thenThrow(
          FailureRepository(message: ""),
        );

        final result = sut.searchAsset(symbol: "symbol");

        expect(result, throwsA(isA<FailureRepository>()));
      },
    );
  });
}
