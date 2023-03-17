import 'package:asset_variation_flutter_module/app/commons/domain/erros/errors.dart';
import 'package:asset_variation_flutter_module/app/modules/example/data/datasources/asset_datasource.dart';
import 'package:asset_variation_flutter_module/app/modules/example/data/models/asset_chart_model.dart';
import 'package:asset_variation_flutter_module/app/modules/example/data/models/asset_model.dart';
import 'package:asset_variation_flutter_module/app/modules/example/infra/remote/asset_datasource_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mocks.dart';

class DioSpy extends Mock implements Dio {}

void main() {
  late Dio dio;
  late AssetDatasource sut;

  setUp(() {
    dio = DioSpy();
    sut = AssetDatasourceImpl(
      dio: dio,
    );
  });

  group("getAssetChartRemote", () {
    test(
      "Should call get assert chart remote with success",
      () async {
        when(
          () => dio.get(any()),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: "path",
            ),
            statusCode: 200,
            data: Mocks.assetChartToJsonMock,
          ),
        );

        final result = await sut.getAssetChartRemote(symbol: "symbol");

        expect(result, isA<AssetChartModel>());
      },
    );
    test(
      "Should emit failure datasource remote",
      () async {
        when(
          () => dio.get(any()),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: "path",
            ),
            statusCode: 502,
            data: Mocks.assetToJsonMock,
          ),
        );

        final result = sut.searchAssetRemote(symbol: "symbol");

        expect(result, throwsA(isA<FailureDatasource>()));
      },
    );
  });

  group("searchAssetRemote", () {
    test(
      "Should call get assert data remote with success",
      () async {
        when(
          () => dio.get(any()),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: "path",
            ),
            statusCode: 200,
            data: Mocks.assetToJsonMock,
          ),
        );

        final result = await sut.searchAssetRemote(symbol: "symbol");

        expect(result, isA<List<AssetModel>>());
        expect(result.length, equals(1));
      },
    );

    test(
      "Should emit failure datasource remote",
      () async {
        when(
          () => dio.get(any()),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: "path",
            ),
            statusCode: 502,
            data: Mocks.assetToJsonMock,
          ),
        );

        final result = sut.searchAssetRemote(symbol: "symbol");

        expect(result, throwsA(isA<FailureDatasource>()));
      },
    );
  });
}
