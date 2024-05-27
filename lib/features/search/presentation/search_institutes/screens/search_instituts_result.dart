import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/features/search/presentation/search_institutes/widgets/institute_item.dart';

class SearchInstitutesScreen extends StatelessWidget {
 final bool showFilter;
  const SearchInstitutesScreen({
    Key? key,
     this.showFilter=true,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Container(child: _buildInstitutesList()),
          ],
        ),
      ),
    );
  }


  ListView _buildInstitutesList() {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        separatorBuilder: (context, index) => SizedBox(
              height: 16.h,
            ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return InstituteItem();
        });
  }
}
