import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/autocomplete_text_field.dart';
import 'package:khosousi_online/core/ui/widgets/error_widget.dart';
import 'package:khosousi_online/core/ui/widgets/no_connection_widget.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/previous_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/cubit/teacher_extra_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/cubit/teacher_info_stepper_cubit.dart';
import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/get_categories_bloc.dart';

class TeacherInfoStep7 extends StatelessWidget {
  TeacherInfoStep7({super.key});
  late TextEditingController specialityTextEditingController;
  late FocusNode specialityFocusNode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'المجالات التي تقدم دروس و دورات ضمنها',
            style: kBlackBoldTextStyle,
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: ColorManager.gray1,
          ),
          SizedBox(
            height: 32,
          ),
          BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
              builder: (context, state) {
            return switch (state) {
              GetCategoriesInitial() ||
              GetCategoriesLoading() =>
                _buildLoading(),
              GetCategoriesNoInternet() => _buildNoInternet(context),
              GetCategoriesNetworkError error =>
                _buildNetworkError(error, context),
              GetCategoriesLoaded(categories: var categories) =>
                _buildContent(context, categories)
            };
          }),
          SizedBox(
            height: 16,
          ),
          _buildCategories(),
          SizedBox(
            height: 48,
          ),
          _buildBtns(context)
        ],
      ),
    );
  }

  Widget _buildBtns(BuildContext context) {
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            NextBtn(
              onPressed: () {
                if (context
                    .read<TeacherExtraInfoCubit>()
                    .state
                    .teacherExtraInfoEntity
                    .categories
                    .isEmpty) {
                  showSnackbar(context, 'عليك إدخال تخصص واحد على الأقل');
                } else if (context
                        .read<TeacherExtraInfoCubit>()
                        .state
                        .teacherExtraInfoEntity
                        .categories
                        .length >
                    8) {
                  showSnackbar(context, 'لا يمكنك إدخال أكثر من 8 اختصاصات');
                } else {
                  BlocProvider.of<TeacherInfoStepperCubit>(context).nextStep();
                }
              },
            ),
            SizedBox(
              height: 8,
            ),
            PreviousBtn(
              onPressed: () {
                BlocProvider.of<TeacherInfoStepperCubit>(context).stepBack();
              },
            ),
          ],
        );
      
  }

  Widget _buildContent(BuildContext context, List<CategoryEntity> categories) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
              text: 'تخصصاتك',
              style: kBlackBoldTextStyle,
            ),
            TextSpan(
              text: '*',
              style: TextStyle(color: Colors.red),
            ),
          ]),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'قم بإدخال تخصصاتك الصحيحة لنربطك مع طلبة مهتمين بخدماتك',
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          height: 16,
        ),
        _buildCategoriesAutocomplete(context, categories),
      ],
    );
  }

  BlocBuilder<TeacherExtraInfoCubit, TeacherExtraInfoState> _buildCategories() {
    return BlocBuilder<TeacherExtraInfoCubit, TeacherExtraInfoState>(
      builder: (context, state) {
        return Wrap(
          spacing:8,
          children: state.teacherExtraInfoEntity.categories
              .map(
                (e) => Chip(
                   backgroundColor: ColorManager.gray2,
                  side: BorderSide(color: ColorManager.black,width: 0.5),
                  label: Text(
                    e.name_ar + ' | ' + e.name_en,
                    style: TextStyle(fontSize: 10),

                  ),
                  onDeleted: () {
                    BlocProvider.of<TeacherExtraInfoCubit>(context)
                        .deleteCategory(e);
                  },
                ),
              )
              .toList(),
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
        specialityTextEditingController = textEditingController;
        specialityFocusNode = focusNode;

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
        specialityTextEditingController.clear();
        BlocProvider.of<TeacherExtraInfoCubit>(context).addCategory(option);
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
