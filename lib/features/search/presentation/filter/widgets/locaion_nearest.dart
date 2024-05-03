import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/coords_cubit.dart';

class LocationNearest extends StatelessWidget {
  const LocationNearest({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<CoordsCubit, CoordsState>(
          builder: (context, state) {
            if (state is CoordsFetched) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text('تم جلب إحداثيات موقعك بنجاح'),
                    ],
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        )
      ],
    );
  }
}
