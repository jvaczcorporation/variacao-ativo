import 'package:asset_variation_flutter_module/app/modules/example/domain/entities/asset_chart_entity.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/repositories/asset_repository.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/use_cases/get_asset_chart_data_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mocks.dart';

class AssetRepositorySpy extends Mock implements AssetRepository {}

void main() {
  late AssetRepository repository;
  late GetAssetChartDataUseCaseImpl sut;

  setUp(() {
    repository = AssetRepositorySpy();
    sut = GetAssetChartDataUseCaseImpl(
      repository: repository,
    );
  });

  test(
    "Should call get assert chart repository with success",
    () async {
      when(
        () => repository.getAssetChart(symbol: any(named: "symbol")),
      ).thenAnswer((_) async => Mocks.assetChartEntityMock);

      final result = await sut.call(symbol: "symbol");

      expect(result, isA<AssetChartEntity>());
      expect(result.openQuote, Mocks.assetChartEntityMock.openQuote);
      expect(result.timestamp, Mocks.assetChartEntityMock.timestamp);
    },
  );
}
