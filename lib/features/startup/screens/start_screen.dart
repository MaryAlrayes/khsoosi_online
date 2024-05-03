import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/core/managers/assets_manager.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_animated_list.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/features/search/presentation/my%20search/screens/my_search_screen.dart';
import 'package:khosousi_online/features/startup/widgets/custome_footer.dart';
import 'package:khosousi_online/features/startup/widgets/start_up_btn.dart';

class StartScreen extends StatelessWidget {
  static const routeName = 'start_screen';
  StartScreen({super.key});
  final GlobalKey<AnimatedListState> _keyList = GlobalKey<AnimatedListState>();
  final List<Widget> _animatedItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildImage(),
                    SizedBox(
                      height: 16.h,
                    ),
                    // _buildAppTitle(),
                    SizedBox(
                      height: 20.h,
                    ),
                    // _buildCalculateGPATitle(),
                    //  SizedBox(
                    //   height: 20.h,
                    // ),
                    _buildAnimatedList(context)
                  ],
                ),
              ),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedList(BuildContext context) {
    List<Widget> buttons = _getButtons(context);

    _addAnimatedBtns(buttons);
    return CustomAnimatedList(
      itemsWidgets: _animatedItems,
      keyList: _keyList,
      offset: Tween(
        begin: const Offset(1, 0),
        end: const Offset(0, 0),
      ),
    );
  }

  void _addAnimatedBtns(List<Widget> items) {
    Future ft = Future((() {}));
    for (int i = 0; i < items.length; i++) {
      ft = ft.then((_) {
        return Future.delayed(
          const Duration(milliseconds: 300),
          () {
            _animatedItems.add(items[i]);
            _keyList.currentState!.insertItem(_animatedItems.length - 1);
          },
        );
      });
    }
  }

  List<Widget> _getButtons(BuildContext context) {
    List<Widget> btns = [
      _buildSearchTeacherbtn(context),
      SizedBox(
        height: 8.h,
      ),
      _buildSearchCoursesbtn(context),
      SizedBox(
        height: 8.h,
      ),
      _buildSearchInstitutesbtn(context),
      SizedBox(
        height: 8.h,
      ),
      _buildSearchServicesbtn(context),
       SizedBox(
        height: 8.h,
      ),
      _buildMySearchBtn(context)
    ];

    return btns;
  }

  Container _buildImage() {
    return Container(
      height: 100.h,
      width: double.infinity,
      child: Image.asset(
        AppAssetsManager.logo_black,
        fit: BoxFit.contain,
      ),
    );
  }

  // Text _buildCalculateGPATitle() {
  //   return Text(
  //     'برنامج حساب المعدل الجامعي',
  //     textAlign: TextAlign.center,
  //     style: TextStyle(
  //       fontSize: 20.sp,
  //       color: ColorManager.darkBlue,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   );
  // }

  Text _buildAppTitle() {
    return Text(
      'خصوصي أونلاين',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30.sp,
        color: ColorManager.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSearchTeacherbtn(BuildContext context) {
    return StartUpBtn(
      label: 'بحث عن مدرس خصوصي',
      icon: Icon(
        FontAwesomeIcons.chalkboardUser,
        size: 14.r,
      ),
      onPressed: () {
        // Navigator.pushNamed(context, SearchTeacherStepper.routeName);
      },
    );
  }

  Widget _buildSearchCoursesbtn(BuildContext context) {
    return StartUpBtn(
      label: 'بحث عن دورات تدريبية',
      icon: Icon(
        FontAwesomeIcons.bookAtlas,
        size: 15.r,
      ),
      onPressed: () {
        // Navigator.pushNamed(context, SearchCoursesStepper.routeName);
      },
    );
  }

  Widget _buildSearchServicesbtn(BuildContext context) {
    return StartUpBtn(
      label: 'بحث عن خدمات تعليمية',
      icon: Icon(
        FontAwesomeIcons.pencil,
        size: 15.r,
      ),
      onPressed: () {
        // Navigator.pushNamed(context, SearchServicesStepper.routeName);
      },
    );
  }

  Widget _buildSearchInstitutesbtn(BuildContext context) {
    return StartUpBtn(
        label: 'بحث عن معاهد تعليم',
        icon: Icon(
          FontAwesomeIcons.buildingColumns,
          size: 15.r,
        ),
        onPressed: () {
          // Navigator.pushNamed(context, SearchInstitutesStepper.routeName);
        });
  }
Widget _buildMySearchBtn(BuildContext context) {
    return StartUpBtn(
        label: 'بحث',
        icon: Icon(
          FontAwesomeIcons.searchengin,
          size: 15.r,
        ),
        onPressed: () {
          Navigator.pushNamed(context, MySearchScreen.routeName);
        });
  }
  CustomeFooter _buildFooter() => const CustomeFooter();
}
