import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:khosousi_online/core/ui/dialogs_widgets/done_content_dialog.dart';
import 'package:khosousi_online/core/ui/dialogs_widgets/error_content_dialog.dart';
import 'package:khosousi_online/core/ui/dialogs_widgets/loading_content_dialog.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/coords_cubit.dart';

class LocationCoordsDialogContent extends StatelessWidget {
  const LocationCoordsDialogContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoordsCubit, CoordsState>(
      listener: (context, state) {
        print('state $state');
        if (state is CoordsFetched) {
          _buildCloseDialog(context, state);
        }
      },
      builder: (context, state) {
        return BlocBuilder<CoordsCubit, CoordsState>(
          builder: (context, state) {
            if (state is CoordsLoading || state is CoordsInitial) {
              return _buildLoading(context);
            } else if (state is CoordsFetched) {
              return _buildFetched(context);
            } else if (state is CoordsError) {
              return _buildError(context);
            } else {
              return Container();
            }
          },
        );
      },
    );
  }

  void _buildCloseDialog(BuildContext context, CoordsFetched state) {
    BlocProvider.of<FilterSearchCubit>(context)
        .setCoord(state.coords.lat, state.coords.lng);
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

  Widget _buildError(BuildContext context) {
    return ErrorContentDialog(
        text: 'حدث خطأ أثناء جلب الاحداثيات',
        onPressed: () {
          BlocProvider.of<CoordsCubit>(context).fetchLocation();
        });
  }

  Widget _buildFetched(BuildContext context) {
    return DoneContentDialog(
      text: 'تم جلب إحداثيات موقعك بنجاح',
    );
  }

  Widget _buildLoading(BuildContext context) {
    return LoadingContentDialog(
      text: 'جاري جلب الاحداثيات ...',
    );
  }
}
