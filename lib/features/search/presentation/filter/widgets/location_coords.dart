import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/coords_cubit.dart';

class LocationCoords extends StatelessWidget {
  const LocationCoords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoordsCubit, CoordsState>(
      listener: (context, state) {
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'حدث خطأ أثناء جلب الاحداثيات',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          CustomElevatedButton(
            icon: const Icon(Icons.replay_outlined),
            onPressed: () {
              BlocProvider.of<CoordsCubit>(context).fetchLocation();
            },
            label: 'محاولة مرة أخرى',
          )
        ],
      ),
    );
  }

  Widget _buildFetched(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          const SizedBox(
            width: 8,
          ),
          Text('تم جلب إحداثيات موقعك بنجاح')
        ],
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'جاري جلب الاحداثيات ...',
          ),
          const SizedBox(
            height: 8,
          ),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
