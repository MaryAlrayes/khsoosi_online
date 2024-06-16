import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/multiline_field.dart';

class InstituteInfoStep3 extends StatelessWidget {
  const InstituteInfoStep3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildInstituteName(context),
        SizedBox(
          height: 16,
        ),
        _buildAboutInstitute(context),
        SizedBox(
          height: 16,
        ),
        _buildAddressInstitute(context)
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
              text: 'اسم المعهد: ',
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
          validator: (value) {},
          isObscure: false,
          hintText: 'اسم المعهد',
          onChanged: (value) {},
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
              text: 'حول المعهد: ',
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
          hint: 'حول المعهد',
          onChanged: (value) {},
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
          onChanged: (value) {},
        )
      ],
    );
  }
}
