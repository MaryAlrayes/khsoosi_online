import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/features/accounts/presentation/signup/cubit/signup_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/signup/cubit/signup_stepper_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/previous_btn.dart';

class SelectUserType extends StatelessWidget {
  const SelectUserType({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RichText(
              text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: 'أنا:',
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
            ...UserType.values
                .map(
                  (type) => BlocBuilder<SignupCubit, SignupState>(
                    builder: (context, state) {
                      return Directionality(
                        textDirection: TextDirection.ltr,
                        child: RadioListTile<UserType>(
                          title: Text(
                            type.getText(),
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 12),
                          ),
                          value: type,
                          groupValue: state.signupDataEntity.userType,
                          selected: state.signupDataEntity.userType == type,
                          secondary: Icon(
                            type == UserType.student
                                ? FontAwesomeIcons.graduationCap
                                : type == UserType.teacher
                                    ? FontAwesomeIcons.chalkboardUser
                                    : FontAwesomeIcons.building,
                            size: 20,
                          ),
                          onChanged: (value) {
                            BlocProvider.of<SignupCubit>(context)
                                .setUserType(value!);
                          },
                        ),
                      );
                    },
                  ),
                )
                .toList(),
          ],
        ),
        SizedBox(
          height: 24,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            NextBtn(onPressed: () {
              if (context.read<SignupCubit>().state.signupDataEntity.userType ==
                  null) {
                showSnackbar(context,
                    'من فضلك قم بالاختيار قبل الانتقال للخطوة التالية');
              } else {
                BlocProvider.of<SignupStepperCubit>(context).nextStep();
              }
            }),
          
          ],
        ),
      ],
    );
  }
}
