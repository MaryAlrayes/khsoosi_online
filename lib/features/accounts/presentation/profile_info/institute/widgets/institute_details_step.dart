import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/previous_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/multiline_field.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/cubit/institute_extra_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/cubit/institute_info_stepper_cubit.dart';

class InstituteDetailsStep extends StatelessWidget {
  const InstituteDetailsStep({super.key});

  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildInstituteName(context),
                SizedBox(
                  height: 24,
                ),
                _buildAboutInstitute(context),
                SizedBox(
                  height: 24,
                ),
                _buildAddressInstitute(context),
              ],
            )),
        SizedBox(
          height: 24,
        ),
        _buildBtns(context),
      ],
    );
  }

  Column _buildBtns(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        NextBtn(onPressed: () {
          final isValid = _formKey.currentState!.validate();
          if (isValid) {
            BlocProvider.of<InstituteInfoStepperCubit>(context).nextStep();
          }
        }),
      ],
    );
  }

  Column _buildInstituteName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
              text: 'الاسم باللغة الانكليزية: ',
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
        CustomTextField(
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'لا يمكن لهذا الحقل أن يبقى فارغ';
            }
          },
          isObscure: false,
          hintText: 'الاسم باللغة الانكليزية',
          initalValue: context
              .read<InstituteExtraInfoCubit>()
              .state
              .instituteExtraInfoEntity
              .name,
          onChanged: (value) {
            BlocProvider.of<InstituteExtraInfoCubit>(context).setName(value);
          },
        )
      ],
    );
  }

  Column _buildAboutInstitute(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
              text: 'عن مؤسستك التدريبية, معهدك, اكاديميتك: ',
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
        MultilineField(
          hint: 'ادخل معلومات عن معهدك',
          initValue: context
              .read<InstituteExtraInfoCubit>()
              .state
              .instituteExtraInfoEntity
              .name,
          onValidate: (value) {
            if (value == null || value.isEmpty) {
              return 'لا يمكن لهذا الحقل أن يبقى فارغ';
            }
          },
          onChanged: (value) {
            BlocProvider.of<InstituteExtraInfoCubit>(context).setAbout(value);
          },
        )
      ],
    );
  }

  Column _buildAddressInstitute(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
              text: 'عنوان المعهد: ',
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
        MultilineField(
            hint: 'ادخل عنوان المعهد',
            initValue: context
                .read<InstituteExtraInfoCubit>()
                .state
                .instituteExtraInfoEntity
                .address,
            onValidate: (value) {
              if (value == null || value.isEmpty) {
                return 'لا يمكن لهذا الحقل أن يبقى فارغ';
              }
            },
            onChanged: (value) {
              BlocProvider.of<InstituteExtraInfoCubit>(context)
                  .setAddress(value);
            })
      ],
    );
  }
}
