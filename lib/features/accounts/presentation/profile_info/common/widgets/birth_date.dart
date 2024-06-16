// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/student/cubit/student_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/screens/student_info.dart';

import '../../../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../../../core/utils/helpers/show_custom_bottom_sheet.dart';

class BirthDate extends StatefulWidget {
  final DateTime? initalValue;
  final Function onChanged;
  final String label;
  final bool isRequired;
  const BirthDate({
    Key? key,
    required this.initalValue,
    required this.onChanged,
    this.label='تاريخ الميلاد',
     this.isRequired=true,
  }) : super(key: key);

  @override
  State<BirthDate> createState() => _BirthDateState();
}

class _BirthDateState extends State<BirthDate> {
  DateTime? selectedDate;
  DateTime? date;
  @override
  void initState() {
    super.initState();
    date = widget.initalValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
              text:widget. label,
              style: kBlackBoldTextStyle,
            ),
           if(widget.isRequired) TextSpan(
              text: '*',
              style: TextStyle(color: Colors.red),
            ),
          ]),
        ),
        SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () async {
            final returnedValue = await _birthdateSelector(context);
                   widget.onChanged(returnedValue);
            setState(() {
              date = returnedValue;
            });

          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorManager.gray3,
              ),
              borderRadius: BorderRadius.circular(
                4,
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Text(date == null
                ? 'ادخل ${widget.label}'
                : '${date!.year}-${date!.month}-${date!.day}'),
          ),
        ),
      ],
    );
  }

  Future<dynamic> _birthdateSelector(BuildContext context) async {
    return await showCustomBottomSheet(
      context: context,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, selectedDate);
                    },
                    child: Text(
                      'تم',
                    )),
                Text(widget.label),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, date);
                  },
                  child: Text(
                    'إغلاق',
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: date,
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() {
                    selectedDate = newDateTime;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
