import 'package:equatable/equatable.dart';

class AssetEntity extends Equatable {
  final List<DateTime> timestamp;
  final List<double?> openQuote;

  const AssetEntity({
    required this.timestamp,
    required this.openQuote,
  });

  @override
  List<Object?> get props => [
        timestamp,
      ];
}
