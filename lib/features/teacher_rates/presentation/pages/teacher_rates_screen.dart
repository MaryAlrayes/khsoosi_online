import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_rating.dart';
import 'package:khosousi_online/core/ui/widgets/custom_read_text.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/teacher_rates/domain/entities/teacher_review_entity.dart';
import 'package:khosousi_online/features/teacher_rates/presentation/cubit/get_teacher_reviews_cubit.dart';
import 'package:khosousi_online/features/teacher_rates/presentation/widgets/teacher_reply.dart';
import 'package:khosousi_online/features/teacher_rates/presentation/widgets/user_rate_item.dart';

import '../../../../core/ui/widgets/error_widget.dart';
import '../../../../core/ui/widgets/no_connection_widget.dart';
import '../../../../core/utils/helpers/date_formatter.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;

class TeacherRatesScreen extends StatelessWidget {
  const TeacherRatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.locator<GetTeacherReviewsCubit>()..fetchReviews(userId: context.read<AuthRepo>().getUserId()!),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('تقييماتي'),
          ),
          body: BlocBuilder<GetTeacherReviewsCubit, GetTeacherReviewsState>(
            builder: (context, state) {
              if (state is GetTeacherReviewsLoading ||
                        state is GetTeacherReviewsInitial)
                      return _buildLoading();
                    else if (state is GetTeacherReviewsNoInternet) {
                      return _buildOffline(context);
                    } else if (state is GetTeacherReviewsNetworkError) {
                      return _buildError(state, context);
                    } else if (state is GetTeacherReviewsLoaded) {
                      return _buildContent(state.reviews,);
                    } else {
                      return Container();
                    }

            },
          ),
        );
      }),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(
      GetTeacherReviewsNetworkError state, BuildContext context) {
    return Center(
      child: NetworkErrorWidget(
        message: state.message,
        onPressed: () {
          BlocProvider.of<GetTeacherReviewsCubit>(context)
              .fetchReviews(userId: context.read<AuthRepo>().getUserId()!);
        },
      ),
    );
  }

  Widget _buildOffline(BuildContext context) {
    return Center(
      child: NoConnectionWidget(
        onPressed: () {
          BlocProvider.of<GetTeacherReviewsCubit>(context)
              .fetchReviews(userId: context.read<AuthRepo>().getUserId()!);
          },
      ),
    );
  }

  ListView _buildContent(List<TeacherReviewEntity> reviews,) {
    return ListView.separated(
      itemBuilder: (context, index) => SizedBox(
        height: 16,
      ),
      separatorBuilder: (context, index) {
        return _buildComment(
          context,
          reviews[index]

        );
      },
      itemCount: reviews.length,
    );
  }

  Widget _buildComment(
    BuildContext context,
    TeacherReviewEntity review
  ) {
    return Column(
      children: [
        _buildUserComment(context,review),
        SizedBox(
          height: 8,
        ),
     if(review.teacherReply.isNotEmpty)   _buildTeacherReply(
          context,
          review
        ),
      ],
    );
  }

  Widget _buildUserComment(BuildContext context,  TeacherReviewEntity review) {
    return UserRateItem(review:  review);
  }

  Widget _buildTeacherReply(
    BuildContext context,
    TeacherReviewEntity review
  ) {
    return TeacherReply(review:  review);
  }
}
