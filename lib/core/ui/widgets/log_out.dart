

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/features/accounts/presentation/login/blocs/authentication_bloc.dart';

PopupMenuButton<int> buildLogout() {
  return PopupMenuButton<int>(
    onSelected: (item) {},
    itemBuilder: (context) => [
      PopupMenuItem<int>(
        value: 1,
        child: Text(
          'تسجيل الخروج',
          style: TextStyle(fontSize: 12),
        ),
        onTap: () async {
          BlocProvider.of<AuthenticationBloc>(context).add(LogOutUserEvent());
        },
      ),
    ],
  );
}
