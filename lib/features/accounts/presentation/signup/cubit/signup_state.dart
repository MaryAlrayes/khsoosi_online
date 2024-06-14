// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_cubit.dart';

enum SignupStatus { init, loading, done, noInternet, networkError }

class SignupState extends Equatable {
  final SignupDataEntity signupDataEntity;
  final SignupStatus signupStatus;
  final String errorMessage;
  const SignupState({
    required this.signupDataEntity,
    required this.signupStatus,
    required this.errorMessage,
  });

  factory SignupState.empty() {
    return SignupState(
      signupDataEntity: SignupDataEntity.empty(),
      signupStatus: SignupStatus.init,
      errorMessage: '',
    );
  }
  @override
  List<Object> get props => [signupDataEntity, signupStatus,errorMessage];

  SignupState copyWith(
      {UserType? userType,
      String? userName,
      String? name,
      String? email,
      String? confirmEmail,
      String? password,
      String? confirmPassword,
      bool? isCheckedTerms,
      SignupStatus? signupStatus,
      String? errorMessage }) {
    return SignupState(
      signupDataEntity: signupDataEntity.copyWith(
        userType: userType ?? this.signupDataEntity.userType,
        userName: userName ?? this.signupDataEntity.userName,
        name: name ?? this.signupDataEntity.name,
        email: email ?? this.signupDataEntity.email,
        confirmEmail: confirmEmail ?? this.signupDataEntity.confirmEmail,
        password: password ?? this.signupDataEntity.password,
        confirmPassword:
            confirmPassword ?? this.signupDataEntity.confirmPassword,
        isCheckedTerms: isCheckedTerms ?? this.signupDataEntity.isCheckedTerms,
      ),
      signupStatus: signupStatus?? this.signupStatus,
      errorMessage:errorMessage?? this.errorMessage
    );
  }
}
