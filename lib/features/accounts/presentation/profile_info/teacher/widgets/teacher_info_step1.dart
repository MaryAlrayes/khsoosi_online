// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/cubit/teacher_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/cubit/teacher_info_stepper_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/phone_numbers.dart';

import 'package:khosousi_online/shared_features/domain/entities/country_entity.dart';

class TeacherInfoStep1 extends StatelessWidget {
  final List<CountryEntity> countries;
  const TeacherInfoStep1({
    Key? key,
    required this.countries,
  }) : super(key: key);
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PhoneNumbers(
            countries: countries,
            formkey: _formKey,
            onPhoneChanged: (value) {
              BlocProvider.of<TeacherInfoCubit>(context).setMobile(value);
            },
            onWhatsAppChanged: (value) {
              BlocProvider.of<TeacherInfoCubit>(context).setWhats(value);
            },
            onMobileCountryCodeChanged: (value) {
              BlocProvider.of<TeacherInfoCubit>(context)
                  .setMobileCountryCode(value);
            },
            onWhatsCountryCodeChanged: (value) {
              BlocProvider.of<TeacherInfoCubit>(context)
                  .setWhatsappCountryCode(value);
            },
            initialValueMobileCountryCode: context
                .read<TeacherInfoCubit>()
                .state
                .teacherInfoEntity
                .mobileCountry,
            initialValueMobile:
                context.read<TeacherInfoCubit>().state.teacherInfoEntity.mobile,
            initialValueWhatsApp: context
                .read<TeacherInfoCubit>()
                .state
                .teacherInfoEntity
                .whatsapp,
            initialValueWhatsCountryCode: context
                .read<TeacherInfoCubit>()
                .state
                .teacherInfoEntity
                .whatsappCountry,
          ),
          SizedBox(
            height: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              NextBtn(onPressed: () {
                final isValid = _formKey.currentState!.validate();
                if (isValid) {
                  if (context
                          .read<TeacherInfoCubit>()
                          .state
                          .teacherInfoEntity
                          .mobileCountry ==
                      CountryEntity.empty()) {
                    showSnackbar(context, 'عليك إدخال رمز الدولة لرقم الجوال');
                  } else if (context
                          .read<TeacherInfoCubit>()
                          .state
                          .teacherInfoEntity
                          .whatsappCountry ==
                      CountryEntity.empty()) {
                    showSnackbar(
                        context, 'عليك إدخال رمز الدولة لرقم الواتساب');
                  } else {
                    BlocProvider.of<TeacherInfoStepperCubit>(context)
                        .nextStep();
                  }
                }
              }),
            ],
          ),
        ],
      ),
    );
  }
}
