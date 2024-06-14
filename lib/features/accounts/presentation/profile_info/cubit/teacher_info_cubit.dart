// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';

import 'package:khosousi_online/features/accounts/domain/entities/teacher_contact_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/use_cases/sumbit_teacher_info_use_case.dart';
import 'package:khosousi_online/shared_features/domain/entities/city_entity.dart';
import 'package:khosousi_online/shared_features/domain/entities/country_entity.dart';

part 'teacher_info_state.dart';

class TeacherInfoCubit extends Cubit<TeacherInfoState> {
  final SubmitTeacherInfoUseCase submitTeacherInfoUseCase;
  TeacherInfoCubit({
    required this.submitTeacherInfoUseCase,
  }) : super(TeacherInfoState.empty());


  void setMobile(String mobile) {
    TeacherContactInfoEntity infoEntity =
        state.teacherInfoEntity.copyWith(mobile: mobile);
    emit(state.copyWith(
        info: infoEntity, teacherinfoStatus: TeacherinfoStatus.init));
  }

  void setWhats(String whatsapp) {
    TeacherContactInfoEntity infoEntity =
        state.teacherInfoEntity.copyWith(whatsapp: whatsapp);
    emit(state.copyWith(
        info: infoEntity, teacherinfoStatus: TeacherinfoStatus.init));
  }

  void setMobileCountryCode(CountryEntity mobileCountryCode) {
    TeacherContactInfoEntity infoEntity =
        state.teacherInfoEntity.copyWith(mobileCountry: mobileCountryCode);
    emit(state.copyWith(
        info: infoEntity, teacherinfoStatus: TeacherinfoStatus.init));
  }

  void setWhatsappCountryCode(CountryEntity whatsappCountryCode) {
    TeacherContactInfoEntity infoEntity =
        state.teacherInfoEntity.copyWith(whatsappCountry: whatsappCountryCode);
    emit(state.copyWith(
        info: infoEntity, teacherinfoStatus: TeacherinfoStatus.init));
  }

  void setBornDate(DateTime bornDate) {
    TeacherContactInfoEntity infoEntity =
        state.teacherInfoEntity.copyWith(bornDate: bornDate);
    emit(state.copyWith(
        info: infoEntity, teacherinfoStatus: TeacherinfoStatus.init));
  }

  void setGender(Gender gender) {
    TeacherContactInfoEntity infoEntity =
        state.teacherInfoEntity.copyWith(gender: gender);
    emit(state.copyWith(
        info: infoEntity, teacherinfoStatus: TeacherinfoStatus.init));
  }

  void setNationality(CountryEntity nationality) {
    TeacherContactInfoEntity infoEntity = state.teacherInfoEntity.copyWith(
      nationality: nationality,
    );
    emit(state.copyWith(
        info: infoEntity, teacherinfoStatus: TeacherinfoStatus.init));
  }
  void emptyNationality() {
    TeacherContactInfoEntity teacherInfoEntity = TeacherContactInfoEntity(
      gender: state.teacherInfoEntity.gender,
      bornDate: state.teacherInfoEntity.bornDate,
      whatsappCountry: state.teacherInfoEntity.whatsappCountry,
      whatsapp: state.teacherInfoEntity.whatsapp,
      mobile: state.teacherInfoEntity.mobile,
      mobileCountry: state.teacherInfoEntity.mobileCountry,
      facebook: state.teacherInfoEntity.facebook,
      instagram: state.teacherInfoEntity.instagram,
      linkedin: state.teacherInfoEntity.linkedin,
      nationality:CountryEntity.empty(),
      threads: state.teacherInfoEntity.threads,
      tiktok: state.teacherInfoEntity.tiktok,
      x_twitter: state.teacherInfoEntity.x_twitter,
      youtube: state.teacherInfoEntity.youtube,
      countryResidence: state.teacherInfoEntity.countryResidence,
      cityResidence: state.teacherInfoEntity.cityResidence,
    );

    emit(state.copyWith(
      info: teacherInfoEntity,
      teacherinfoStatus: TeacherinfoStatus.init,
    )); }


  void setCountryResidence(CountryEntity countryResidence) {
    TeacherContactInfoEntity infoEntity =
        state.teacherInfoEntity.copyWith(countryResidence: countryResidence);
    emit(state.copyWith(
        info: infoEntity, teacherinfoStatus: TeacherinfoStatus.init));
  }

