import 'package:asset_variation_flutter_module/app/modules/example/data/repositories/asset_repository_impl.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/use_cases/get_asset_chart_data_use_case.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/use_cases/search_asset_use_case.dart';
import 'package:asset_variation_flutter_module/app/modules/example/infra/remote/asset_datasource_impl.dart';
import 'package:asset_variation_flutter_module/app/modules/example/presentation/asset_controller.dart';
import 'package:asset_variation_flutter_module/app/modules/example/presentation/asset_page.dart';
import 'package:asset_variation_flutter_module/app/modules/example/presentation/asset_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AssetModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => AssetDatasourceImpl(
            dio: i(),
          ),
        ),
        Bind.factory(
          (i) => AssetRepositoryImpl(
            datasource: i(),
          ),
        ),
        Bind.factory(
          (i) => GetAssetChartDataUseCaseImpl(
            repository: i(),
          ),
        ),
        Bind.factory(
          (i) => SearchAssetUseCaseImpl(
            repository: i(),
          ),
        ),
        Bind.singleton(
          (i) => AssetStore(),
        ),
        Bind.factory(
          (i) => AssetController(
            store: i(),
            getAssetChartDataUseCase: i(),
            searchAssetUseCase: i(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => AssetPage(
            viewType: args.queryParams["viewType"] ?? 'chart',
          ),
          transition: TransitionType.noTransition,
        ),
        ChildRoute(
          '/asset',
          child: (context, args) => AssetPage(
            viewType: args.queryParams["viewType"] ?? 'chart',
          ),
          transition: TransitionType.noTransition,
        ),
      ];
}
