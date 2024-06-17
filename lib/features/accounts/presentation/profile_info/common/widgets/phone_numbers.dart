import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/countries_codes_picker.dart';

import '../../../../../location/domain/entities/country_entity.dart';

class PhoneNumbers extends StatelessWidget {
  final List<CountryEntity> countries;
  final GlobalKey<FormState> formkey;
  final Function onPhoneChanged;
  final Function onWhatsAppChanged;
  final Function onMobileCountryCodeChanged;
  final Function onWhatsCountryCodeChanged;
  final String initialValueMobile;
  final String initialValueWhatsApp;
  final CountryEntity initialValueMobileCountryCode;
  final CountryEntity initialValueWhatsCountryCode;
  const PhoneNumbers({
    Key? key,
    required this.countries,
    required this.formkey,
    required this.onPhoneChanged,
    required this.onWhatsAppChanged,
    required this.onMobileCountryCodeChanged,
    required this.onWhatsCountryCodeChanged,
    required this.initialValueMobile,
    required this.initialValueWhatsApp,
    required this.initialValueMobileCountryCode,
    required this.initialValueWhatsCountryCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPhones(context),
            SizedBox(
              height: 24,
            ),
            _buildWhats(context)
          ],
        ),
      ),
    );
  }

  Widget _buildPhones(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.phone),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: 'رقم الجوال (الاتصال): ',
                        style: kBlackBoldTextStyle,
                      ),
                      TextSpan(
                        text: '*',
                        style: TextStyle(color: Colors.red),
                      ),
                    ]),
              ),
            ),
          ],
        ),
        Text(
          'غير الزامي, لكن بإدخالك لرقم الجوال ستسطيع الاستفادة بأكبر شكل ممكن من خدماتنا.',
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomTextField(
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.phone,
                hintText: 'ادخل رقم الجوال',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'لا يمكن لهذا الحقل أن يبقى فارغ';
                  }
                },
                isObscure: false,
                withBorder: true,
                isFilled: true,
                initalValue: initialValueMobile,
                onChanged: (value) {
                  onPhoneChanged(value);
                },
              ),
            ),
            SizedBox(
              width: 4,
            ),
            _buildCountriesCode(
                initalValue: initialValueMobileCountryCode,
                onChanged: (value) {
                  onMobileCountryCodeChanged(value);
                })
          ],
        ),
      ],
    );
  }


  Column _buildWhats(BuildContext context) {
    return Column(

            children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              FontAwesomeIcons.whatsapp,
              color: ColorManager.green1,
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: 'رقم الواتس اب: ',
                        style: kBlackBoldTextStyle,
                      ),
                      TextSpan(
                        text: '*',
                        style: TextStyle(color: Colors.red),
                      ),
                    ]),
              ),
            ),
          ],
        ),
        Text(
          'غير إلزامي, لكن بإدخالك لرقم الجوال ستستطيع الاستفادة بأكبر شكل ممكن من خدماتنا.',
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          height: 8,
        ),
        Row( crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Expanded(
              child: CustomTextField(
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.phone,
                hintText: 'ادخل رقم الواتس اب',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'لا يمكن لهذا الحقل أن يبقى فارغ';
                  }
                },
                isObscure: false,
                withBorder: true,
                isFilled: true,
                initalValue: initialValueWhatsApp,
                onChanged: (value) {
                  onWhatsAppChanged(value);
                },
              ),
            ),
            SizedBox(
              width: 4,
            ),
            _buildCountriesCode(
                initalValue: initialValueWhatsCountryCode,
                onChanged: (value) {
                  onWhatsCountryCodeChanged(value);
                })
          ],
        ),
      ],
    );
  }
  Container _buildCountriesCode(
      {required CountryEntity initalValue, required Function onChanged}) {
    return Container(
      width: 125,
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorManager.gray1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            4,
          ),
        ),
      ),
      child: CountriesCodesPicker(
        countries: countries,
        initalValue: initalValue,
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }

}
