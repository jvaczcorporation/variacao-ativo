import 'package:asset_variation_flutter_module/app/modules/example/presentation/asset_controller.dart';
import 'package:asset_variation_flutter_module/app/modules/example/presentation/widgets/custom_type_ahead_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController symbolController = TextEditingController();

  final controller = Modular.get<AssetController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Buscar por código: ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Expanded(
            child: CustomTypeAheadField(
              enabled: true,
              controller: symbolController,
              suggestionsCallback: (pattern) async {
                if (pattern != "") {
                  return await controller.searchAssets(pattern);
                } else {
                  return Future.value([]);
                }
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(
                    suggestion,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
              onSuggestionSelected: (suggestion) {
                controller.chooseAsset(suggestion);
                symbolController.text = suggestion;
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
            ),
          ),
        ],
      ),
    );
  }
}
