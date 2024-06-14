import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/core/ui/dialogs_widgets/loading_content_dialog.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/core/utils/helpers/toast_utils.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/edit_password/presentation/cubit/change_password_cubit.dart';

class EditPasswordScreen extends StatelessWidget {
  static const routeName = 'edit_password_screen';
  EditPasswordScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.locator<ChangePasswordCubit>(),
      child: Builder(builder: (context) {
        return BlocListener<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            _buildListener(state, context);
          },
          child: Scaffold(
            backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text('تغيير كلمة المرور'),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _buildCurrentPasswordTextField(context),
                                SizedBox(
                                  height: 16.h,
                                ),
                                _buildNewPasswordTextField(context),
                                SizedBox(
                                  height: 16.h,
                                ),
                                _buildConfirmPasswordTextField(context),
                                SizedBox(
                                  height: 24.h,
                                ),
                                _buildBtns(context)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        );
      }),
    );
  }

  void _buildListener(ChangePasswordState state, BuildContext context) {
    if (state.changePasswordStatus == ChangePasswordStatus.loading) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
              child: LoadingContentDialog(text: 'جاري تغيير كلمة المرور'));
        },
      );
    } else if (state.changePasswordStatus == ChangePasswordStatus.noInternet) {
      Navigator.pop(context);
      showSnackbar(context, AppStrings.noInternetConnectionMessage);
    } else if (state.changePasswordStatus ==
        ChangePasswordStatus.networkError) {
      Navigator.pop(context);
      showSnackbar(context, state.errorMessage);
    } else if (state.changePasswordStatus == ChangePasswordStatus.done) {
      Navigator.pop(context);
      ToastUtils.showSusToastMessage('تم تغيير كلمة المرور بنجلح');
      Navigator.pop(context);
    }
  }

  Row _buildBtns(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getCancelButton(context),
        CustomElevatedButton(
          backgroundColor: ColorManager.black,
          label: 'تغيير كلمة المرور',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (context.read<ChangePasswordCubit>().state.newPassword !=
                  context.read<ChangePasswordCubit>().state.confirmPassword) {
                showSnackbar(context, 'تأكد بأن كلمتي المرور متطابقتان');
              } else {
                BlocProvider.of<ChangePasswordCubit>(context)
                    .submit(context.read<AuthRepo>().getUserId()!);
              }
            }
          },
        )
      ],
    );
  }

  Widget _buildCurrentPasswordTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'كلمة المرور الحالية:',
          style: kBlackBoldTextStyle,
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomTextField(
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.text,
          hintText: '********',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'عليك إدخال هذا الحقل';
            }
          },
          isObscure: true,
          iconData: Icon(Icons.lock),
          withBorder: true,
          isFilled: true,
          onChanged: (value) {
            BlocProvider.of<ChangePasswordCubit>(context)
                .changeOldPassword(value!);
          },
        ),
      ],
    );
  }

  Widget _buildNewPasswordTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'كلمة المرور الجديدة:',
          style: kBlackBoldTextStyle,
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomTextField(
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.text,
          hintText: '********',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'عليك إدخال هذا الحقل';
            }
          },
          isObscure: true,
          iconData: Icon(Icons.lock),
          withBorder: true,
          isFilled: true,
          onChanged: (value) {
            BlocProvider.of<ChangePasswordCubit>(context)
                .changeNewPassword(value!);
          },
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'تأكيد كلمة المرور الجديدة:',
          style: kBlackBoldTextStyle,
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomTextField(
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.text,
          hintText: '********',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'عليك إدخال هذا الحقل';
            }
          },
          isObscure: true,
          iconData: Icon(Icons.lock),
          withBorder: true,
          isFilled: true,
          onChanged: (value) {
            BlocProvider.of<ChangePasswordCubit>(context)
                .changeConfirmNewPassword(value!);
          },
        ),
      ],
    );
  }
}
