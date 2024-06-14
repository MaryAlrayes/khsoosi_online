import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/managers/assets_manager.dart';
import 'package:khosousi_online/core/ui/widgets/log_out.dart';
import 'package:khosousi_online/core/ui/widgets/warning_menu.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';

PreferredSizeWidget getCustomAppBar({
  required BuildContext context,
  withActions = true,
}) {
  final _popupMenu = GlobalKey<PopupMenuButtonState>();
  return AppBar(
    actions: withActions
        ? [
            if (!context.read<AuthRepo>().isActive())
              buildWarningMenu(_popupMenu, context),
            buildLogout(),
          ]
        : [],
    centerTitle: false,
    title: SizedBox(
      width: 100,
      height: 70,
      child: Image.asset(
        AppAssetsManager.logo_white,
        alignment: FractionalOffset.centerRight,
        fit: BoxFit.contain,
      ),
    ),
  );
}
