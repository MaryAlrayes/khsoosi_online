// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';

import 'package:khosousi_online/features/accounts/presentation/profile_info/student/cubit/student_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/student/cubit/student_info_stepper_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/phone_numbers.dart';
import 'package:khosousi_online/features/location/domain/entities/country_entity.dart';

import '../../../common_widgets/next_btn.dart';

class StudentInfoStep1 extends StatelessWidget {
  final List<CountryEntity> countries;
  StudentInfoStep1({
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
              BlocProvider.of<StudentInfoCubit>(context).setMobile(value);
            },
            onWhatsAppChanged: (value) {
              BlocProvider.of<StudentInfoCubit>(context).setWhats(value);
            },
            onMobileCountryCodeChanged: (value) {
              BlocProvider.of<StudentInfoCubit>(context)
                  .setMobileCountryCode(value);
            },
            onWhatsCountryCodeChanged: (value) {
              BlocProvider.of<StudentInfoCubit>(context)
                  .setWhatsappCountryCode(value);
            },
            initialValueMobileCountryCode: context
                .read<StudentInfoCubit>()
                .state
                .studentInfoEntity
                .mobileCountry,
            initialValueMobile:
                context.read<StudentInfoCubit>().state.studentInfoEntity.mobile,
            initialValueWhatsApp: context
                .read<StudentInfoCubit>()
                .state
                .studentInfoEntity
                .whatsapp,
            initialValueWhatsCountryCode: context
                .read<StudentInfoCubit>()
                .state
                .studentInfoEntity
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
                          .read<StudentInfoCubit>()
                          .state
                          .studentInfoEntity
                          .mobileCountry ==
                      CountryEntity.empty()) {
                    showSnackbar(context, 'عليك إدخال رمز الدولة لرقم الجوال');
                  } else if (context
                          .read<StudentInfoCubit>()
                          .state
                          .studentInfoEntity
                          .whatsappCountry ==
                      CountryEntity.empty()) {
                    showSnackbar(
                        context, 'عليك إدخال رمز الدولة لرقم الواتساب');
                  } else {
                    BlocProvider.of<StudentInfoStepperCubit>(context)
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
