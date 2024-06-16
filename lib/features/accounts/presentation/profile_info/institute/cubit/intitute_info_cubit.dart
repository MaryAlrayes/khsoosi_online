// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';

import 'package:khosousi_online/features/accounts/domain/entities/institute_contact_info_entity.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/screens/institute_info.dart';
import 'package:khosousi_online/shared_features/domain/entities/city_entity.dart';
import 'package:khosousi_online/shared_features/domain/entities/country_entity.dart';

import '../../../../domain/use_cases/submit_institute_info_use_case.dart';

part 'intitute_info_state.dart';

class IntituteInfoCubit extends Cubit<IntituteInfoState> {
  final SubmitInstituteInfoUseCase submitInstituteInfoUseCase;
  IntituteInfoCubit({
    required this.submitInstituteInfoUseCase,
  }) : super(IntituteInfoState.empty());

  void setMobile(String mobile) {
    InstituteContactEnitity infoEntity =
        state.instituteContactEnitity.copyWith(mobile: mobile);
    emit(state.copyWith(
        info: infoEntity, intituteInfoStatus: IntituteInfoStatus.init));
  }

  void setWhats(String whatsapp) {
    InstituteContactEnitity infoEntity =
        state.instituteContactEnitity.copyWith(whatsapp: whatsapp);
    emit(
      state.copyWith(
        info: infoEntity,
        intituteInfoStatus: IntituteInfoStatus.init,
      ),
    );
  }

  void setMobileCountryCode(CountryEntity mobileCountryCode) {
    InstituteContactEnitity infoEntity = state.instituteContactEnitity
        .copyWith(mobileCountry: mobileCountryCode);
    emit(
      state.copyWith(
        info: infoEntity,
        intituteInfoStatus: IntituteInfoStatus.init,
      ),
    );
  }

  void setWhatsappCountryCode(CountryEntity whatsappCountryCode) {
    InstituteContactEnitity infoEntity = state.instituteContactEnitity
        .copyWith(whatsappCountry: whatsappCountryCode);
    emit(
      state.copyWith(
        info: infoEntity,
        intituteInfoStatus: IntituteInfoStatus.init,
      ),
    );
  }

  void setBornDate(DateTime bornDate) {
    InstituteContactEnitity infoEntity =
        state.instituteContactEnitity.copyWith(bornDate: bornDate);
    emit(
      state.copyWith(
        info: infoEntity,
        intituteInfoStatus: IntituteInfoStatus.init,
      ),
    );
  }



  void setNationality(CountryEntity nationality) {
    InstituteContactEnitity infoEntity =
        state.instituteContactEnitity.copyWith(nationality: nationality);
    emit(
      state.copyWith(
        info: infoEntity,
        intituteInfoStatus: IntituteInfoStatus.init,
      ),
    );
  }

  void emptyNationality() {
    InstituteContactEnitity instituteContactEnitity = InstituteContactEnitity(
      bornDate: state.instituteContactEnitity.bornDate,
      whatsappCountry: state.instituteContactEnitity.whatsappCountry,
      whatsapp: state.instituteContactEnitity.whatsapp,
      mobile: state.instituteContactEnitity.mobile,
      mobileCountry: state.instituteContactEnitity.mobileCountry,
      nationality: CountryEntity.empty(),
      countryResidence: state.instituteContactEnitity.countryResidence,
      cityResidence: state.instituteContactEnitity.cityResidence,
    );

    emit(state.copyWith(
      info: instituteContactEnitity,
      intituteInfoStatus: IntituteInfoStatus.init,
    ));
  }

  void setCountryResidence(CountryEntity countryResidence) {
    InstituteContactEnitity infoEntity = state.instituteContactEnitity
        .copyWith(countryResidence: countryResidence);
    emit(state.copyWith(
        info: infoEntity, intituteInfoStatus: IntituteInfoStatus.init));
  }

  void setCityResidence(CityEntity cityResidence) {
    InstituteContactEnitity infoEntity =
        state.instituteContactEnitity.copyWith(cityResidence: cityResidence);
    emit(state.copyWith(
        info: infoEntity, intituteInfoStatus: IntituteInfoStatus.init));
  }

  void emptyResidence() {
    InstituteContactEnitity instituteContactEnitity = InstituteContactEnitity(

      bornDate: state.instituteContactEnitity.bornDate,
      whatsappCountry: state.instituteContactEnitity.whatsappCountry,
      whatsapp: state.instituteContactEnitity.whatsapp,
      mobile: state.instituteContactEnitity.mobile,
      mobileCountry: state.instituteContactEnitity.mobileCountry,
      nationality: state.instituteContactEnitity.nationality,
      countryResidence: CountryEntity.empty(),
      cityResidence: null,
    );

    emit(
      state.copyWith(
        info: instituteContactEnitity,
        intituteInfoStatus: IntituteInfoStatus.init,
      ),
    );
  }

  void submit({required String id}) async {
    emit(state.copyWith(
        intituteInfoStatus: IntituteInfoStatus.loading, errorMessage: ''));
    final res = await submitInstituteInfoUseCase(
      instituteContactEnitity: state.instituteContactEnitity,
      userId: id,
    );
    res.fold((f) {
      _mapFailureToState(emit, f, state);
    }, (data) async {
      emit(
        state.copyWith(
          intituteInfoStatus: IntituteInfoStatus.done,
          errorMessage: '',
        ),
      );
    });
  }
}

_mapFailureToState(emit, Failure f, IntituteInfoState state) {
  switch (f) {
    case OfflineFailure():
      emit(
        state.copyWith(
          intituteInfoStatus: IntituteInfoStatus.noInternet,
          errorMessage: '',
        ),
      );

    case NetworkErrorFailure f:
      emit(
        state.copyWith(
          intituteInfoStatus: IntituteInfoStatus.networkError,
          errorMessage: f.message,
        ),
      );
  }
}
