import 'package:asset_variation_flutter_module/app/modules/example/domain/entities/asset_chart_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class TableView extends StatelessWidget {
  final AssetChartEntity asset;

  TableView({
    super.key,
    required this.asset,
  });

  final _verticalScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.white,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Scrollbar(
          controller: _verticalScroll,
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
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Data',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Valor',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Δ D-1',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Δ primeira data',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
              rows: asset.openQuote
                  .mapIndexed(
                    (index, element) => DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text(
                            index.toString(),
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            DateFormat.yMd("pt_BR").format(
                              asset.timestamp[index],
                            ),
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            NumberFormat.simpleCurrency(locale: "pt_BR").format(
                              asset.openQuote[index] ?? asset.avg,
                            ),
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            getVarationD1(index),
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            getVarationFistDate(index),
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  String getVarationD1(int index) {
    if (index == 0) {
      return "-";
    }
    final previous = asset.openQuote[index - 1] ?? asset.avg;

    final current = asset.openQuote[index] ?? asset.avg;

    return '${((current - previous) / previous * 100).toStringAsFixed(2)}%';
  }

  String getVarationFistDate(int index) {
    if (index == 0) {
      return "-";
    }
    final first = asset.openQuote[0] ?? asset.avg;
    ;

    final current = asset.openQuote[index] ?? asset.avg;

    return '${((current - first) / first * 100).toStringAsFixed(2)}%';
  }
}
