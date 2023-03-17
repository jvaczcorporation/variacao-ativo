import 'dart:async';

import 'package:asset_variation_flutter_module/app/commons/helpers/upper_case_text_formatter.dart';
import 'package:asset_variation_flutter_module/app/commons/presentation/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CustomTypeAheadField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final Icon? icon;
  final TextInputType keyboardType;
  final bool obscureText;
  final FutureOr<Iterable<dynamic>> Function(String) suggestionsCallback;
  final Widget Function(BuildContext, dynamic) itemBuilder;
  final Widget Function(BuildContext, Widget, AnimationController?)?
      transitionBuilder;
  final Function(dynamic) onSuggestionSelected;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final bool enabled;

  const CustomTypeAheadField({
    Key? key,
    required this.enabled,
    required this.controller,
    required this.suggestionsCallback,
    required this.itemBuilder,
    required this.transitionBuilder,
    required this.onSuggestionSelected,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.hintText,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var message = "Nenhum ativo encontrado!";
    return Padding(
      padding: const EdgeInsets.only(top: 1.0, bottom: 10.0),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: AppTheme.purple,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 2.0,
            right: 2.0,
            top: 15.0,
          ),
          child: TypeAheadFormField(
            noItemsFoundBuilder: (BuildContext context) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            suggestionsBoxDecoration: const SuggestionsBoxDecoration(
              color: AppTheme.purple,
            ),
            textFieldConfiguration: TextFieldConfiguration(
              inputFormatters: [UpperCaseTextFormatter()],
              scrollPadding: const EdgeInsets.only(bottom: 180),
              enabled: enabled,
              onChanged: onChanged,
              keyboardType: keyboardType,
              controller: controller,
              obscureText: obscureText,
              cursorColor: Colors.white,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                icon: icon,
                contentPadding: const EdgeInsets.all(0),
                isDense: true,
                hintText: hintText,
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                disabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            debounceDuration: const Duration(milliseconds: 500),
            suggestionsCallback: suggestionsCallback,
            itemBuilder: itemBuilder,
            transitionBuilder: transitionBuilder,
            onSuggestionSelected: onSuggestionSelected,
            validator: validator,
            onSaved: onSaved,
          ),
        ),
      ),
    );
  }
}
