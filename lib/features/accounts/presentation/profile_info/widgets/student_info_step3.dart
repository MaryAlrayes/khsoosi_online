import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/core/utils/helpers/toast_utils.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/previous_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/login/blocs/authentication_bloc.dart';
import 'package:khosousi_online/features/accounts/presentation/otp/screens/otp_screen.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/cubit/upload_picture_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/widgets/profile_image.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import 'package:khosousi_online/features/app_wrapper/app_wrapper.dart';

class StudentInfoStep3 extends StatelessWidget {
  const StudentInfoStep3({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.locator<UploadPictureCubit>(),
      child: Builder(builder: (context) {
        return BlocListener<UploadPictureCubit, UploadPictureState>(
          listener: (context, state) {
            _buildListener(state, context);
          },
          child: Column(
            children: [
              _buildImage(context),
              SizedBox(
                height: 16,
              ),
              _buildBtns(),
            ],
          ),
        );
      }),
    );
  }

  ProfileImage _buildImage(BuildContext context) {
    return ProfileImage(
      onChanged: (value) {
        BlocProvider.of<UploadPictureCubit>(context).setPicture(value);
      },
    );
  }

  void _buildListener(UploadPictureState state, BuildContext context) {
    if (state.uploadPictureStatus == UploadPictureStatus.done) {
      ToastUtils.showSusToastMessage('تم رفع الصورة الشخصية بنجاح');
      _goToOtpScreen(context);
    } else if (state.uploadPictureStatus == UploadPictureStatus.noInternet) {
      showSnackbar(context, AppStrings.noInternetConnectionMessage);
    } else if (state.uploadPictureStatus == UploadPictureStatus.networkError) {
      showSnackbar(context, AppStrings.networkError);
    }
  }

  void _goToOtpScreen(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(LogInUserEvent());
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => OtpScreen(onSkipClicked: (returnedContext) {
          Navigator.pushNamedAndRemoveUntil(
            returnedContext,
            AppWrapper.routeName,
            (route) => false,
          );
        }),
      ),
      (route) => false,
    );
  }

  BlocBuilder<UploadPictureCubit, UploadPictureState> _buildBtns() {
    return BlocBuilder<UploadPictureCubit, UploadPictureState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            NextBtn(
              isLoading:
                  state.uploadPictureStatus == UploadPictureStatus.loading,
              onPressed: state.uploadPictureStatus ==
                      UploadPictureStatus.loading
                  ? () {}
                  : () {
                      if (context.read<UploadPictureCubit>().state.image ==
                          null) {
                        showSnackbar(context, 'عليك اختيار الصورة قبل الرفع');
                      }
                      BlocProvider.of<UploadPictureCubit>(context)
                          .submit(id: context.read<AuthRepo>().getUserId()!);
                    },
              label: 'رفع الصورة',
              withIcon: false,
            ),
            SizedBox(
              height: 8,
            ),
            PreviousBtn(
              label: 'تخطي',
              withIcon: false,
              onPressed:
                  state.uploadPictureStatus == UploadPictureStatus.loading
                      ? () {}
                      : () {
                          _goToOtpScreen(context);
                        },
            ),
          ],
        );
      },
    );
  }
}
