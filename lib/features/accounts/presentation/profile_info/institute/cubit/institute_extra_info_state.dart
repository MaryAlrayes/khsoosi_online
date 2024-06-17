// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'institute_extra_info_cubit.dart';
enum IntituteExtraInfoStatus { init, loading, done, noInternet, networkError }

class InstituteExtraInfoState extends Equatable {
  final InstituteExtraInfoEntity instituteExtraInfoEntity;
  final IntituteExtraInfoStatus intituteExtraInfoStatus;
  final String errorMessage;
  InstituteExtraInfoState({
    required this.instituteExtraInfoEntity,
    required this.intituteExtraInfoStatus,
    required this.errorMessage,
  });


  factory InstituteExtraInfoState.empty() {
    return InstituteExtraInfoState(
        errorMessage: '',
        instituteExtraInfoEntity:InstituteExtraInfoEntity.empty() ,
        intituteExtraInfoStatus:IntituteExtraInfoStatus.init ,
      );
  }
  @override
  List<Object> get props => [
        instituteExtraInfoEntity,
        intituteExtraInfoStatus,
        errorMessage,
      ];

  InstituteExtraInfoState copyWith({
    InstituteExtraInfoEntity? info,
    IntituteExtraInfoStatus? intituteExtraInfoStatus,
    String? errorMessage,
  }) {
    return InstituteExtraInfoState(
      instituteExtraInfoEntity:  info ?? this.instituteExtraInfoEntity,
      intituteExtraInfoStatus: intituteExtraInfoStatus??this.intituteExtraInfoStatus,
     errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool get stringify => true;
}
