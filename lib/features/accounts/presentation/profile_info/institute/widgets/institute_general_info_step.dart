// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_error_message.dart';

import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/core/utils/helpers/toast_utils.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/previous_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/cubit/institute_info_stepper_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/cubit/intitute_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/birth_date.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/country_picker.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/gender_selector.dart';
import 'package:khosousi_online/features/location/domain/entities/country_entity.dart';
import 'package:khosousi_online/features/location/presentation/blocs/get_cities_bloc.dart';

import '../../common/widgets/cities_picker.dart';

class InstituteGeneralInfoStep extends StatelessWidget {
  final List<CountryEntity> countries;
  InstituteGeneralInfoStep({
    Key? key,
    required this.countries,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<IntituteInfoCubit, IntituteInfoState>(
      listener: (context, state) {
        _buildListener(state, context);
      },
      child: Column(
        children: [
          _buildDate(context),
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
          ),_buildErrorMessages(),
            SizedBox(
            height: 16,
          ),
          _buildBtns(context),
        ],
      ),
    );
  }

  BlocBuilder<IntituteInfoCubit, IntituteInfoState> _buildErrorMessages() {
    return BlocBuilder<IntituteInfoCubit, IntituteInfoState>(
        builder: (context, state) {
      return state.errorMessage.isEmpty
          ? Container()
          : CustomErrorMessage(
              errorMessage: state.errorMessage,
            );
    });
  }

  void _buildListener(IntituteInfoState state, BuildContext context) {
    if (state.intituteInfoStatus == IntituteInfoStatus.done) {
      ToastUtils.showSusToastMessage('تم إضافة معلوماتك بنجاح');
      BlocProvider.of<InstituteInfoStepperCubit>(context).nextStep();
    } else if (state.intituteInfoStatus == IntituteInfoStatus.noInternet) {
      showSnackbar(context, AppStrings.noInternetConnectionMessage);
    } else if (state.intituteInfoStatus == IntituteInfoStatus.networkError) {
      showSnackbar(context, AppStrings.networkError);
    }
  }

  Widget _buildBtns(BuildContext context) {
    return BlocBuilder<IntituteInfoCubit, IntituteInfoState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            NextBtn(
              isLoading: state.intituteInfoStatus == IntituteInfoStatus.loading,
              onPressed: state.intituteInfoStatus == IntituteInfoStatus.loading
                  ? () {}
                  : () {
                      final state = context.read<IntituteInfoCubit>().state;
                      if (state.instituteContactEnitity.bornDate == null) {
                        showSnackbar(context, 'من فضلك قم بإضافة تاريخ ميلادك');
                      } else if (state.instituteContactEnitity.nationality ==
                          CountryEntity.empty()) {
                        showSnackbar(context, 'من فضلك قم بإدخال جنسيتك');
                      } else if (state
                              .instituteContactEnitity.countryResidence ==
                          CountryEntity.empty()) {
                        showSnackbar(context, 'من فضلك قم بإدخال دولة الإقامة');
                      } else {
                        BlocProvider.of<IntituteInfoCubit>(context)
                            .submit(id: context.read<AuthRepo>().getUserId()!);
                      }
                    },
            ),
            SizedBox(
              height: 8,
            ),
            PreviousBtn(
              onPressed: state.intituteInfoStatus == IntituteInfoStatus.loading
                  ? () {}
                  : () {
                      BlocProvider.of<InstituteInfoStepperCubit>(context)
                          .stepBack();
                    },
            ),
          ],
        );
      },
    );
  }

  BlocBuilder<IntituteInfoCubit, IntituteInfoState> _buildNationality() {
    return BlocBuilder<IntituteInfoCubit, IntituteInfoState>(
      builder: (context, state) {
        return CountryPicker(
          label: 'الجنسية: ',
          initialValue: state.instituteContactEnitity.nationality,
          countries: countries,
          onChanged: (value) {
            BlocProvider.of<IntituteInfoCubit>(context).setNationality(value);
          },
          onDelete: () {
            BlocProvider.of<IntituteInfoCubit>(context).emptyNationality();
          },
        );
      },
    );
  }

  BlocBuilder<IntituteInfoCubit, IntituteInfoState> _buildCountryResidence() {
    return BlocBuilder<IntituteInfoCubit, IntituteInfoState>(
      builder: (context, state) {
        return CountryPicker(
          label: 'دولة الاقامة:',
          initialValue: state.instituteContactEnitity.countryResidence,
          countries: countries,
          onChanged: (value) {
            BlocProvider.of<IntituteInfoCubit>(context)
                .setCountryResidence(value);
            BlocProvider.of<GetCitiesBloc>(context).add(LoadCitiesEvent(
                country: (value as CountryEntity).countryNameEn));
          },
          onDelete: () {
            BlocProvider.of<IntituteInfoCubit>(context).emptyResidence();
            BlocProvider.of<GetCitiesBloc>(context).add(ResetCitiesEvent());
          },
        );
      },
    );
  }

  BlocBuilder<IntituteInfoCubit, IntituteInfoState> _buildCityResidence() {
    return BlocBuilder<IntituteInfoCubit, IntituteInfoState>(
      builder: (context, state) {
        return CitiesPicker(
          label: 'مدينة الاقامة:',
          initValue: state.instituteContactEnitity.cityResidence,
          onChanged: (value) {
            BlocProvider.of<IntituteInfoCubit>(context).setCityResidence(value);
          },
        );
      },
    );
  }

  BirthDate _buildDate(BuildContext context) {
    return BirthDate(
      label: 'تاريخ التأسيس: ',
      initalValue: context
          .read<IntituteInfoCubit>()
          .state
          .instituteContactEnitity
          .bornDate,
      onChanged: (value) {
        BlocProvider.of<IntituteInfoCubit>(context).setBornDate(value);
      },
    );
  }
}
