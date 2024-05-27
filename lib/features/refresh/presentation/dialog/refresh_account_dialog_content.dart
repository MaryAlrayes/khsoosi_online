import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/ui/dialogs_widgets/done_content_dialog.dart';
import 'package:khosousi_online/core/ui/dialogs_widgets/error_content_dialog.dart';
import 'package:khosousi_online/core/ui/dialogs_widgets/loading_content_dialog.dart';
import 'package:khosousi_online/features/refresh/presentation/cubit/refresh_account_cubit.dart';

class RefreshAccountDialogContent extends StatelessWidget {
  const RefreshAccountDialogContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RefreshAccountCubit, RefreshAccountState>(
      listener: (context, state) {
        if (state is RefreshAccountDone) {
          _buildCloseDialog(
            context,
          );
        }
      },
      builder: (context, state) {
        return BlocBuilder<RefreshAccountCubit, RefreshAccountState>(
          builder: (context, state) {
            if (state is RefreshAccountLoading ||
                state is RefreshAccountInitial) {
              return _buildLoading(context);
            } else if (state is RefreshAccountDone) {
              return _buildDone(context);
            } else if (state is RefreshAccountInternetError ||
                state is RefreshAccountNetworkError) {
              return _buildError(context);
            } else {
              return Container();
            }
          },
        );
      },
    );
  }

  void _buildCloseDialog(
    BuildContext context,
  ) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  Widget _buildError(BuildContext context) {
    return ErrorContentDialog(
        text: 'حدث خطأ أثناء التحديث',
        onPressed: () {
          BlocProvider.of<RefreshAccountCubit>(context).refreshAccount();
        });
  }

  Widget _buildDone(BuildContext context) {
    return DoneContentDialog(
      text: 'تم تحديث حسابك بنجاح',
    );
  }

  Widget _buildLoading(BuildContext context) {
    return LoadingContentDialog(
      text: 'جاري تحديث الحساب ...',
    );
  }
}
