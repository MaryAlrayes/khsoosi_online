import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/locator/service_locator.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/search/domain/entities/search_filter_entity.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_stepper_cubit.dart';
import 'package:khosousi_online/features/search/presentation/filter/screens/filter_stepper.dart';
import 'package:khosousi_online/features/search/presentation/filter/widgets/educational_level.dart';
import 'package:khosousi_online/features/search/presentation/filter/widgets/gender.dart';
import 'package:khosousi_online/features/search/presentation/filter/widgets/keyword.dart';
import 'package:khosousi_online/features/search/presentation/filter/widgets/location.dart';
import 'package:khosousi_online/features/search/presentation/filter/widgets/speciality.dart';
import 'package:khosousi_online/features/search/presentation/filter/widgets/teaching_method.dart';
import 'package:khosousi_online/features/search/presentation/search_teacher/bloc/get_teachers_bloc.dart';
import 'package:khosousi_online/features/search/presentation/search_teacher/widgets/next_previous_btn.dart';

class FilterScreen extends StatelessWidget {
  static const routeName = 'filter_screen';
  final SearchType searchType;

  FilterScreen({
    Key? key,
    required this.searchType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<FilterStepperCubit>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('فلاتر البحث'),
            actions: [_buildCancelBtn(context)],
          ),
          body: _buildStepper(context),
        );
      }),
    );
  }

  Widget _buildStepper(
    BuildContext context,
  ) {
    return SingleChildScrollView(
      child: BlocBuilder<FilterSearchCubit, FilterSearchState>(
        builder: (context, state) {
          return FilterStepper(
            steps: _getFilterContent(context, searchType, state.filter),
            search: () {
              _search(context);
            },
          );
        },
      ),
    );
  }

  TextButton _buildCancelBtn(BuildContext context) {
    return TextButton(
      onPressed: () {
        BlocProvider.of<FilterSearchCubit>(context).restoreFilter();
        Navigator.pop(context);
      },
      child: Text('إغلاق'),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
    );
  }

  void _search(BuildContext context) {
    switch (searchType) {
      case SearchType.teachers:
        BlocProvider.of<GetTeachersBloc>(context).add(
          LoadTeachersEvent(
            refresh: true,
            filter: context.read<FilterSearchCubit>().state.filter,
          ),
        );
        Navigator.pop(context);
      case SearchType.courses:
      // TODO: Handle this case.
      case SearchType.institutes:
      // TODO: Handle this case.
      case SearchType.services:
      // TODO: Handle this case.
    }
  }

  List<Map<String, dynamic>> _getFilterContent(
      BuildContext context, SearchType searchType, SearchFilterEntity filter) {
    switch (searchType) {
      case SearchType.teachers:
        return [
          {
            'title': 'طريقة التدريس',
            'content': TeachingMethodFilter(
              withNextBtn: false,
            ),
          },
          if (context.read<FilterSearchCubit>().state.filter.teachingMethod ==
              TeachingMethod.presence)
            {
              'title': 'موقع المدرس',
              'content': LocationFilter(
                withNext: true,
                onNext: () {
                  BlocProvider.of<FilterStepperCubit>(context).nextStep();
                },
                onPrevious: () {
                  BlocProvider.of<FilterStepperCubit>(context).previousStep();
                },
              ),
              'enableControlBtn': false,
            },
          {
            'title': 'المرحلة الدراسية',
            'content': EducationalLevelFilter(
              withNext: false,
            ),
          },
          {
            'title': 'التخصص',
            'content': SpecialityFilter(
              withNext: false,
            ),
          },
          {
            'title': 'جنس المدرس',
            'content': GenderFilter(
              withNext: false,
            ),
          },
          {
            'title': 'كلمة البحث',
            'content': KeywordFilter(
              withNext: false,
            )
          },
        ];
      case SearchType.courses:
        return [
          {
            'title': 'حضوري أو عن بعد',
            'content': TeachingMethodFilter(
              withNextBtn: false,
            ),
          },
          {
            'title': 'الموقع',
            'content': LocationFilter(
              withNext: true,
              onNext: () {
                BlocProvider.of<FilterStepperCubit>(context).nextStep();
              },
              onPrevious: () {
                BlocProvider.of<FilterStepperCubit>(context).previousStep();
              },
            ),
            'enableControlBtn': false,
          },
          {
            'title': 'المرحلة',
            'content': EducationalLevelFilter(
              withNext: false,
            ),
          },
          {
            'title': 'التخصص',
            'content': SpecialityFilter(
              withNext: false,
            ),
          },
          {
            'title': 'الجنس',
            'content': GenderFilter(
              withNext: false,
            ),
          },
          {
            'title': 'كلمة البحث',
            'content': KeywordFilter(
              withNext: false,
            )
          },
        ];
      case SearchType.institutes:
        return [
          {
            'title': 'التخصص',
            'content': SpecialityFilter(
              withNext: false,
            ),
          },
          {
            'title': 'الموقع',
            'content': LocationFilter(
              withNext: true,
              onNext: () {
                BlocProvider.of<FilterStepperCubit>(context).nextStep();
              },
              onPrevious: () {
                BlocProvider.of<FilterStepperCubit>(context).previousStep();
              },
            ),
            'enableControlBtn': false,
          },
        ];
      case SearchType.services:
        return [
          {
            'title': 'الموقع',
            'content': LocationFilter(
              withNext: true,
              onNext: () {
                BlocProvider.of<FilterStepperCubit>(context).nextStep();
              },
              onPrevious: () {
                BlocProvider.of<FilterStepperCubit>(context).previousStep();
              },
            ),
            'enableControlBtn': false,
          },
          {
            'title': 'كلمة البحث',
            'content': KeywordFilter(
              withNext: false,
            )
          },
        ];
    }
  }
}
