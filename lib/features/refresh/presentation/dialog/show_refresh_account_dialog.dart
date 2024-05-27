import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/features/refresh/presentation/cubit/refresh_account_cubit.dart';
import 'package:khosousi_online/features/refresh/presentation/dialog/refresh_account_dialog_content.dart';

void showRefreshAccountDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (c) => MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: context.read<RefreshAccountCubit>(),
        ),
      ],
      child: const Dialog(
        child: RefreshAccountDialogContent(),
      ),
    ),
  );
}
