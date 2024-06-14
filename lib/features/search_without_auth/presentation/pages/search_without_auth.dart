import 'package:flutter/material.dart';
import 'package:khosousi_online/core/ui/widgets/custom_app_bar.dart';
import 'package:khosousi_online/features/search/presentation/search/screens/search_screen.dart';

class SearchWithoutAuth extends StatelessWidget {
  static const routeName = 'search_without_search_screen';
  const SearchWithoutAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context: context,withActions: false),
      body: SearchScreen(
        withAppBar: false,
      ),
    );
  }
}
