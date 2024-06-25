import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/core/ui/dialogs_widgets/done_content_dialog.dart';
import 'package:khosousi_online/core/ui/dialogs_widgets/loading_content_dialog.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/accounts/presentation/login/blocs/authentication_bloc.dart';
import 'package:khosousi_online/features/app_wrapper/app_wrapper.dart';
import 'package:khosousi_online/features/conditions_terms/presentation/cubit/answer_conditions_cubit.dart';

class MainConditionsScreen extends StatelessWidget {
  final Widget mainWidget;
  final Widget rejectWidget;
  const MainConditionsScreen({
    Key? key,
    required this.mainWidget,
    required this.rejectWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.locator<AnswerConditionsCubit>(),
      child: Builder(builder: (context) {
        return BlocListener<AnswerConditionsCubit, AnswerConditionsState>(
          listener: (context, state) {
            _buildListener(state, context);
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'شروط استخدام الموقع',
              ),
            ),
            persistentFooterButtons: [
              BlocBuilder<AnswerConditionsCubit, AnswerConditionsState>(
                builder: (context, state) {
                  return state.answer == null || state.answer!
                      ? _buildAceeptRejectBtns(context)
                      : _buildConfrimRejectOrBackBtns(context);
                },
              ),
            ],
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:
                      BlocBuilder<AnswerConditionsCubit, AnswerConditionsState>(
                    builder: (context, state) {
                      return state.answer == null || state.answer!
                          ? mainWidget
                          : rejectWidget;
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Column _buildConfrimRejectOrBackBtns(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildConfirmRejection(context),
        SizedBox(
          height: 4,
        ),
        _buildBackBtn(context)
      ],
    );
  }

  ElevatedButton _buildBackBtn(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.arrow_back),
      style: ElevatedButton.styleFrom(backgroundColor: ColorManager.black),
      onPressed: () {
        BlocProvider.of<AnswerConditionsCubit>(context).reset();
      },
      label: Text(
        'العودة إلى الشروط',
      ),
    );
  }

  ElevatedButton _buildConfirmRejection(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: () {
        BlocProvider.of<AnswerConditionsCubit>(context).answer(
            userId: context.read<AuthRepo>().getUserInfo()!.userId,
            answer: false);
      },
      child: Text(
        'أنا متأكد أني غير موافق ولا أريد استخدام التطبيق',
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Column _buildAceeptRejectBtns(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        context.read<AuthRepo>().getUserInfo()!.isConditionAgreed
            ? _hasAgreedLabel()
            : _buildAcceptBtn(context),
        SizedBox(
          height: 4,
        ),
        _buildRejectBtn(context),
      ],
    );
  }

  ElevatedButton _buildRejectBtn(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.close),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: () {
        BlocProvider.of<AnswerConditionsCubit>(context).No();
      },
      label: Text(
        'لا أوافق على الشروط',
      ),
    );
  }

  ElevatedButton _buildAcceptBtn(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.check),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      onPressed: () {
        BlocProvider.of<AnswerConditionsCubit>(context).answer(
            userId: context.read<AuthRepo>().getUserInfo()!.userId,
            answer: true);
      },
      label: Text(
        'أوافق على الشروط',
      ),
    );
  }

  Container _hasAgreedLabel() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.all(8),
      child: Text(
        'تمت الموافقة على الشروط',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  void _buildListener(AnswerConditionsState state, BuildContext context) {
    if (state.status == AnswerConditionsStatus.loading) {
      //show loading dialog
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
              child: LoadingContentDialog(
            text: state.answer! ? 'جاري الموافقة' : 'جاري عدم الموافقة',
          ));
        },
      );
    } else if (state.status == AnswerConditionsStatus.noInternet) {
      //pop up the loading dialog
      Navigator.pop(context);
      //show error snack bar
      showSnackbar(context, AppStrings.noInternetConnectionMessage);
    } else if (state.status == AnswerConditionsStatus.networkError) {
      //pop up the loading dialog
      Navigator.pop(context);
      //show error snack bar
      showSnackbar(context, AppStrings.networkError);
    } else if (state.status == AnswerConditionsStatus.done) {
      //pop up the loading dialog
      Navigator.pop(context);

//log out if the answer was false
      if (state.answer == false) {
        BlocProvider.of<AuthenticationBloc>(context).add(LogOutUserEvent());

        Navigator.pushNamedAndRemoveUntil(
          context,
          AppWrapper.routeName,
          (route) => false,
        );
      } else {
        //show succesful dialog if the answer was yes
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return Dialog(
                child: DoneContentDialog(
              text: state.answer! ? 'تمت الموافقة' : '',
            ));
          },
        );
        //delay a second then go to app wrapper to decide the state
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
          BlocProvider.of<AuthenticationBloc>(context).add(LogInUserEvent());
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppWrapper.routeName,
            (route) => false,
          );
        });
      }
    }
  }
}
