// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/autocomplete_text_field.dart';
import 'package:khosousi_online/core/ui/widgets/error_widget.dart';
import 'package:khosousi_online/core/ui/widgets/no_connection_widget.dart';
import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/get_categories_bloc.dart';

class CategoriesPicker extends StatefulWidget {
  final List<CategoryEntity> selectedCategories;
  final Function onDelete;
  final Function onSelect;
   CategoriesPicker({
    Key? key,
    required this.selectedCategories,
    required this.onDelete,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<CategoriesPicker> createState() => _CategoriesPickerState();
}

class _CategoriesPickerState extends State<CategoriesPicker> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
            builder: (context, state) {
          return switch (state) {
            GetCategoriesInitial() || GetCategoriesLoading() => _buildLoading(),
            GetCategoriesNoInternet() => _buildNoInternet(context),
            GetCategoriesNetworkError error =>
              _buildNetworkError(error, context),
            GetCategoriesLoaded(categories: var categories) =>
              _buildCategoriesAutocomplete(context, categories)
          };
        }),
        SizedBox(
          height: 16,
        ),
        _buildCategories(),
        SizedBox(
          height: 48,
        ),
      ],
    );
  }

 Widget _buildCategories() {
    return Wrap(
          spacing:8,
          children: widget.selectedCategories
              .map(
                (e) => Chip(
                   backgroundColor: ColorManager.gray2,
                  side: BorderSide(color: ColorManager.black,width: 0.5),
                  label: Text(
                    e.name_ar + ' | ' + e.name_en,
                    style: TextStyle(fontSize: 10),

                  ),
                  onDeleted: () {
                   widget.onDelete(e);
                  },
                ),
              )
              .toList(),

    );
  }

  Widget _buildNetworkError(
      GetCategoriesNetworkError error, BuildContext context) {
    return Center(
      child: NetworkErrorWidget(
        message: error.message,
        onPressed: () {
          BlocProvider.of<GetCategoriesBloc>(context).add(
            LoadCategoriesEvent(),
          );
        },
      ),
    );
  }

  Widget _buildNoInternet(BuildContext context) {
    return Center(
      child: NoConnectionWidget(onPressed: () {
        BlocProvider.of<GetCategoriesBloc>(context).add(
          LoadCategoriesEvent(),
        );
      }),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  Widget _buildCategoriesAutocomplete(
    BuildContext context,
    List<CategoryEntity> categories,
  ) {
    return Autocomplete<CategoryEntity>(
      initialValue: TextEditingValue(text: ''),
      optionsViewOpenDirection: OptionsViewOpenDirection.up,
      displayStringForOption: (data) =>
          data.name_ar.isNotEmpty ? data.name_ar : data.name_en,
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        controller = textEditingController;

        return _buildCategoriesSearchTextField(
            textEditingController, focusNode);
      },
      optionsViewBuilder: (context, onSelected, options) {
        List<CategoryEntity> _items = options.toList();
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
                      return Divider(color: ColorManager.gray1,);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      String label = '';
                      if (_items[index].name_ar.isNotEmpty) {
                        label += _items[index].name_ar;
                      }
                      if (_items[index].name_en.isNotEmpty) {
                        if (label.isNotEmpty) label += ' | ';
                        label += _items[index].name_en;
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
      optionsBuilder: (textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<CategoryEntity>.empty();
        }
        return categories.where(
          (element) =>
              element.name_ar.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  ) ||
              element.name_en
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase()),
        );
      },
      onSelected: (option) {
        // specialityFocusNode.requestFocus();
        controller.clear();
        widget.onSelect(option);
      },
    );
  }

  Widget _buildCategoriesSearchTextField(
      TextEditingController controller, FocusNode focusNode) {
    return AutocompleteTextField(
      focusNode: focusNode,
      textEditingController: controller,
    );
  }
}
