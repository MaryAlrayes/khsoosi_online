import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/core/utils/helpers/toast_utils.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/previous_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/categories_picker.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/cubit/institute_extra_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/cubit/institute_info_stepper_cubit.dart';

class InstituteCaregoriesStep extends StatelessWidget {
  const InstituteCaregoriesStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<InstituteExtraInfoCubit, InstituteExtraInfoState>(
      listener: (context, state) {
        _buildListener(state, context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RichText(
            text:
                TextSpan(style: DefaultTextStyle.of(context).style, children: [
              TextSpan(
                text: 'التخصصات: ',
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
          Text(
            'الحد الأقصى للتخصصات المسموح اضافتها هو 15 تخصص',
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(
            height: 8,
          ),
          BlocBuilder<InstituteExtraInfoCubit, InstituteExtraInfoState>(
            builder: (context, state) {
              return CategoriesPicker(
                  selectedCategories: state.instituteExtraInfoEntity.categories,
                  onDelete: (value) {
                    BlocProvider.of<InstituteExtraInfoCubit>(context)
                        .deleteCategory(value);
                  },
                  onSelect: (value) {
                    BlocProvider.of<InstituteExtraInfoCubit>(context)
                        .addCategory(value);
                  });
            },
          ),
          SizedBox(
            height: 24,
          ),
          _buildBtns(
            context,
          )
        ],
      ),
    );
  }

  void _buildListener(InstituteExtraInfoState state, BuildContext context) {
    if (state.intituteExtraInfoStatus == IntituteExtraInfoStatus.done) {
      ToastUtils.showSusToastMessage('تم إضافة معلوماتك بنجاح');
      BlocProvider.of<InstituteInfoStepperCubit>(context).nextStep();
    } else if (state.intituteExtraInfoStatus ==
        IntituteExtraInfoStatus.noInternet) {
      showSnackbar(context, AppStrings.noInternetConnectionMessage);
    } else if (state.intituteExtraInfoStatus ==
        IntituteExtraInfoStatus.networkError) {
      showSnackbar(context, AppStrings.networkError);
    }
  }

  Widget _buildBtns(BuildContext context) {
    return BlocBuilder<InstituteExtraInfoCubit, InstituteExtraInfoState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            NextBtn(
              isLoading: state.intituteExtraInfoStatus ==
                  IntituteExtraInfoStatus.loading,
              onPressed: state.intituteExtraInfoStatus ==
                      IntituteExtraInfoStatus.loading
                  ? () {}
                  : () {
                      final state =
                          context.read<InstituteExtraInfoCubit>().state;
                      if (state.instituteExtraInfoEntity.categories.isEmpty) {
                        showSnackbar(context, 'عليك إدخال تخصص واحد على الأقل');
                      } else if (state
                              .instituteExtraInfoEntity.categories.length >
                          15) {
                        showSnackbar(context, 'لا يمكنك إدخال أكثر من 15 تخصص');
                      } else {
                        BlocProvider.of<InstituteExtraInfoCubit>(context)
                            .submit(id: context.read<AuthRepo>().getUserId()!);
                      }
                    },
            ),
            SizedBox(
              height: 8,
            ),
            PreviousBtn(
              onPressed: state.intituteExtraInfoStatus ==
                      IntituteExtraInfoStatus.loading
                  ? () {}
                  : () {
                      BlocProvider.of<InstituteInfoStepperCubit>(context)
                          .stepBack();
                    },
            ),
          ],
        );
      },
    );
  }
}
