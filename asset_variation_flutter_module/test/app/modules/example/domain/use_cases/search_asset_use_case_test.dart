import 'package:asset_variation_flutter_module/app/modules/example/domain/entities/asset_entity.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/repositories/asset_repository.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/use_cases/search_asset_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mocks.dart';

class AssetRepositorySpy extends Mock implements AssetRepository {}

void main() {
  late AssetRepository repository;
  late SearchAssetUseCase sut;

  setUp(() {
    repository = AssetRepositorySpy();
    sut = SearchAssetUseCaseImpl(
      repository: repository,
    );
  });

  test(
    "Should call search assert repository with success",
    () async {
      when(
        () => repository.searchAsset(symbol: any(named: "symbol")),
      ).thenAnswer((_) async => [Mocks.assetEntityMock]);

      final result = await sut.call(symbol: "symbol");

      expect(result, isA<List<AssetEntity>>());
      expect(result.length, equals(1));
      expect(result.first.shortname, Mocks.assetEntityMock.shortname);
      expect(result.first.symbol, Mocks.assetEntityMock.symbol);
    },
  );
}
