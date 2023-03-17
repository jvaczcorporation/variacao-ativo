import 'package:equatable/equatable.dart';

class AssetChartEntity extends Equatable {
  final List<DateTime> timestamp;
  final List<double?> openQuote;

  const AssetChartEntity({
    required this.timestamp,
    required this.openQuote,
  });

  double get total => openQuote
      .map((e) => e ?? 0.0)
      .toList()
      .reduce((value, element) => value + element);

  double get avg => total / openQuote.length;

  @override
  List<Object?> get props => [
        timestamp,
      ];
}
