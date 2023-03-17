import 'package:asset_variation_flutter_module/app/commons/presentation/app_theme.dart';
import 'package:asset_variation_flutter_module/app/modules/example/domain/entities/asset_chart_entity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartView extends StatefulWidget {
  final List<FlSpot> spots;
  final AssetChartEntity asset;

  const ChartView({
    super.key,
    required this.spots,
    required this.asset,
  });

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  List<Color> gradientColors = const [
    Color(0xFF8142db),
    Color(0xFF320896),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 18,
          left: 12,
          top: 24,
          bottom: 12,
        ),
        child: LineChart(
          chartBuild(),
        ),
      ),
    );
  }

  LineChartData chartBuild() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (value) {
            return value
                .map(
                  (e) => LineTooltipItem(
                    "Valor: ${NumberFormat.simpleCurrency(locale: "pt_BR").format(e.y)} \n Data: ${DateFormat.yMd("pt_BR").format(
                      widget.asset.timestamp[e.x.round()],
                    )}",
                    const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                .toList();
          },
          tooltipBgColor: AppTheme.purple.withOpacity(0.3),
        ),
      ),
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
            reservedSize: 30,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: (widget.spots.length - 1).toDouble(),
      minY: widget.asset.avg - 5,
      maxY: widget.asset.avg + 5,
      lineBarsData: [
        LineChartBarData(
          spots: widget.spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 2,
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
}
