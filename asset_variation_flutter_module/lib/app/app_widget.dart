import 'package:asset_variation_flutter_module/app/commons/presentation/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/date_symbol_data_local.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);

    return MaterialApp.router(
      title: 'Asset Variation',
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      theme: ThemeData(
        primarySwatch: AppTheme.purple,
      ),
    );
  }
}
