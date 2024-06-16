// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/core/utils/helpers/toast_utils.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/previous_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/cubit/teacher_info_stepper_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/birth_date.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/cities_picker.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/country_picker.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/gender_selector.dart';

import 'package:khosousi_online/shared_features/domain/entities/country_entity.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/get_cities_bloc.dart';

import '../cubit/teacher_info_cubit.dart';

class TeacherInfoStep2 extends StatelessWidget {
  final List<CountryEntity> countries;
  TeacherInfoStep2({
    Key? key,
    required this.countries,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return
       Column(
        children: [
          _buildGender(context),
          SizedBox(
            height: 16,
          ),
          _buildBirthDate(context),
          SizedBox(
            height: 16,
          ),
          _buildNationality(),
          SizedBox(
            height: 16,
          ),
          _buildCountryResidence(),
          SizedBox(
            height: 16,
          ),
          _buildCityResidence(),
          SizedBox(
            height: 16,
          ),
          _buildBtns(context),
        ],

    );
  }

  Widget _buildBtns(BuildContext context) {
    return BlocBuilder<TeacherInfoCubit, TeacherInfoState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            NextBtn(
              onPressed: () {
                final state = context.read<TeacherInfoCubit>().state;
                if (state.teacherInfoEntity.bornDate == null) {
                  showSnackbar(context, 'من فضلك قم بإضافة تاريخ ميلادك');
                } else if (state.teacherInfoEntity.nationality ==
                    CountryEntity.empty()) {
                  showSnackbar(context, 'من فضلك قم بإدخال جنسيتك');
                } else if (state.teacherInfoEntity.countryResidence ==
                    CountryEntity.empty()) {
                  showSnackbar(context, 'من فضلك قم بإدخال دولة الإقامة');
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
      },
    );
  }

  BlocBuilder<TeacherInfoCubit, TeacherInfoState> _buildNationality() {
    return BlocBuilder<TeacherInfoCubit, TeacherInfoState>(
      builder: (context, state) {
        return CountryPicker(
          label: 'الجنسية: ',
          initialValue: state.teacherInfoEntity.nationality,
          countries: countries,
          onChanged: (value) {
            BlocProvider.of<TeacherInfoCubit>(context).setNationality(value);
          },
          onDelete: () {
            BlocProvider.of<TeacherInfoCubit>(context).emptyNationality();
          },
        );
      },
    );
  }

  BlocBuilder<TeacherInfoCubit, TeacherInfoState> _buildCountryResidence() {
    return BlocBuilder<TeacherInfoCubit, TeacherInfoState>(
      builder: (context, state) {
        return CountryPicker(
          label: 'دولة الاقامة:',
          initialValue: state.teacherInfoEntity.countryResidence,
          countries: countries,
          onChanged: (value) {
            BlocProvider.of<TeacherInfoCubit>(context)
                .setCountryResidence(value);
            BlocProvider.of<GetCitiesBloc>(context)
                .add(LoadCitiesEvent(country: (value as CountryEntity).countryNameEn));
          },
          onDelete: () {
            BlocProvider.of<TeacherInfoCubit>(context).emptyResidence();
              BlocProvider.of<GetCitiesBloc>(context)
                .add(ResetCitiesEvent());

          },
        );
      },
    );
  }

  BlocBuilder<TeacherInfoCubit, TeacherInfoState> _buildCityResidence() {
    return BlocBuilder<TeacherInfoCubit, TeacherInfoState>(
      builder: (context, state) {
        return CitiesPicker(
          label: 'مدينة الاقامة:',
          initValue: state.teacherInfoEntity.cityResidence,
          onChanged: (value) {
            BlocProvider.of<TeacherInfoCubit>(context).setCityResidence(value);
          },
        );
      },
    );
  }

  BirthDate _buildBirthDate(BuildContext context) {
    return BirthDate(
      initalValue:
          context.read<TeacherInfoCubit>().state.teacherInfoEntity.bornDate,
      onChanged: (value) {
        BlocProvider.of<TeacherInfoCubit>(context).setBornDate(value);
      },
    );
  }

  GenderSelector _buildGender(BuildContext context) {
    return GenderSelector(
      initalVelue:
          context.read<TeacherInfoCubit>().state.teacherInfoEntity.gender,
      onChanged: (value) {
        BlocProvider.of<TeacherInfoCubit>(context).setGender(value);
      },
    );
  }
}
