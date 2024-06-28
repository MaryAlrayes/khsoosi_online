// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/multiline_field.dart';
import 'package:khosousi_online/shared_features/domain/entities/university_entity.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/get_universities_bloc.dart';

import '../../../../../../core/managers/color_manager.dart';
import '../../../../../../core/ui/style/common_styles.dart';
import '../../../../../../core/ui/widgets/autocomplete_text_field.dart';
import '../../../../../../core/ui/widgets/error_widget.dart';
import '../../../../../../core/ui/widgets/no_connection_widget.dart';

class UniversitiesPicker extends StatefulWidget {
  final List<UniversityEntity> selectedUniversities;
  final Function onDelete;
  final Function onSelect;
  const UniversitiesPicker({
    Key? key,
    required this.selectedUniversities,
    required this.onDelete,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<UniversitiesPicker> createState() => _UniversitiesPickerState();
}

class _UniversitiesPickerState extends State<UniversitiesPicker> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'الجامعات التي تقدم دروس لطلابها:',
          style: kBlackBoldTextStyle,
        ),
        SizedBox(
          height: 16,
        ),
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
              text: 'أسماء الجامعات',
              style: kBlackBoldTextStyle,
            ),
          ]),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'قم بإدخال الجامعات  الصحيحة لنربطك مع طلبة ضمن هذه الجامعات.',
          style: TextStyle(fontSize: 12,color:Colors.grey),
        ),
        SizedBox(
          height: 8,
        ),
        BlocBuilder<GetUniversitiesBloc, GetUniversitiesState>(
          builder: (context, state) {
            return switch (state) {
              GetUniversitiesInitial() ||
              GetUniversitiesLoading() =>
                _buildLoading(),
              GetUniversitiesNoInternet() => _buildNoInternet(context),
              GetUniversitiesNetworkError error =>
                _buildNetworkError(error, context),
              GetUniversitiesLoaded(universities: var universities) =>
                _buildUniversitiesAutocomplete(context, universities)
            };
          },
        ),
        SizedBox(
          height: 16,
        ),
        _buildUniversities(),

      ],
    );
  }

  Widget _buildUniversities() {
    return Wrap(
      spacing: 8,
      children: widget.selectedUniversities
          .map(
            (e) => Chip(
              backgroundColor: ColorManager.gray2,
              side: BorderSide(color: ColorManager.black, width: 0.5),
              label: Text(
                e.name,
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
      GetUniversitiesNetworkError error, BuildContext context) {
    return Center(
      child: NetworkErrorWidget(
        message: error.message,
        onPressed: () {
          BlocProvider.of<GetUniversitiesBloc>(context).add(
            LoadUniversitiesEvent(),
          );
        },
      ),
    );
  }

  Widget _buildNoInternet(BuildContext context) {
    return Center(
      child: NoConnectionWidget(onPressed: () {
        BlocProvider.of<GetUniversitiesBloc>(context).add(
          LoadUniversitiesEvent(),
        );
      }),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  Widget _buildUniversitiesAutocomplete(
    BuildContext context,
    List<UniversityEntity> categories,
  ) {
    return Autocomplete<UniversityEntity>(
      initialValue: TextEditingValue(text: ''),
      optionsViewOpenDirection: OptionsViewOpenDirection.down,
      displayStringForOption: (data) => data.name,
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        controller = textEditingController;

        return _buildUniversitySearchTextField(
            textEditingController, focusNode);
      },
      optionsViewBuilder: (context, onSelected, options) {
        List<UniversityEntity> _items = options.toList();
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
                  return Divider(
                    color: ColorManager.gray1,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  String label = '';
                  if (_items[index].name.isNotEmpty) {
                    label += _items[index].name;
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
          return const Iterable<UniversityEntity>.empty();
        }
        return categories
            .where((element) => element.name.toLowerCase().contains(
                  textEditingValue.text.toLowerCase(),
                ));
      },
      onSelected: (option) {
        controller.clear();
        widget.onSelect(option);
      },
    );
  }

  Widget _buildUniversitySearchTextField(
      TextEditingController controller, FocusNode focusNode) {
    return AutocompleteTextField(
      focusNode: focusNode,
      textEditingController: controller,
    );
  }
}