  void setCityResidence(CityEntity cityResidence) {
    TeacherContactInfoEntity infoEntity =
        state.teacherInfoEntity.copyWith(cityResidence: cityResidence);
    emit(state.copyWith(
        info: infoEntity, teacherinfoStatus: TeacherinfoStatus.init));
  }

  void emptyResidence() {
    TeacherContactInfoEntity teacherInfoEntity = TeacherContactInfoEntity(
      gender: state.teacherInfoEntity.gender,
      bornDate: state.teacherInfoEntity.bornDate,
      whatsappCountry: state.teacherInfoEntity.whatsappCountry,
      whatsapp: state.teacherInfoEntity.whatsapp,
      mobile: state.teacherInfoEntity.mobile,
      mobileCountry: state.teacherInfoEntity.mobileCountry,
      facebook: state.teacherInfoEntity.facebook,
      instagram: state.teacherInfoEntity.instagram,
      linkedin: state.teacherInfoEntity.linkedin,
      nationality: state.teacherInfoEntity.nationality,
      threads: state.teacherInfoEntity.threads,
      tiktok: state.teacherInfoEntity.tiktok,
      x_twitter: state.teacherInfoEntity.x_twitter,
      youtube: state.teacherInfoEntity.youtube,
      countryResidence: CountryEntity.empty(),
      cityResidence: null,
    );

    emit(state.copyWith(
      info: teacherInfoEntity,
      teacherinfoStatus: TeacherinfoStatus.init,
    ));
  }

  void setFacebook(String facebook) {
    TeacherContactInfoEntity infoEntity =
        state.teacherInfoEntity.copyWith(facebook: facebook);
    emit(state.copyWith(
        info: infoEntity, teacherinfoStatus: TeacherinfoStatus.init));
  }

  void setInstagram(String instagram) {
    TeacherContactInfoEntity infoEntity =
        state.teacherInfoEntity.copyWith(instagram: instagram);
    emit(state.copyWith(
        info: infoEntity, teacherinfoStatus: TeacherinfoStatus.init));
  }

  void setYoutube(String youtube) {
    TeacherContactInfoEntity infoEntity =
        state.teacherInfoEntity.copyWith(youtube: youtube);
    emit(state.copyWith(
        info: infoEntity, teacherinfoStatus: TeacherinfoStatus.init));
  }

  void setTiktok(String tiktok) {
    TeacherContactInfoEntity infoEntity =
        state.teacherInfoEntity.copyWith(tiktok: tiktok);
    emit(state.copyWith(
        info: infoEntity, teacherinfoStatus: TeacherinfoStatus.init));
  }

  void setThreads(String threads) {
    TeacherContactInfoEntity infoEntity =
        state.teacherInfoEntity.copyWith(threads: threads);
    emit(state.copyWith(
        info: infoEntity, teacherinfoStatus: TeacherinfoStatus.init));
  }

  void setXTwitter(String x_twitter) {
    TeacherContactInfoEntity infoEntity =
        state.teacherInfoEntity.copyWith(x_twitter: x_twitter);
    emit(state.copyWith(
        info: infoEntity, teacherinfoStatus: TeacherinfoStatus.init));
  }

  void setLinkedIn(String linkedin) {
    TeacherContactInfoEntity infoEntity =
        state.teacherInfoEntity.copyWith(linkedin: linkedin);
    emit(state.copyWith(
        info: infoEntity, teacherinfoStatus: TeacherinfoStatus.init));
  }

  void submit({required String id}) async {
    emit(state.copyWith(
        teacherinfoStatus: TeacherinfoStatus.loading, errorMessage: ''));
    final res = await submitTeacherInfoUseCase(
      teacherInfoEntity: state.teacherInfoEntity,
      userId: id,
    );
    res.fold((f) {
      _mapFailureToState(emit, f, state);
    }, (data) async {
      emit(
        state.copyWith(
          teacherinfoStatus: TeacherinfoStatus.done,
          errorMessage: '',
        ),
      );
    });
  }
}

_mapFailureToState(emit, Failure f, TeacherInfoState state) {
  switch (f) {
    case OfflineFailure():
      emit(
        state.copyWith(
          teacherinfoStatus: TeacherinfoStatus.noInternet,
          errorMessage: '',
        ),
      );

    case NetworkErrorFailure f:
      emit(
        state.copyWith(
          teacherinfoStatus: TeacherinfoStatus.noInternet,
          errorMessage: f.message,
        ),
      );
  }
}
