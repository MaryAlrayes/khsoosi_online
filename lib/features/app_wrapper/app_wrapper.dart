import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/utils/helpers/user_type_selection.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/accounts/presentation/login/blocs/authentication_bloc.dart';
import 'package:khosousi_online/features/conditions_terms/presentation/pages/conditions_screen.dart';
import 'package:khosousi_online/features/startup/screens/choose_state_screen.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/screens/registeration_info_screen.dart';

import '../navigation/presentation/screens/homepage_screen.dart';
import '../startup/screens/splash_screen.dart';

class AppWrapper extends StatelessWidget {
  static const routeName = 'wrapper_scrren';
  const AppWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return _buildAuthBuilder(state, context);
      },
    );
  }

  Widget _buildAuthBuilder(AuthenticationState state, BuildContext context) {
    print('the auth state ${state.runtimeType}');
    if (state is AuthenticationInitial) {
      return const SplashScreen();
    } else if (state is AuthenticatationLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    } else if (state is UnauthenticatedState) {
      return ChooseStateScreen();
    } else if (state is RegistrationInfoState) {
      return RegisterationInfoScreen(
        userType: UserTypeSelection.getUserType(
         state.type
        ),
        hasFinishedFirstInfo: state.hasFinishedFirstInfo,
      );
    }else if (state is ConditionsState) {
      return ConditionsScreen(
        userType: UserTypeSelection.getUserType(
         state.type
        ),
      );
    } else if (state is AuthenticatedState) {
      return HomepageScreen(
        userType: UserTypeSelection.getUserType(
          context.read<AuthRepo>().getUserInfo()!.type,
        ),
      );
    } else {
      return const SplashScreen();
    }
  }
}
