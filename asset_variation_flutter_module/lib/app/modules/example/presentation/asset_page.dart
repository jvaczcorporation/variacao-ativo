import 'package:asset_variation_flutter_module/app/commons/domain/enums/visualization_type.dart';
import 'package:asset_variation_flutter_module/app/commons/presentation/app_theme.dart';
import 'package:asset_variation_flutter_module/app/modules/example/presentation/widgets/chart_view.dart';
import 'package:asset_variation_flutter_module/app/modules/example/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:asset_variation_flutter_module/app/modules/example/presentation/asset_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'widgets/table_view.dart';

class AssetPage extends StatefulWidget {
  final String viewType;

  const AssetPage({
    super.key,
    required this.viewType,
  });

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  final controller = Modular.get<AssetController>();
  late ViewType viewType;

  @override
  void initState() {
    viewType = ViewType.values.firstWhere(
      (type) => type.name == widget.viewType,
    );
    controller.fetchAsset(viewType);

    super.initState();
  }

  String get _getTitle =>
      '${viewType == ViewType.chart ? "Gráfico de Variação" : "Tabela de Variação"} (Flutter)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          _getTitle,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            SystemNavigator.pop();
          },
        ),
      ),
      body: Obx(
        () {
          if (controller.store.hasError) {
            return const Center(
              child: Text("Falha ao carregar dados!"),
            );
          }

          if (controller.store.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppTheme.purple,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                  ),
                  child: const SearchBar(),
                ),
                if (!controller.store.anythigData)
                  const Text(
                    "Nenhum dado carregado!",
                  ),
                if (controller.store.anythigData)
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                            bottom: 10.0,
                          ),
                          child: Text(
                            "${controller.store.assetSelected?.symbol ?? ""} (${controller.store.assetSelected?.shortname ?? ""})",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        if (controller.store.viewType == ViewType.chart)
                          ChartView(
                            asset: controller.store.data!,
                            spots: controller.store.spots,
                          ),
                        if (controller.store.viewType == ViewType.table)
                          Expanded(
                            child: TableView(
                              asset: controller.store.data!,
                            ),
                          ),
                      ],
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          controller.changeViewType(ViewType.chart),
                      child: const Text("Gráfico"),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          controller.changeViewType(ViewType.table),
                      child: const Text("Tabela"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
