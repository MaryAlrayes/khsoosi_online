import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_error_message.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/core/utils/helpers/toast_utils.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/previous_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/cubit/teacher_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/cubit/teacher_info_stepper_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/widgets/social_media_fileld.dart';

class TeacherInfoStep3 extends StatelessWidget {
  const TeacherInfoStep3({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeacherInfoCubit, TeacherInfoState>(
      listener: (context, state) {
        _buildListener(state, context);
      },
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildInstagram(context),
          SizedBox(
            height: 16,
          ),
          _buildFacebook(context),
          SizedBox(
            height: 16,
          ),
          _buildTiktok(context),
          SizedBox(
            height: 16,
          ),
          _buildYoutube(context),
          SizedBox(
            height: 16,
          ),
          _buildX(context),
          SizedBox(
            height: 16,
          ),
          _buildThreads(context),
          SizedBox(
            height: 16,
          ),
          _buildLinkedIn(context),
          SizedBox(
            height: 16,
          ),
          _buildErrorMessages(),
          SizedBox(
            height: 24,
          ),
          _buildBtns(context),
        ],
      )),
    );
  }

  BlocBuilder<TeacherInfoCubit, TeacherInfoState> _buildErrorMessages() {
    return BlocBuilder<TeacherInfoCubit, TeacherInfoState>(
        builder: (context, state) {
      return state.errorMessage.isEmpty
          ? Container()
          : CustomErrorMessage(
              errorMessage: state.errorMessage,
            );
    });
  }

  void _buildListener(TeacherInfoState state, BuildContext context) {
    if (state.teacherinfoStatus == TeacherinfoStatus.done) {
      ToastUtils.showSusToastMessage('تم إضافة معلوماتك بنجاح');
      BlocProvider.of<TeacherInfoStepperCubit>(context).nextStep();
    } else if (state.teacherinfoStatus == TeacherinfoStatus.noInternet) {
      showSnackbar(context, AppStrings.noInternetConnectionMessage);
    } else if (state.teacherinfoStatus == TeacherinfoStatus.networkError) {
      showSnackbar(context, AppStrings.networkError);
    }
  }

  Widget _buildBtns(BuildContext context) {
    return BlocBuilder<TeacherInfoCubit, TeacherInfoState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            NextBtn(
              isLoading: state.teacherinfoStatus == TeacherinfoStatus.loading,
              onPressed: state.teacherinfoStatus == TeacherinfoStatus.loading
                  ? () {}
                  : () {
                      BlocProvider.of<TeacherInfoCubit>(context).submit(
                        id: context.read<AuthRepo>().getUserId()!,
                      );
                    },
            ),
            SizedBox(
              height: 8,
            ),
            PreviousBtn(
              onPressed: state.teacherInfoEntity == TeacherinfoStatus.loading
                  ? () {}
                  : () {
                      BlocProvider.of<TeacherInfoStepperCubit>(context)
                          .stepBack();
                    },
            ),
          ],
        );
      },
    );
  }

  Widget _buildInstagram(BuildContext context) {
    return _buildSocialField(
      context: context,
      hintText: 'رابط حسابك على انستغرام',
      iconData: Icon(FontAwesomeIcons.instagram),
      initValue:
          context.read<TeacherInfoCubit>().state.teacherInfoEntity.instagram ??
              '',
      label: 'Instagram',
      onChanged: (value) {
        BlocProvider.of<TeacherInfoCubit>(context).setInstagram(value);
      },
    );
  }

  Widget _buildFacebook(BuildContext context) {
    return _buildSocialField(
      context: context,
      hintText: 'رابط حسابك على فيسبوك',
      iconData: Icon(FontAwesomeIcons.facebook),
      initValue:
          context.read<TeacherInfoCubit>().state.teacherInfoEntity.facebook ??
              '',
      label: 'Facebook',
      onChanged: (value) {
        BlocProvider.of<TeacherInfoCubit>(context).setFacebook(value);
      },
    );
  }

  Widget _buildTiktok(BuildContext context) {
    return _buildSocialField(
      context: context,
      hintText: 'رابط حسابك على تيكتوك',
      iconData: Icon(FontAwesomeIcons.tiktok),
      initValue:
          context.read<TeacherInfoCubit>().state.teacherInfoEntity.tiktok ?? '',
      label: 'Tiktok',
      onChanged: (value) {
        BlocProvider.of<TeacherInfoCubit>(context).setTiktok(value);
      },
    );
  }

  Widget _buildYoutube(BuildContext context) {
    return _buildSocialField(
      context: context,
      hintText: 'رابط حسابك على يوتيوب',
      iconData: Icon(FontAwesomeIcons.youtube),
      initValue:
          context.read<TeacherInfoCubit>().state.teacherInfoEntity.youtube ??
              '',
      label: 'Youtube',
      onChanged: (value) {
        BlocProvider.of<TeacherInfoCubit>(context).setYoutube(value);
      },
    );
  }

  Widget _buildX(BuildContext context) {
    return _buildSocialField(
      context: context,
      hintText: 'رابط حسابك على X',
      iconData: Icon(FontAwesomeIcons.x),
      initValue:
          context.read<TeacherInfoCubit>().state.teacherInfoEntity.x_twitter ??
              '',
      label: 'منصة X',
      onChanged: (value) {
        BlocProvider.of<TeacherInfoCubit>(context).setXTwitter(value);
      },
    );
  }

  Widget _buildThreads(BuildContext context) {
    return _buildSocialField(
      context: context,
      hintText: 'رابط حسابك على Threads',
      iconData: Icon(FontAwesomeIcons.threads),
      initValue:
          context.read<TeacherInfoCubit>().state.teacherInfoEntity.threads ??
              '',
      label: 'Threads',
      onChanged: (value) {
        BlocProvider.of<TeacherInfoCubit>(context).setThreads(value);
      },
    );
  }

  Widget _buildLinkedIn(BuildContext context) {
    return _buildSocialField(
      context: context,
      hintText: 'رابط حسابك على لينكد ان',
      iconData: Icon(FontAwesomeIcons.linkedin),
      initValue:
          context.read<TeacherInfoCubit>().state.teacherInfoEntity.linkedin ??
              '',
      label: 'Linked In',
      onChanged: (value) {
        BlocProvider.of<TeacherInfoCubit>(context).setLinkedIn(value);
      },
    );
  }

  Widget _buildSocialField(
      {required BuildContext context,
      required String label,
      required String hintText,
      required String initValue,
      required Icon iconData,
      required Function onChanged}) {
    return SocialMediaField(
      label: label,
      hintText: hintText,
      initValue: initValue,
      iconData: iconData,
      onChanged: onChanged,
    );
  }
}
