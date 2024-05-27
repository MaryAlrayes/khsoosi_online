import 'package:flutter/material.dart';
import 'package:khosousi_online/core/managers/assets_manager.dart';

PreferredSizeWidget customeAppBar = AppBar(
  actions: [
    PopupMenuButton<int>(
      onSelected: (item) {},
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 1,
          child: Text('تسجيل الخروج',style: TextStyle(fontSize: 12),),
          onTap: () async {},
        ),
      ],
    ),
  ],
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
