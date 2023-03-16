import 'dart:convert';

import 'package:asset_variation/app/modules/example/data/datasources/asset_datasource.dart';
import 'package:asset_variation/app/modules/example/data/models/asset_model.dart';
import 'package:dio/dio.dart';

class AssetDatasourceImpl implements AssetDatasource {
  final Dio dio;

  AssetDatasourceImpl({
    required this.dio,
  });

  @override
  Future<AssetModel> getAssetRemote() async {
    try {
      final result = await dio.get(
          "https://query2.finance.yahoo.com/v8/finance/chart/ENBR3.SA?region=US&lang=en-US&includePrePost=false&interval=1d&useYfid=true&range=1mo&corsDomain=finance.yahoo.com&.tsrc=finance");

      Map<String, dynamic> data = {
        "timestamp": result.data["chart"]["result"][0]["timestamp"].cast<int>(),
        "openQuote": result.data["chart"]["result"][0]["indicators"]["quote"][0]
                ["open"]
            .cast<double?>()
      };

      final model = AssetModel.fromJson(data);

      return model;
    } catch (_) {
      throw Exception(); //TODO
    }
  }
}
