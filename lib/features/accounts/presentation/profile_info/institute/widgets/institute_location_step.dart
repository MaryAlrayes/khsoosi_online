import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/cubit/institute_info_stepper_cubit.dart';
import 'package:khosousi_online/features/location/presentation/pages/location_map_screen.dart';

class InstituteLocationStep extends StatelessWidget {
  const InstituteLocationStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'تحديد الموقع الجغرافي',
          style: kBlackBoldTextStyle,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          'تحديد موقعك الجغرافي مهم جدا لعرض ملفك على الطلبة القريبين لك جغرافيا',
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 16,
        ),
        CustomElevatedButton(
          label: 'الانتقال لتحديد الموقع',
          icon: Icon(Icons.map),
          // backgroundColor: ColorManager.black,
          onPressed: () {
            Navigator.pushNamed(context, LocationMapScreen.routeName);
          },
        ),
        SizedBox(
          height: 40,
        ),
        _buildBtns(context)
      ],
    ));
  }

  Widget _buildBtns(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        NextBtn(
          onPressed: () {
            BlocProvider.of<InstituteInfoStepperCubit>(context).nextStep();
          },
        ),
      ],
    );
  }
}
