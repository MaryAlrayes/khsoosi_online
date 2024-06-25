import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/teacher_balance/presentation/cubit/get_balance_cubit.dart';
import 'package:khosousi_online/features/teacher_balance/presentation/pages/charge_screen.dart';
import 'package:khosousi_online/features/teacher_balance/presentation/pages/teacher_balance_screen.dart';

import '../../../../core/ui/widgets/error_widget.dart';
import '../../../../core/ui/widgets/no_connection_widget.dart';

enum BalanceScreenType { myBalance, charge }

class BalanceScreen extends StatelessWidget {
  final BalanceScreenType balanceScreenType;
  static const routeName = 'balance_screen';

  const BalanceScreen({super.key, required this.balanceScreenType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl.locator<GetBalanceCubit>()..fetchBalance(
                    userId: context.read<AuthRepo>().getUserId()!),
        child: Builder(builder: (context) {
          return BlocBuilder<GetBalanceCubit, GetBalanceState>(
            builder: (context, state) {
              if (state is GetBalanceLoading || state is GetBalanceInitial)
                return _buildLoading();
              else if (state is GetBalanceNoInternet) {
                return _buildOffline(context);
              } else if (state is GetBalanceNetworkError) {
                return _buildError(state, context);
              } else if (state is GetBalanceLoaded) {
                switch (balanceScreenType) {
                  case BalanceScreenType.myBalance:
                    return TeacherBalanceScreen(
                      balanceEntity: state.balanceEntity,
                    );
                  case BalanceScreenType.charge:
                    return ChargeScreen(balanceEntity: state.balanceEntity);
                }
              } else {
                return Container();
              }
            },
          );
        }));
  }

  Widget _buildLoading() {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Widget _buildError(GetBalanceNetworkError state, BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: NetworkErrorWidget(
              message: state.message,
              onPressed: () {
                BlocProvider.of<GetBalanceCubit>(context).fetchBalance(
                    userId: context.read<AuthRepo>().getUserId()!);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOffline(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: NoConnectionWidget(
              onPressed: () {
                BlocProvider.of<GetBalanceCubit>(context).fetchBalance(
                    userId: context.read<AuthRepo>().getUserId()!);
              },
            ),
          ),
        ),
      ),
    );
  }
}
