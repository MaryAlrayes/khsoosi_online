// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';

import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/autocomplete_input_chip.dart';
import 'package:khosousi_online/core/ui/widgets/autocomplete_text_field.dart';
import 'package:khosousi_online/features/location/domain/entities/country_entity.dart';

class CountryPicker extends StatelessWidget {
  final String label;
  final CountryEntity initialValue;
  final List<CountryEntity> countries;
  final Function onChanged;
  final VoidCallback onDelete;
  final bool isRequired;
  CountryPicker({
    Key? key,
    required this.label,
    required this.initialValue,
    required this.countries,
    required this.onChanged,
    required this.onDelete,
    this.isRequired = true,
  }) : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
              text: label,
              style: kBlackBoldTextStyle,
            ),
            if (isRequired)
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
          ]),
        ),
        SizedBox(
          height: 8,
        ),
        Autocomplete<CountryEntity>(
            initialValue: TextEditingValue(
                text: initialValue != CountryEntity.empty()
                    ? initialValue.countryNameAr.isNotEmpty
                        ? initialValue.countryNameAr
                        : initialValue.countryNameEn
                    : ''),
            displayStringForOption: (data) => data.countryNameAr.isNotEmpty
                ? data.countryNameAr
                : data.countryNameEn,
            fieldViewBuilder:
                (context, textController, focusNode, onFieldSubmitted) {
              controller = textController;

              return initialValue == CountryEntity.empty()
                  ? _buildCountriesSearchTextField(focusNode)
                  : _buildCountryChip(context);
            },
            optionsViewBuilder: (context, onSelected, options) {
              List<CountryEntity> _items = options.toList();
              return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    color: Colors.white,
                    elevation: 4.0,
                    child: Container(
                         child: ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8.0),
                          itemCount: _items.length,
                          separatorBuilder: (context, i) {
                            return Divider(color: ColorManager.gray2,);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            String label = '';
                            if (_items[index].countryNameAr.isNotEmpty) {
                              label += _items[index].countryNameAr;
                            }
                            if (_items[index].countryNameEn.isNotEmpty) {
                              if (label.isNotEmpty) label += ' | ';
                              label += _items[index].countryNameEn;
                            }
                            return InkWell(
                              onTap: () {
                                onSelected(_items[index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  label,
                                ),
                              ),
                            );
                          },
                        )),
                  ));
            },
            optionsViewOpenDirection: OptionsViewOpenDirection.down,
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<CountryEntity>.empty();
              }
              return countries.where(
                (element) =>
                    element.countryNameAr.toLowerCase().contains(
                          textEditingValue.text.toLowerCase(),
                        ) ||
                    element.countryNameEn
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()),
              );
            },
            onSelected: (option) {
              onChanged(option);
            })
      ],
    );
  }

  Widget _buildCountryChip(BuildContext context) {
    return AutocompleteInputChip(
      label: initialValue.countryNameAr.isNotEmpty
          ? initialValue.countryNameAr
          : initialValue.countryNameEn,
      onDeleted: () {
        controller.clear();
        onDelete();
      },
    );
  }

  Widget _buildCountriesSearchTextField(FocusNode focusNode) {
    return AutocompleteTextField(
      focusNode: focusNode,
      textEditingController: controller,
    );
  }
}
