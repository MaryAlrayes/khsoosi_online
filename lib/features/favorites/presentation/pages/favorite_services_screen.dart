import 'package:flutter/material.dart';
import 'package:khosousi_online/features/favorites/presentation/widgets/favorite_services_item.dart';

class FavoriteServicesScreen extends StatelessWidget {
  const FavoriteServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          primary: false,
          separatorBuilder: (context, index) => SizedBox(
                height: 16,
              ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return FavoriteServicesItem();
          }),
    );
  }
}
