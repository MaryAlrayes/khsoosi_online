// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/cubit/institute_info_stepper_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/cubit/intitute_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/phone_numbers.dart';

import 'package:khosousi_online/features/location/domain/entities/country_entity.dart';

class InstituteInfoStep1 extends StatelessWidget {
    final List<CountryEntity> countries;
  const InstituteInfoStep1({
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
              BlocProvider.of<IntituteInfoCubit>(context).setMobile(value);
            },
            onWhatsAppChanged: (value) {
              BlocProvider.of<IntituteInfoCubit>(context).setWhats(value);
            },
            onMobileCountryCodeChanged: (value) {
              BlocProvider.of<IntituteInfoCubit>(context)
                  .setMobileCountryCode(value);
            },
            onWhatsCountryCodeChanged: (value) {
              BlocProvider.of<IntituteInfoCubit>(context)
                  .setWhatsappCountryCode(value);
            },
            initialValueMobileCountryCode: context
                .read<IntituteInfoCubit>()
                .state
                .instituteContactEnitity
                .mobileCountry,
            initialValueMobile:
                context.read<IntituteInfoCubit>().state.instituteContactEnitity .mobile,
            initialValueWhatsApp: context
                .read<IntituteInfoCubit>()
                .state
                .instituteContactEnitity
                .whatsapp,
            initialValueWhatsCountryCode: context
                .read<IntituteInfoCubit>()
                .state
                .instituteContactEnitity
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
                          .read<IntituteInfoCubit>()
                          .state
                          .instituteContactEnitity
                          .mobileCountry ==
                      CountryEntity.empty()) {
                    showSnackbar(context, 'عليك إدخال رمز الدولة لرقم الجوال');
                  } else if (context
                          .read<IntituteInfoCubit>()
                          .state
                          .instituteContactEnitity
                          .whatsappCountry ==
                      CountryEntity.empty()) {
                    showSnackbar(
                        context, 'عليك إدخال رمز الدولة لرقم الواتساب');
                  } else {
                    BlocProvider.of<InstituteInfoStepperCubit>(context)
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
