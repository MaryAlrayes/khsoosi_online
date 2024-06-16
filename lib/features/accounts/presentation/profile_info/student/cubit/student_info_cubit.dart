// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';

import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/shared_features/domain/entities/country_entity.dart';

import '../../../../domain/entities/student_contact_info_entity.dart';
import '../../../../domain/use_cases/submit_student_info_use_case.dart';

part 'student_info_state.dart';

class StudentInfoCubit extends Cubit<StudentInfoState> {
  final SubmitStudentInfoUseCase studentInfoUseCase;

  StudentInfoCubit({
    required this.studentInfoUseCase,
  }) : super(StudentInfoState.empty());

  void setMobile(String mobile) {
    StudentContactInfoEntity infoEntity =
        state.studentInfoEntity.copyWith(mobile: mobile);
    emit(state.copyWith(
        info: infoEntity, studentInfoStatus: StudentInfoStatus.init));
  }

  void setWhats(String whatsapp) {
    StudentContactInfoEntity infoEntity =
        state.studentInfoEntity.copyWith(whatsapp: whatsapp);
    emit(state.copyWith(
        info: infoEntity, studentInfoStatus: StudentInfoStatus.init));
  }

  void setMobileCountryCode(CountryEntity mobileCountryCode) {
    StudentContactInfoEntity infoEntity =
        state.studentInfoEntity.copyWith(mobileCountry: mobileCountryCode);
    emit(state.copyWith(
        info: infoEntity, studentInfoStatus: StudentInfoStatus.init));
  }

  void setWhatsappCountryCode(CountryEntity whatsappCountryCode) {
    StudentContactInfoEntity infoEntity =
        state.studentInfoEntity.copyWith(whatsappCountry: whatsappCountryCode);
    emit(state.copyWith(
        info: infoEntity, studentInfoStatus: StudentInfoStatus.init));
  }

  void setBornDate(DateTime bornDate) {
    StudentContactInfoEntity infoEntity =
        state.studentInfoEntity.copyWith(bornDate: bornDate);
    emit(state.copyWith(
        info: infoEntity, studentInfoStatus: StudentInfoStatus.init));
  }

  void setGender(Gender gender) {
    StudentContactInfoEntity infoEntity =
        state.studentInfoEntity.copyWith(gender: gender);
    emit(state.copyWith(
        info: infoEntity, studentInfoStatus: StudentInfoStatus.init));
  }

  void setResidence(CountryEntity residence) {
    StudentContactInfoEntity infoEntity =
        state.studentInfoEntity.copyWith(countryResidence: residence);
    emit(state.copyWith(
        info: infoEntity, studentInfoStatus: StudentInfoStatus.init));
  }

  void emptyResidence() {
    StudentContactInfoEntity studentInfoEntity = StudentContactInfoEntity(
      gender: state.studentInfoEntity.gender,
      bornDate: state.studentInfoEntity.bornDate,
      whatsappCountry: state.studentInfoEntity.whatsappCountry,
      whatsapp: state.studentInfoEntity.whatsapp,
      mobile: state.studentInfoEntity.mobile,
      mobileCountry: state.studentInfoEntity.mobileCountry,
      countryResidence: CountryEntity.empty(),
    );

    emit(state.copyWith(
        info: studentInfoEntity, studentInfoStatus: StudentInfoStatus.init,));
  }

  void submit({required String id}) async {
    emit(state.copyWith(studentInfoStatus: StudentInfoStatus.loading,errorMessage:''));
    final res = await studentInfoUseCase(
      studentInfoEntity: state.studentInfoEntity,
      userId: id,
    );
    res.fold((f) {
      _mapFailureToState(emit, f, state);
    }, (data) async {
      emit(state.copyWith(studentInfoStatus: StudentInfoStatus.done,errorMessage:''));
    });
  }
}

_mapFailureToState(emit, Failure f, StudentInfoState state) {
  switch (f) {
    case OfflineFailure():
      emit(state.copyWith(studentInfoStatus: StudentInfoStatus.noInternet,errorMessage:''));

    case NetworkErrorFailure f:
      emit(state.copyWith(
          studentInfoStatus: StudentInfoStatus.networkError,
          errorMessage: f.message));
  }
}
