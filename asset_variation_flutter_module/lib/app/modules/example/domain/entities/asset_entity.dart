import 'package:equatable/equatable.dart';

class AssetEntity extends Equatable {
  final String shortname;
  final String symbol;

  const AssetEntity({
    required this.shortname,
    required this.symbol,
  });

  @override
  List<Object?> get props => [
        shortname,
        symbol,
      ];
}
