// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/core/ui/dialogs_widgets/loading_content_dialog.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';

import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/helpers/launcher.dart';
import '../cubit/get_teacher_phones_cubit.dart';

class TeacherPhonesFloatingBtns extends StatelessWidget {
  final String teacherId;
  const TeacherPhonesFloatingBtns({
    Key? key,
    required this.teacherId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetTeacherPhonesCubit, GetTeacherPhonesState>(
      listener: (context, state) async {
        await _buildListener(state, context);
      },
      child: Theme(
        data: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: Colors.white,
          ),
        ),
        child: AnimatedFloatingActionButton(
            fabButtons: <Widget>[
              _buildPhone(context),
              _buildWhatsapp(context),
              _buildMessage(),
            ],
            colorStartAnimation: ColorManager.blue2,
            colorEndAnimation: Colors.red,
            animatedIconData: AnimatedIcons.menu_close),
      ),
    );
    ;
  }

  Future<void> _buildListener(
      GetTeacherPhonesState state, BuildContext context) async {
    if (state is GetTeacherPhonesLoading) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: LoadingContentDialog(text: 'جاري التحميل'),
          );
        },
      );
    } else if (state is GetTeacherPhonesNoInternet) {
      Navigator.pop(context);
      showSnackbar(context, AppStrings.noInternetConnectionMessage);
    } else if (state is GetTeacherPhonessNetworkError) {
      Navigator.pop(context);
      showSnackbar(context, AppStrings.networkError);
    } else if (state is GetTeacherPhonesLoaded) {
      Navigator.pop(context);
      if ((state).type == TeacherPhones.whatsapp) {
        await CustomLauncher.launchUrl('https://wa.me/971521746493');
      } else if ((state).type == TeacherPhones.normal) {
        await CustomLauncher.launchUrl('tel:971521746493');
      }
    }
  }

  Container _buildMessage() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {},
        heroTag: "message btn",
        tooltip: 'message button',
        child: Icon(FontAwesomeIcons.solidMessage, color: Colors.white),
        backgroundColor: ColorManager.black,
      ),
    );
  }

  Container _buildWhatsapp(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<GetTeacherPhonesCubit>(context).getPhone(
            teacherId: teacherId,
            type: TeacherPhones.whatsapp,
            requesterId: context.read<AuthRepo>().getUserId() ?? '0',
            requesterFingerPrint: '',
            isLoggedIn:
                context.read<AuthRepo>().getUserId() != null ? true : false,
          );
        },
        heroTag: "whatsapp btn",
        tooltip: 'Whatsapp button',
        child: Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
        backgroundColor: Colors.green,
      ),
    );
  }

  Container _buildPhone(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<GetTeacherPhonesCubit>(context).getPhone(
            teacherId: teacherId,
            type: TeacherPhones.normal,
            requesterId: context.read<AuthRepo>().getUserId() ?? '0',
            requesterFingerPrint: '',
            isLoggedIn:
                context.read<AuthRepo>().getUserId() != null ? true : false,
          );
        },
        heroTag: "phone btn",
        tooltip: 'Phone button',
        child: Icon(Icons.phone_enabled_sharp, color: Colors.white),
        backgroundColor: ColorManager.blue1,
      ),
    );
  }
}
