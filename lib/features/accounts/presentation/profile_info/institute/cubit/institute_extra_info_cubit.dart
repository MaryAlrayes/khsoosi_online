// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';

import 'package:khosousi_online/features/accounts/domain/entities/institute_extra_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/use_cases/submit_institute_extra_info_use_case.dart';
import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';

part 'institute_extra_info_state.dart';

class InstituteExtraInfoCubit extends Cubit<InstituteExtraInfoState> {
  final SubmitInstituteExtraInfoUseCase submitInstituteExtraInfoUseCase;
  InstituteExtraInfoCubit({
    required this.submitInstituteExtraInfoUseCase,
  }) : super(InstituteExtraInfoState.empty());

  void setName(String name) {
   InstituteExtraInfoEntity infoEntity =
        state.instituteExtraInfoEntity.copyWith(name: name);
    emit(state.copyWith(
        info: infoEntity,
        intituteExtraInfoStatus: IntituteExtraInfoStatus.init));
  }

  void setAbout(String about) {
    InstituteExtraInfoEntity infoEntity =
        state.instituteExtraInfoEntity.copyWith(about: about);
    emit(state.copyWith(
        info: infoEntity,
        intituteExtraInfoStatus: IntituteExtraInfoStatus.init));
  }

  void setAddress(String address) {
    InstituteExtraInfoEntity infoEntity =
        state.instituteExtraInfoEntity.copyWith(address: address);
    emit(state.copyWith(
        info: infoEntity,
        intituteExtraInfoStatus: IntituteExtraInfoStatus.init));
  }

  void addCategory(CategoryEntity categoryEntity) {
    List<CategoryEntity> categories = List.generate(
        state.instituteExtraInfoEntity.categories.length,
        (index) => state.instituteExtraInfoEntity.categories[index]);
    categories.add(categoryEntity);
    InstituteExtraInfoEntity infoEntity =
        state.instituteExtraInfoEntity.copyWith(categories: categories);
    emit(
      state.copyWith(
          info: infoEntity,
          intituteExtraInfoStatus: IntituteExtraInfoStatus.init),
    );
  }

  void deleteCategory(CategoryEntity categoryEntity) {
    List<CategoryEntity> categories = List.generate(
        state.instituteExtraInfoEntity.categories.length,
        (index) => state.instituteExtraInfoEntity.categories[index]);
    categories.remove(categoryEntity);
    InstituteExtraInfoEntity infoEntity =
        state.instituteExtraInfoEntity.copyWith(categories: categories);
    emit(
      state.copyWith(
        info: infoEntity,
        intituteExtraInfoStatus: IntituteExtraInfoStatus.init,
      ),
    );
  }

  void submit({required String id}) async {
    emit(state.copyWith(
        intituteExtraInfoStatus: IntituteExtraInfoStatus.loading,
        errorMessage: ''));
    final res = await submitInstituteExtraInfoUseCase(
      instituteExtraInfoEntity: state.instituteExtraInfoEntity,
      userId: id,
    );
    res.fold((f) {
      _mapFailureToState(emit, f, state);
    }, (data) async {
      emit(
        state.copyWith(
          intituteExtraInfoStatus: IntituteExtraInfoStatus.done,
          errorMessage: '',
        ),
      );
    });
  }
}

_mapFailureToState(emit, Failure f, InstituteExtraInfoState state) {
  switch (f) {
    case OfflineFailure():
      emit(
        state.copyWith(
          intituteExtraInfoStatus: IntituteExtraInfoStatus.noInternet,
          errorMessage: '',
        ),
      );

    case NetworkErrorFailure f:
      emit(
        state.copyWith(
          intituteExtraInfoStatus: IntituteExtraInfoStatus.networkError,
          errorMessage: f.message,
        ),
      );
  }
}
