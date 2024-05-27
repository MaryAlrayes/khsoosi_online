// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/font_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/app_drop_down.dart';
import 'package:khosousi_online/core/ui/widgets/autocomplete_input_chip.dart';
import 'package:khosousi_online/core/ui/widgets/autocomplete_text_field.dart';
import 'package:khosousi_online/core/ui/widgets/no_connection_widget.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/search/domain/entities/search_filter_entity.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/search_teacher/bloc/get_teachers_bloc.dart';
import 'package:khosousi_online/features/search/presentation/search_teacher/widgets/next_previous_btn.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/get_categories_bloc.dart';
import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';

import '../../../../../core/ui/widgets/error_widget.dart';

class SpecialityFilter extends StatefulWidget {
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;
  final bool withNext;
  SpecialityFilter({
    Key? key,
    this.onNext,
    this.onPrevious,
    this.withNext = true,
  }) : super(key: key);

  @override
  State<SpecialityFilter> createState() => _SpecialityFilterState();
}

class _SpecialityFilterState extends State<SpecialityFilter> {
  late TextEditingController specialityTextEditingController;
  late FocusNode specialityFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
        builder: (context, state) {
      return switch (state) {
        GetCategoriesInitial() || GetCategoriesLoading() => _buildLoading(),
        GetCategoriesNoInternet() => _buildNoInternet(context),
        GetCategoriesNetworkError error => _buildNetworkError(error, context),
        GetCategoriesLoaded(categories: var categories) =>
          _buildContent(categories)
      };
    });
  }

  BlocBuilder<FilterSearchCubit, FilterSearchState> _buildContent(
      List<CategoryEntity> categories) {
    return BlocBuilder<FilterSearchCubit, FilterSearchState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // _buildLabel(),
                // SizedBox(
                //   height: 8.h,
                // ),
                _buildCategoriesAutocomplete(state, categories, context),
              ],
            ),
            if (widget.withNext)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBeforeBtn(context),
                  _buildNextBtn(context),
                ],
              )
          ],
        );
      },
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

  Text _buildLabel() {
    return Text(
      'ادخل التخصص:',
      style: kBlackBoldTextStyle,
    );
  }

  Widget _buildCategoriesAutocomplete(FilterSearchState searchTeacherState,
      List<CategoryEntity> categories, BuildContext context) {
    return Autocomplete<CategoryEntity>(
      initialValue: TextEditingValue(
          text: searchTeacherState.filter.speciality != null
              ? searchTeacherState.filter.speciality!.name_ar.isNotEmpty
                  ? searchTeacherState.filter.speciality!.name_ar
                  : searchTeacherState.filter.speciality!.name_en
              : ''),
              optionsViewOpenDirection: OptionsViewOpenDirection.up,
      displayStringForOption: (data) =>
          data.name_ar.isNotEmpty ? data.name_ar : data.name_en,
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        specialityTextEditingController = textEditingController;
        specialityFocusNode = focusNode;

        return searchTeacherState.filter.speciality == null
            ? _buildCategoriesSearchTextField(textEditingController, focusNode)
            : _buildCategoriesChip(searchTeacherState, context);
      },
      optionsViewBuilder: (context, onSelected, options) {
        List<CategoryEntity> _items = options.toList();
        return Align(
            alignment: Alignment.topLeft,
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: Container(
                  width: MediaQuery.of(context).size.width - 90,
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8.0),
                    itemCount: _items.length,
                    separatorBuilder: (context, i) {
                      return Divider();
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
        specialityFocusNode.requestFocus();
        BlocProvider.of<FilterSearchCubit>(context).setspeciality(option);
      },
    );
  }

  Widget _buildCategoriesChip(FilterSearchState state, BuildContext context) {
    return AutocompleteInputChip(
      label: state.filter.speciality!.name_ar.isNotEmpty
          ? state.filter.speciality!.name_ar
          : state.filter.speciality!.name_en,
      onDeleted: () {
        BlocProvider.of<FilterSearchCubit>(context).emptySpeciality();
        specialityTextEditingController.clear();
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

  NextPreviousBtn _buildNextBtn(BuildContext context) {
    return NextPreviousBtn(
      nextOrPrevious: NextOrPrevious.next,
      onPressed: widget.onNext != null ? widget.onNext! : () {},
    );
  }

  NextPreviousBtn _buildBeforeBtn(BuildContext context) {
    return NextPreviousBtn(
      nextOrPrevious: NextOrPrevious.previous,
      onPressed: widget.onPrevious != null ? widget.onPrevious! : () {},
    );
  }
}
