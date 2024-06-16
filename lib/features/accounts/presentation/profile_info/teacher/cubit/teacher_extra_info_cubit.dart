// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';

import 'package:khosousi_online/features/accounts/domain/entities/teacher_extra_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/use_cases/submit_teacher_extra_info_use_case.dart';
import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';

part 'teacher_extra_info_state.dart';

class TeacherExtraInfoCubit extends Cubit<TeacherExtraInfoState> {
  final SubmitTeacherExtraInfoUseCase submitTeacherExtraInfoUseCase;
  TeacherExtraInfoCubit({
    required this.submitTeacherExtraInfoUseCase,
  }) : super(TeacherExtraInfoState.empty());

  void setOnlineMethod(bool value) {
    TeacherExtraInfoEntity infoEntity = state.teacherExtraInfoEntity.copyWith(
      teacheOnline: value,
    );
    emit(
      state.copyWith(
        info: infoEntity,
        teacherinfoStatus: TeacherExtraInfoStatus.init,
      ),
    );
  }

  void setHouseMethod(bool value) {
    TeacherExtraInfoEntity infoEntity = state.teacherExtraInfoEntity.copyWith(
      teachHouse: value,
    );
    emit(
      state.copyWith(
        info: infoEntity,
        teacherinfoStatus: TeacherExtraInfoStatus.init,
      ),
    );
  }

  void setElementry(bool value) {
    TeacherExtraInfoEntity infoEntity =
        state.teacherExtraInfoEntity.copyWith(teachElementry: value);
    emit(
      state.copyWith(
        info: infoEntity,
        teacherinfoStatus: TeacherExtraInfoStatus.init,
      ),
    );
  }

  void setPreparatory(bool value) {
    TeacherExtraInfoEntity infoEntity =
        state.teacherExtraInfoEntity.copyWith(teachPreparatory: value);
    emit(
      state.copyWith(
        info: infoEntity,
        teacherinfoStatus: TeacherExtraInfoStatus.init,
      ),
    );
  }

  void setSecondary(bool value) {
    TeacherExtraInfoEntity infoEntity =
        state.teacherExtraInfoEntity.copyWith(teachSecondary: value);
    emit(
      state.copyWith(
        info: infoEntity,
        teacherinfoStatus: TeacherExtraInfoStatus.init,
      ),
    );
  }

  void setUniversity(bool value) {
    TeacherExtraInfoEntity infoEntity =
        state.teacherExtraInfoEntity.copyWith(teachUniversity: value);
    emit(
      state.copyWith(
        info: infoEntity,
        teacherinfoStatus: TeacherExtraInfoStatus.init,
      ),
    );
  }

  void addCategory(CategoryEntity categoryEntity) {
    List<CategoryEntity> categories = List.generate(
        state.teacherExtraInfoEntity.categories.length,
        (index) => state.teacherExtraInfoEntity.categories[index]);
    categories.add(categoryEntity);
    TeacherExtraInfoEntity infoEntity =
        state.teacherExtraInfoEntity.copyWith(categories: categories);
    emit(
      state.copyWith(
        info: infoEntity,
        teacherinfoStatus: TeacherExtraInfoStatus.init,
      ),
    );
  }

  void deleteCategory(CategoryEntity categoryEntity) {
    List<CategoryEntity> categories = List.generate(
        state.teacherExtraInfoEntity.categories.length,
        (index) => state.teacherExtraInfoEntity.categories[index]);
    categories.remove(categoryEntity);
    TeacherExtraInfoEntity infoEntity =
        state.teacherExtraInfoEntity.copyWith(categories: categories);
    emit(
      state.copyWith(
        info: infoEntity,
        teacherinfoStatus: TeacherExtraInfoStatus.init,
      ),
    );
  }

  void setCertificates(String certificates) {
    TeacherExtraInfoEntity infoEntity =
        state.teacherExtraInfoEntity.copyWith(certificates: certificates);
    emit(
      state.copyWith(
        info: infoEntity,
        teacherinfoStatus: TeacherExtraInfoStatus.init,
      ),
    );
  }

  void setSkills(String skills) {
    TeacherExtraInfoEntity infoEntity =
        state.teacherExtraInfoEntity.copyWith(skills: skills);
    emit(
      state.copyWith(
        info: infoEntity,
        teacherinfoStatus: TeacherExtraInfoStatus.init,
      ),
    );
  }

  void setAddress(String address) {
    TeacherExtraInfoEntity infoEntity =
        state.teacherExtraInfoEntity.copyWith(address: address);
    emit(
      state.copyWith(
        info: infoEntity,
        teacherinfoStatus: TeacherExtraInfoStatus.init,
      ),
    );
  }

  void submit({required String id}) async {
    emit(state.copyWith(
        teacherinfoStatus: TeacherExtraInfoStatus.loading, errorMessage: ''));
    final res = await submitTeacherExtraInfoUseCase(
      teacherExtraInfoEntity: state.teacherExtraInfoEntity,
      userId: id,
    );
    res.fold((f) {
      _mapFailureToState(emit, f, state);
    }, (data) async {
      emit(
        state.copyWith(
          teacherinfoStatus: TeacherExtraInfoStatus.done,
          errorMessage: '',
        ),
      );
    });
  }
}

_mapFailureToState(emit, Failure f, TeacherExtraInfoState state) {
  switch (f) {
    case OfflineFailure():
      emit(
        state.copyWith(
          teacherinfoStatus: TeacherExtraInfoStatus.noInternet,
          errorMessage: '',
        ),
      );

    case NetworkErrorFailure f:
      emit(
        state.copyWith(
          teacherinfoStatus: TeacherExtraInfoStatus.noInternet,
          errorMessage: f.message,
        ),
      );
  }
}
