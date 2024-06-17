import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/search/domain/entities/search_filter_entity.dart';
import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';
import 'package:khosousi_online/features/location/domain/entities/city_entity.dart';
import 'package:khosousi_online/features/location/domain/entities/country_entity.dart';

part 'filter_search_state.dart';

class FilterSearchCubit extends Cubit<FilterSearchState> {
  FilterSearchCubit() : super(FilterSearchState.empty());

  void resetFilter() {
    emit(
      FilterSearchState(
        filter: SearchFilterEntity.empty(),
        previousfilter: SearchFilterEntity.empty(),
      ),
    );
  }

  void saveFilter() {
    emit(state.copyWith(previous: state.filter));
  }

  void restoreFilter() {
    emit(state.copyWith(filter: state.previousfilter));
  }

  void setTeachingMethod(TeachingMethod teachingMethod) {
    SearchFilterEntity filterEntity =
        state.filter.copyWith(teachingMethod: teachingMethod);
    emit(
      state.copyWith(filter: filterEntity),
    );
  }

  void setEducationLevel(EducationalLevel educationalLevel) {
    SearchFilterEntity filterEntity =
        state.filter.copyWith(educationalLevel: educationalLevel);
    emit(
      state.copyWith(filter: filterEntity),
    );
  }

  void setspeciality(CategoryEntity speciality) {
    SearchFilterEntity filterEntity =
        state.filter.copyWith(speciality: speciality);
    emit(
      state.copyWith(filter: filterEntity),
    );
  }

  void setGender(Gender? gender) {
    SearchFilterEntity filterEntity = SearchFilterEntity(
        teachingMethod: state.filter.teachingMethod,
        educationalLevel: state.filter.educationalLevel,
        speciality: state.filter.speciality,
        locationType: state.filter.locationType,
        lat: state.filter.lat,
        lng: state.filter.lng,
        country: state.filter.country,
        city: state.filter.city,
        gender: gender,
        keyword: state.filter.keyword);

    emit(state.copyWith(filter: filterEntity));
  }

  void setKeyword(String keyword) {
    SearchFilterEntity filterEntity = state.filter.copyWith(keyword: keyword);
    emit(
      state.copyWith(filter: filterEntity),
    );
  }

  void setLocationType(LocationType locationType) {
    SearchFilterEntity filterEntity =
        state.filter.copyWith(locationType: locationType);
    emit(
      state.copyWith(filter: filterEntity),
    );
  }

  void setCoord(double lat,double lng) {
    SearchFilterEntity filterEntity =
        state.filter.copyWith(lat: lat,lng:lng);
    emit(
      state.copyWith(filter: filterEntity),
    );
  }

  void setCountry(CountryEntity country) {
    SearchFilterEntity filterEntity = SearchFilterEntity(
        teachingMethod: state.filter.teachingMethod,
        educationalLevel: state.filter.educationalLevel,
        speciality: state.filter.speciality,
        locationType: state.filter.locationType,
        country: country,
        lat: state.filter.lat,
        lng: state.filter.lng,
        city: null,
        gender: state.filter.gender,
        keyword: state.filter.keyword);
    emit(state.copyWith(filter: filterEntity));
  }

  void emptyCountry() {
    SearchFilterEntity filterEntity = SearchFilterEntity(
        teachingMethod: state.filter.teachingMethod,
        educationalLevel: state.filter.educationalLevel,
        speciality: state.filter.speciality,
        locationType: state.filter.locationType,
        lat: state.filter.lat,
        lng: state.filter.lng,
        country: null,
        city: null,
        gender: state.filter.gender,
        keyword: state.filter.keyword);
    emit(state.copyWith(filter: filterEntity));
  }

  void emptySpeciality() {
    SearchFilterEntity filterEntity = SearchFilterEntity(
      teachingMethod: state.filter.teachingMethod,
      educationalLevel: state.filter.educationalLevel,
      speciality: null,
      locationType: state.filter.locationType,
      lat: state.filter.lat,
        lng: state.filter.lng,
      country: state.filter.country,
      city: state.filter.city,
      gender: state.filter.gender,
      keyword: state.filter.keyword,
    );
    emit(state.copyWith(filter: filterEntity));
  }

  void setCity(CityEntity city) {
    SearchFilterEntity filterEntity = state.filter.copyWith(city: city);
    emit(
      state.copyWith(filter: filterEntity),
    );
  }
}
