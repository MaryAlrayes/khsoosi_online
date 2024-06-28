import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';

import '../../../../../../core/utils/helpers/toast_utils.dart';
import '../../../common_widgets/next_btn.dart';
import '../../../common_widgets/previous_btn.dart';
import '../../common/widgets/upload_certificates.dart';
import '../cubit/teacher_info_stepper_cubit.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;

import '../cubit/upload_certificates_cubit.dart';

class TeacherUploadCertificatesStep extends StatelessWidget {
  const TeacherUploadCertificatesStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.locator<UploadCertificatesCubit>(),
      child: Builder(builder: (context) {
        return BlocListener<UploadCertificatesCubit, UploadCertificatesState>(
            listener: (context, state) {
              _buildListener(state, context);
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _uploadCertificates(context),
                  SizedBox(
                    height: 16,
                  ),
                  _buildBtns(context),
                ],
              ),
            ));
      }),
    );
  }

  UploadCertificates _uploadCertificates(BuildContext context) {
    return UploadCertificates(
      onAddImage: (value) {
        BlocProvider.of<UploadCertificatesCubit>(context).addImage(value);
      },
      onRemoveImage: (value) {
        BlocProvider.of<UploadCertificatesCubit>(context).deleteImage(value);
      },
    );
  }

  void _buildListener(UploadCertificatesState state, BuildContext context) {
    if (state.status == UploadCertificatesStatus.done) {
      ToastUtils.showSusToastMessage('تم رفع الشهادات بنجاح');
      BlocProvider.of<TeacherInfoStepperCubit>(context).nextStep();
    } else if (state.status == UploadCertificatesStatus.noInternet) {
      showSnackbar(context, AppStrings.noInternetConnectionMessage);
    } else if (state.status == UploadCertificatesStatus.networkError) {
      showSnackbar(context, AppStrings.networkError);
    }
  }

  Widget _buildBtns(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<UploadCertificatesCubit, UploadCertificatesState>(
          builder: (context, state) {
            return NextBtn(
              isLoading: state.status == UploadCertificatesStatus.loading,
              onPressed: state.status == UploadCertificatesStatus.loading
                  ? () {}
                  : () {
                      if (context
                          .read<UploadCertificatesCubit>()
                          .state
                          .image
                          .isEmpty) {
                        BlocProvider.of<TeacherInfoStepperCubit>(context)
                            .nextStep();
                      } else {
                        BlocProvider.of<UploadCertificatesCubit>(context)
                            .submit(id: context.read<AuthRepo>().getUserId()!);
                      }
                    },
            );
          },
        ),
      ],
    );
  }
}
