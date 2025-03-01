import 'package:asset_variation_flutter_module/app/commons/domain/erros/errors.dart';
import 'package:asset_variation_flutter_module/app/commons/domain/erros/mensagens.dart';
import 'package:asset_variation_flutter_module/app/modules/example/data/datasources/asset_datasource.dart';
import 'package:asset_variation_flutter_module/app/modules/example/data/models/asset_chart_model.dart';
import 'package:asset_variation_flutter_module/app/modules/example/data/models/asset_model.dart';
import 'package:dio/dio.dart';

class AssetDatasourceImpl implements AssetDatasource {
  final Dio dio;

  AssetDatasourceImpl({
    required this.dio,
  });

  @override
  Future<AssetChartModel> getAssetChartRemote({required String symbol}) async {
    try {
      final result = await dio.get(
          "https://query2.finance.yahoo.com/v8/finance/chart/$symbol?region=US&lang=en-US&includePrePost=false&interval=1d&useYfid=true&range=3mo&corsDomain=finance.yahoo.com&.tsrc=finance");

      if (result.statusCode != 200) {
        throw FailureDatasource(
          message: Messages.FAILED_GET_DATA,
        );
      }

      final timestamp =
          result.data["chart"]["result"][0]["timestamp"].cast<int>() as List;

      final openQuote = result.data["chart"]["result"][0]["indicators"]["quote"]
          [0]["open"] as List;
      final openQuoteToDouble =
          openQuote.map((e) => e.toDouble()).toList().cast<double?>();

      Map<String, dynamic> data = {
        "timestamp": timestamp.sublist(timestamp.length - 30, timestamp.length),
        "openQuote":
            openQuoteToDouble.sublist(timestamp.length - 30, timestamp.length),
      };

      final model = AssetChartModel.fromJson(data);

      return model;
    } catch (e) {
      throw FailureDatasource(
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<AssetModel>> searchAssetRemote({required String symbol}) async {
    try {
      final result = await dio.get(
          "https://query1.finance.yahoo.com/v1/finance/search?q=$symbol&lang=en-US&region=US&quotesCount=6&newsCount=2&listsCount=2&enableFuzzyQuery=false&quotesQueryId=tss_match_phrase_query&multiQuoteQueryId=multi_quote_single_token_query&newsQueryId=news_cie_vespa&enableCb=true&enableNavLinks=true&enableEnhancedTrivialQuery=true&enableResearchReports=true&enableCulturalAssets=true&enableLogoUrl=true&researchReportsCount=2");

      if (result.statusCode != 200) {
        throw FailureDatasource(
          message: Messages.FAILED_GET_DATA,
        );
      }

      final data = result.data["quotes"] as List;
      final validData = data.where(
        (item) =>
            item["shortname"] != null &&
            item["symbol"] != null &&
            item["exchange"] == "SAO",
      );

      final listModel =
          validData.map((item) => AssetModel.fromJson(item)).toList();

      return listModel;
    } catch (e) {
      throw FailureDatasource(
        message: e.toString(),
      );
    }
  }
}
