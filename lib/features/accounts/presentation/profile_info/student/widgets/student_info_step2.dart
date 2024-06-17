// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_error_message.dart';

import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/core/utils/helpers/toast_utils.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/previous_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/student/cubit/student_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/student/cubit/student_info_stepper_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/birth_date.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/country_picker.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/gender_selector.dart';
import 'package:khosousi_online/features/location/domain/entities/country_entity.dart';

class StudentInfoStep2 extends StatelessWidget {
  final List<CountryEntity> countries;
  StudentInfoStep2({
    Key? key,
    required this.countries,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentInfoCubit, StudentInfoState>(
      listener: (context, state) {
        _buildListener(state, context);
      },
      child: Column(
        children: [
          _buildGender(context),
          SizedBox(
            height: 16,
          ),
          _buildBirthDate(context),
          SizedBox(
            height: 16,
          ),
          _buildResidence(),
          SizedBox(
            height: 16,
          ),
          _buildErrorMessages(),
          SizedBox(
            height: 24,
          ),
          _buildBtns(context),
        ],
      ),
    );
  }

  BlocBuilder<StudentInfoCubit, StudentInfoState> _buildErrorMessages() {
    return BlocBuilder<StudentInfoCubit, StudentInfoState>(
        builder: (context, state) {
      return state.errorMessage.isEmpty
          ? Container()
          : CustomErrorMessage(
              errorMessage: state.errorMessage,
            );
    });
  }

  void _buildListener(StudentInfoState state, BuildContext context) {
    if (state.studentInfoStatus == StudentInfoStatus.done) {
      ToastUtils.showSusToastMessage('تم إضافة معلوماتك بنجاح');
      BlocProvider.of<StudentInfoStepperCubit>(context).nextStep();
    } else if (state.studentInfoStatus == StudentInfoStatus.noInternet) {
      showSnackbar(context, AppStrings.noInternetConnectionMessage);
    } else if (state.studentInfoStatus == StudentInfoStatus.networkError) {
      showSnackbar(context, AppStrings.networkError);
    }
  }

  Widget _buildBtns(BuildContext context) {
    return BlocBuilder<StudentInfoCubit, StudentInfoState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            NextBtn(
              isLoading: state.studentInfoStatus == StudentInfoStatus.loading,
              onPressed: state.studentInfoStatus == StudentInfoStatus.loading
                  ? () {}
                  : () {
                      final state = context.read<StudentInfoCubit>().state;
                      if (state.studentInfoEntity.bornDate == null) {
                        showSnackbar(context, 'من فضلك قم بإضافة تاريخ ميلادك');
                      } else if (state.studentInfoEntity.countryResidence ==
                          CountryEntity.empty()) {
                        showSnackbar(context, 'من فضلك قم بإدخال دولة الإقامة');
                      } else {
                        BlocProvider.of<StudentInfoCubit>(context).submit(
                          id: context.read<AuthRepo>().getUserId()!,
                        );
                      }
                    },
            ),
            SizedBox(
              height: 8,
            ),
            PreviousBtn(
              onPressed: state.studentInfoStatus == StudentInfoStatus.loading
                  ? () {}
                  : () {
                      BlocProvider.of<StudentInfoStepperCubit>(context)
                          .stepBack();
                    },
            ),
          ],
        );
      },
    );
  }

  BlocBuilder<StudentInfoCubit, StudentInfoState> _buildResidence() {
    return BlocBuilder<StudentInfoCubit, StudentInfoState>(
      builder: (context, state) {
        return CountryPicker(
          label: 'دولة الاقامة:',
          initialValue: state.studentInfoEntity.countryResidence,
          countries: countries,
          onChanged: (value) {
            BlocProvider.of<StudentInfoCubit>(context).setResidence(value);
          },
          onDelete: () {
            BlocProvider.of<StudentInfoCubit>(context).emptyResidence();
          },
        );
      },
    );
  }

  BirthDate _buildBirthDate(BuildContext context) {
    return BirthDate(
      initalValue:
          context.read<StudentInfoCubit>().state.studentInfoEntity.bornDate,
      onChanged: (value) {
        BlocProvider.of<StudentInfoCubit>(context).setBornDate(value);
      },
    );
  }

  GenderSelector _buildGender(BuildContext context) {
    return GenderSelector(
      initalVelue:
          context.read<StudentInfoCubit>().state.studentInfoEntity.gender,
      onChanged: (value) {
        BlocProvider.of<StudentInfoCubit>(context).setGender(value);
      },
    );
  }
}
