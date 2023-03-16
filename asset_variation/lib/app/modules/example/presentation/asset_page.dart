import 'package:asset_variation/app/commons/domain/enums/visualization_type.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:asset_variation/app/modules/example/presentation/asset_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

class AssetPage extends StatefulWidget {
  const AssetPage({super.key});

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  List<Color> gradientColors = [
    Color(0xFF50E4FF),
    Color(0xFF2196F3),
  ];

  final _vertical = ScrollController();

  @override
  void initState() {
    controller.fetchAsset();
    super.initState();
  }

  final controller = Modular.get<AssetController>();

  get _buildAsset => Expanded(
        child: ListView(
          children: controller.store.data!.timestamp
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$item",
                  ),
                ),
              )
              .toList(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Variação de Ativo"),
      ),
      body: Obx(
        () {
          if (controller.store.hasError) {
            return const Center(
              child: Text("Error loading data!"),
            );
          }

          if (controller.store.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!controller.store.anythigData)
                  const Text(
                    "No data loaded!",
                  ),
                if (controller.store.anythigData &&
                    controller.store.viewType == ViewType.chart)
                  Container(
                    color: Colors.black,
                    child: AspectRatio(
                      aspectRatio: 1.70,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 18,
                          left: 12,
                          top: 24,
                          bottom: 12,
                        ),
                        child: LineChart(avgData()),
                      ),
                    ),
                  ),
                if (controller.store.anythigData &&
                    controller.store.viewType == ViewType.table)
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Scrollbar(
                        controller: _vertical,
                        thumbVisibility: true,
                        trackVisibility: true,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Dia',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Data',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Valor',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Δ a D-1',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Δ a primeira',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ],
                            rows: controller.store.data!.openQuote
                                .mapIndexed(
                                  (index, element) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                        Text(
                                          index.toString(),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          DateFormat.yMd("pt_BR").format(
                                            controller
                                                .store.data!.timestamp[index],
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          NumberFormat.simpleCurrency(
                                                  locale: "pt_BR")
                                              .format(
                                            controller.store.data
                                                    ?.openQuote[index] ??
                                                controller.store.avg,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                          Text('${getVarationD1(index)}%')),
                                      DataCell(Text('Student')),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          controller.changeViewType(ViewType.chart),
                      child: const Text("Chart"),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          controller.changeViewType(ViewType.table),
                      child: const Text("Table"),
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

  LineChartData avgData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawHorizontalLine: true,
      ),
      titlesData: FlTitlesData(
        show: false,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: controller.store.spots.length.toDouble(),
      minY: controller.store.avg - 5,
      maxY: controller.store.avg + 5,
      lineBarsData: [
        LineChartBarData(
          spots: controller.store.spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String getVarationD1(int index) {
    if (index == 0) {
      return "-";
    }
    final previous =
        controller.store.data?.openQuote[index - 1] ?? controller.store.avg;

    final current =
        controller.store.data?.openQuote[index] ?? controller.store.avg;

    return ((current - previous) / previous * 100).toStringAsFixed(2);
  }
}
