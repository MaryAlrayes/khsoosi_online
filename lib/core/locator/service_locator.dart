import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/api_service/network_service_dio.dart';
import 'package:khosousi_online/core/network/check_internet.dart';
import 'package:khosousi_online/features/accounts/data/data_sources/accounts_data_provider.dart';
import 'package:khosousi_online/features/accounts/data/repositories_impl/accounts_repo_impl.dart';
import 'package:khosousi_online/features/accounts/data/repositories_impl/auth_repo_impl.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/accounts_repo.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/accounts/domain/use_cases/activate_account_use_case.dart';
import 'package:khosousi_online/features/accounts/domain/use_cases/fetch_user_data_use_case.dart';
import 'package:khosousi_online/features/accounts/domain/use_cases/login_use_case.dart';
import 'package:khosousi_online/features/accounts/domain/use_cases/resend_activation_code_use_case.dart';
import 'package:khosousi_online/features/accounts/domain/use_cases/signup_use_case.dart';
import 'package:khosousi_online/features/accounts/domain/use_cases/submit_institute_extra_info_use_case.dart';
import 'package:khosousi_online/features/accounts/domain/use_cases/submit_institute_info_use_case.dart';
import 'package:khosousi_online/features/accounts/domain/use_cases/submit_student_info_use_case.dart';
import 'package:khosousi_online/features/accounts/domain/use_cases/submit_teacher_extra_info_use_case.dart';
import 'package:khosousi_online/features/accounts/domain/use_cases/submit_teacher_info_use_case.dart';
import 'package:khosousi_online/features/accounts/domain/use_cases/upload_picture_use_case.dart';
import 'package:khosousi_online/features/accounts/presentation/login/blocs/authentication_bloc.dart';
import 'package:khosousi_online/features/accounts/presentation/login/cubit/login_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/otp/cubit/activate_account_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/otp/cubit/resend_activation_code_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/cubit/institute_extra_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/cubit/institute_info_stepper_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/cubit/intitute_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/student/cubit/student_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/student/cubit/student_info_stepper_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/cubit/teacher_extra_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/cubit/teacher_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/cubit/teacher_info_stepper_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/cubit/upload_picture_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/signup/cubit/signup_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/signup/cubit/signup_stepper_cubit.dart';
import 'package:khosousi_online/features/assistence/data/data_sources/assistence_data_source.dart';
import 'package:khosousi_online/features/conditions_terms/data/data_sources/conditions_data_source.dart';
import 'package:khosousi_online/features/conditions_terms/data/repositories_impl/conditions_repo_impl.dart';
import 'package:khosousi_online/features/conditions_terms/domain/repositories/conditions_repo.dart';
import 'package:khosousi_online/features/conditions_terms/domain/use_cases/answer_conditions_use_case.dart';
import 'package:khosousi_online/features/conditions_terms/presentation/cubit/answer_conditions_cubit.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/data/data%20providers/portofolio_details_data_provider.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/data/data%20providers/service_details_data_provider.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/data/repositories/portofolio_details_repo_impl.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/data/repositories/service_details_repo_impl.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/repositories/course_details_repo.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/repositories/services_details_repo.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/use%20cases/course_details_use_case.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/use%20cases/portofolio_details_use_case.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/use%20cases/service_details_use_case.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/presentation/courses/bloc/get_course_details_bloc.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/presentation/portofolio/bloc/get_portofolio_details_bloc.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/presentation/services/bloc/get_services_details_bloc.dart';
import 'package:khosousi_online/features/edit_password/data/data_sources/edit_password_data_source.dart';
import 'package:khosousi_online/features/edit_password/data/repositories_impl/change_password_repo_impl.dart';
import 'package:khosousi_online/features/edit_password/domain/use_cases/change_password_use_case.dart';
import 'package:khosousi_online/features/edit_password/presentation/cubit/change_password_cubit.dart';
import 'package:khosousi_online/features/institute_details/data/data_sources/institute_details_data_provider.dart';
import 'package:khosousi_online/features/institute_details/data/repositories_impl/institute_details_repo_impl.dart';
import 'package:khosousi_online/features/institute_details/domain/repositories/institute_details_repo.dart';
import 'package:khosousi_online/features/institute_details/domain/use_cases/get_institute_details_use_case.dart';
import 'package:khosousi_online/features/localization/cubit/lacalization_cubit.dart';
import 'package:khosousi_online/features/localization/localize_app.dart';
import 'package:khosousi_online/features/localization/localize_app_impl.dart';
import 'package:khosousi_online/features/location/domain/use_cases/submit_location_use_case.dart';
import 'package:khosousi_online/features/location/presentation/cubit/add_location_cubit.dart';
import 'package:khosousi_online/features/notification/data/data_sources/notification_data_provider.dart';
import 'package:khosousi_online/features/notification/presentation/cubit/get_notification_cubit.dart';
import 'package:khosousi_online/features/refresh/domain/use_cases/refresh_account_use_case.dart';
import 'package:khosousi_online/features/refresh/presentation/cubit/refresh_account_cubit.dart';
import 'package:khosousi_online/features/search/data/data%20providers/search_courses_data_provider.dart';
import 'package:khosousi_online/features/search/data/data%20providers/search_institutes_data_provider.dart';
import 'package:khosousi_online/features/search/data/data%20providers/search_services_data_provider.dart';
import 'package:khosousi_online/features/search/data/data%20providers/search_teachers_data_provider.dart';
import 'package:khosousi_online/features/search/data/repositories/search_courses_repo_impl.dart';
import 'package:khosousi_online/features/search/data/repositories/search_institutes_repo_impl.dart';
import 'package:khosousi_online/features/search/data/repositories/search_services_repo_impl.dart';
import 'package:khosousi_online/features/search/data/repositories/search_teacher_repo_impl.dart';
import 'package:khosousi_online/features/search/domain/repositories/search_courses_repo.dart';
import 'package:khosousi_online/features/search/domain/repositories/search_institutes_repo.dart';
import 'package:khosousi_online/features/search/domain/repositories/search_services_repo.dart';
import 'package:khosousi_online/features/search/domain/repositories/search_teachers_repo.dart';
import 'package:khosousi_online/features/search/domain/use%20cases/search_courses_use_case.dart';
import 'package:khosousi_online/features/search/domain/use%20cases/search_institutes_use_case.dart';
import 'package:khosousi_online/features/search/domain/use%20cases/search_services_use_case.dart';
import 'package:khosousi_online/features/search/domain/use%20cases/search_teachers_use_case.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_stepper_cubit.dart';
import 'package:khosousi_online/features/search/presentation/search/cubit/search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/search_courses/bloc/get_courses_bloc.dart';
import 'package:khosousi_online/features/search/presentation/search_institutes/bloc/get_institutes_bloc.dart';
import 'package:khosousi_online/features/search/presentation/search_services/bloc/get_services_bloc.dart';
import 'package:khosousi_online/features/search/presentation/search_teacher/bloc/get_teachers_bloc.dart';
import 'package:khosousi_online/features/statistics/data/data_sources/teacher_stat_data_source.dart';
import 'package:khosousi_online/features/statistics/data/repositories_impl/stat_repo_impl.dart';
import 'package:khosousi_online/features/statistics/domain/repositories/state_repo.dart';
import 'package:khosousi_online/features/statistics/presentation/cubit/get_student_stat_cubit.dart';
import 'package:khosousi_online/features/statistics/presentation/cubit/get_teacher_stat_cubit.dart';
import 'package:khosousi_online/features/teacher_balance/data/data_sources/teacher_balance_data_source.dart';
import 'package:khosousi_online/features/teacher_balance/data/repositories_impl/teacher_balance_repo_imp.dart';
import 'package:khosousi_online/features/teacher_balance/domain/repositories/teacher_balance_repo.dart';
import 'package:khosousi_online/features/teacher_balance/domain/use_cases/fetch_balance_use_case.dart';
import 'package:khosousi_online/features/teacher_balance/presentation/cubit/get_balance_cubit.dart';
import 'package:khosousi_online/features/teacher_courses/data/data_sources/teacher_courses_data_source.dart';
import 'package:khosousi_online/features/teacher_courses/data/repositories_impl/teacher_courses_repo_imp.dart';
import 'package:khosousi_online/features/teacher_courses/domain/repositories/teacher_courses_repo.dart';
import 'package:khosousi_online/features/teacher_courses/domain/use_cases/fetch_teacher_courses_use_case.dart';
import 'package:khosousi_online/features/teacher_courses/presentation/cubit/get_teacher_courses_cubit.dart';
import 'package:khosousi_online/features/teacher_details/data/data%20provider/teacher_details_data_provider.dart';
import 'package:khosousi_online/features/teacher_details/data/repositories/teacher_details_repo_impl.dart';
import 'package:khosousi_online/features/teacher_details/domain/repositories/teacher_details_repo.dart';
import 'package:khosousi_online/features/teacher_details/domain/use%20cases/get_teaches_details_use_case.dart';
import 'package:khosousi_online/features/teacher_details/presentation/bloc/get_teacher_details_bloc.dart';
import 'package:khosousi_online/features/location/presentation/blocs/coords_cubit.dart';
import 'package:khosousi_online/features/location/presentation/blocs/get_cities_bloc.dart';
import 'package:khosousi_online/features/location/presentation/blocs/get_countries_bloc.dart';
import 'package:khosousi_online/features/teacher_portofolio/data/data_sources/teacher_portofolio_data_source.dart';
import 'package:khosousi_online/features/teacher_rates/data/data_sources/teacher_review_data_source.dart';
import 'package:khosousi_online/features/teacher_rates/domain/repositories/teacher_reviews_repo.dart';
import 'package:khosousi_online/features/teacher_services/data/data_sources/teacher_service_data_source.dart';
import 'package:khosousi_online/features/teacher_services/data/repositories_impl/teacher_service_repo_impl.dart';
import 'package:khosousi_online/features/teacher_services/domain/repositories/teacher_service_repo.dart';
import 'package:khosousi_online/features/teacher_services/domain/use_cases/fetch_teacher_services_use_case.dart';
import 'package:khosousi_online/features/teacher_services/presentation/cubit/get_teacher_services_cubit.dart';
import 'package:khosousi_online/shared_features/data/data%20provider/categories_provider.dart';
import 'package:khosousi_online/features/location/data/data_sources/location_provider.dart';
import 'package:khosousi_online/shared_features/data/repositories/categories_repo_impl.dart';
import 'package:khosousi_online/features/location/data/repositories_impl/location_repo_impl.dart';
import 'package:khosousi_online/shared_features/domain/repositories/categories_repo.dart';
import 'package:khosousi_online/features/location/domain/repositories/location_repo.dart';
import 'package:khosousi_online/shared_features/domain/use_cases/get_categories_use_case.dart';
import 'package:khosousi_online/shared_features/domain/use_cases/get_cities_use_case.dart';
import 'package:khosousi_online/shared_features/domain/use_cases/get_countries_use_case.dart';
import '../../features/assistence/data/repositories_impl/assistence_repo_impl.dart';
import '../../features/assistence/domain/repositories/assistence_repo.dart';
import '../../features/assistence/domain/use_cases/fetch_faq_use_case.dart';
import '../../features/assistence/presentation/bloc/get_faq_bloc.dart';
import '../../features/courses_services_portofolio_details/data/data providers/course_details_data_provider.dart';
import '../../features/courses_services_portofolio_details/data/repositories/course_details_repo_impl.dart';
import '../../features/courses_services_portofolio_details/domain/repositories/portofolio_details_repo.dart';
import '../../features/edit_password/domain/repositories/change_password_repo.dart';
import '../../features/institute_details/presentation/bloc/get_institute_details_bloc.dart';
import '../../features/notification/data/repositories_impl/notification_repo_impl.dart';
import '../../features/notification/domain/repositories/notification_repo.dart';
import '../../features/notification/domain/use_cases/get_notification_use_case.dart';
import '../../features/statistics/domain/use_cases/fetch_student_stat_use_case.dart';
import '../../features/statistics/domain/use_cases/fetch_teacher_stat_use_case.dart';
import '../../features/teacher_portofolio/data/repositories_impl/teacher_portofolio_repo_impl.dart';
import '../../features/teacher_portofolio/domain/repositories/teacher_portofolio_repo.dart';
import '../../features/teacher_portofolio/domain/use_cases/fetch_teacher_portofolio_use_case.dart';
import '../../features/teacher_portofolio/presentation/cubit/get_teacher_portofolio_cubit.dart';
import '../../features/teacher_rates/data/repositories_impl/teacher_reviews_repo_impl.dart';
import '../../features/teacher_rates/domain/use_cases/fetch_reviews_use_case.dart';
import '../../features/teacher_rates/presentation/cubit/get_teacher_reviews_cubit.dart';
import '../../shared_features/presentation/bloc/get_categories_bloc.dart';

final locator = GetIt.I;

Future<void> setupLocator() async {
  //bloc
  locator.registerFactory(() => LacalizationCubit(locator()));
  locator.registerFactory(
      () => GetCategoriesBloc(getCategoriesUseCase: locator()));
  locator.registerFactory(() => GetCitiesBloc(getCitiessUseCase: locator()));
  locator
      .registerFactory(() => GetCountriesBloc(getCountriesUseCase: locator()));
  locator.registerFactory(
      () => GetTeacherDetailsBloc(getTeacherDetailsUseCase: locator()));
  locator.registerFactory(() => FilterSearchCubit());
  locator
      .registerFactory(() => GetTeachersBloc(searchTeachersUseCase: locator()));
  locator.registerFactory(() => SearchCubit());
  locator.registerFactory(() => CoordsCubit(locationRepo: locator()));
  locator.registerFactory(() => FilterStepperCubit());
  locator.registerFactory(
      () => RefreshAccountCubit(refreshAccountUseCase: locator()));
  locator.registerFactory(
      () => GetCourseDetailsBloc(courseDetailsUseCase: locator()));
  locator
      .registerFactory(() => GetCoursesBloc(searchCoursesUseCase: locator()));
  locator
      .registerFactory(() => GetServicesBloc(searchServicesUseCase: locator()));
  locator.registerFactory(
      () => GetServicesDetailsBloc(serviceDetailsUseCase: locator()));
  locator.registerFactory(() => SignupCubit(signupUseCase: locator()));
  locator.registerFactory(() => SignupStepperCubit());
  locator.registerFactory(() => LoginCubit(loginUseCase: locator()));
  locator.registerFactory(() => AuthenticationBloc(
      authRepository: locator(), fetchUserDataUseCase: locator()));
  locator.registerFactory(() => StudentInfoStepperCubit());
  locator
      .registerFactory(() => StudentInfoCubit(studentInfoUseCase: locator()));
  locator.registerFactory(
      () => UploadPictureCubit(uploadPictureUseCase: locator()));
  locator.registerFactory(
      () => ActivateAccountCubit(activateAccountUseCase: locator()));
  locator.registerFactory(
      () => ResendActivationCodeCubit(resendActivationCodeUseCase: locator()));
  locator.registerFactory(
      () => ChangePasswordCubit(changePasswordUseCase: locator()));
  locator.registerFactory(
      () => TeacherInfoCubit(submitTeacherInfoUseCase: locator()));
  locator.registerFactory(() => TeacherInfoStepperCubit());
  locator.registerFactory(
      () => TeacherExtraInfoCubit(submitTeacherExtraInfoUseCase: locator()));
  locator.registerFactory(
      () => IntituteInfoCubit(submitInstituteInfoUseCase: locator()));
  locator.registerFactory(() => InstituteInfoStepperCubit());
  locator.registerFactory(() =>
      InstituteExtraInfoCubit(submitInstituteExtraInfoUseCase: locator()));
  locator.registerFactory(
      () => AddLocationCubit(submitLocationUseCase: locator()));
  locator.registerFactory(
      () => AnswerConditionsCubit(answerConditionsUseCase: locator()));
  locator.registerFactory(
      () => GetInstitutesBloc(searchInstitutesUseCase: locator()));
locator.registerFactory(
      () => GetInstituteDetailsBloc(getInstituteDetailsUseCase : locator()));
locator.registerFactory(
      () => GetTeacherCoursesCubit(fetchTeacherCoursesUseCase: locator()));
locator.registerFactory(
      () => GetTeacherServicesCubit(fetchTeacherServicesUseCase: locator()));
locator.registerFactory(
      () => GetTeacherPortofolioCubit(fetchTeacherPortofolioUseCase: locator()));
locator.registerFactory(
      () => GetBalanceCubit(fetchBalanceUseCase: locator()));
locator.registerFactory(
      () => GetTeacherStatCubit(fetchTeacherStatUseCase : locator()));
locator.registerFactory(
      () => GetPortofolioDetailsBloc(portofolioDetailsUseCase : locator()));
locator.registerFactory(
      () => GetStudentStatCubit(fetchStudentStatUseCase : locator()));
locator.registerFactory(
      () => GetNotificationCubit(getNotificationUseCase : locator()));
locator.registerFactory(
      () => GetTeacherReviewsCubit(fetchReviewsUseCase : locator()));
locator.registerFactory(
      () => GetFaqBloc(fetchFaqUseCase : locator()));


  //use cases
  locator.registerLazySingleton(
      () => GetCategoriesUseCase(categoriesRepo: locator()));
  locator
      .registerLazySingleton(() => GetCitiessUseCase(countriesRepo: locator()));
  locator.registerLazySingleton(
      () => GetCountriesUseCase(countriesRepo: locator()));
  locator.registerLazySingleton(
      () => GetTeacherDetailsUseCase(teacherDetailsRepo: locator()));
  locator.registerLazySingleton(
      () => SearchTeachersUseCase(searchTeachersRepo: locator()));
  locator.registerLazySingleton(() => RefreshAccountUseCase());
  locator.registerLazySingleton(
      () => CourseDetailsUseCase(courseDetailsRepo: locator()));
  locator.registerLazySingleton(
      () => SearchCoursesUseCase(searchCoursesRepo: locator()));
  locator.registerLazySingleton(
      () => SearchServicesUseCase(searchServicesRepo: locator()));
  locator.registerLazySingleton(
      () => ServiceDetailsUseCase(servicesDetailsRepo: locator()));
  locator.registerLazySingleton(() => SignupUseCase(accountsRepo: locator()));
  locator.registerLazySingleton(
      () => LoginUseCase(accountsRepo: locator(), authRepo: locator()));
  locator.registerLazySingleton(() => FetchUserDataUseCase(
        accountsRepo: locator(),
      ));
  locator.registerLazySingleton(() =>
      SubmitStudentInfoUseCase(accountsRepo: locator(), authRepo: locator()));
  locator.registerLazySingleton(() => UploadPictureUseCase(
        accountsRepo: locator(),
      ));
  locator.registerLazySingleton(() =>
      ActivateAccountUseCase(accountsRepo: locator(), authRepo: locator()));
  locator.registerLazySingleton(() => ResendActivationCodeUseCase(
        accountsRepo: locator(),
      ));
  locator.registerLazySingleton(() => ChangePasswordUseCase(
        changePasswordRepo: locator(),
      ));
  locator.registerLazySingleton(
    () => SubmitTeacherInfoUseCase(
      accountsRepo: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => SubmitTeacherExtraInfoUseCase(
      accountsRepo: locator(),
      authRepo: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => SubmitInstituteInfoUseCase(
      accountsRepo: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => SubmitInstituteExtraInfoUseCase(
      authRepo: locator(),
      accountsRepo: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => SubmitLocationUseCase(locationRepo: locator(), authRepo: locator()),
  );
  locator.registerLazySingleton(
    () => AnswerConditionsUseCase(conditionsRepo: locator(),authRepo: locator()),
  );
   locator.registerLazySingleton(
    () => SearchInstitutesUseCase(searchInstitutesRepo : locator(),),
  );
   locator.registerLazySingleton(
    () => GetInstituteDetailsUseCase(instituteDetailsRepo  : locator(),),
  );
   locator.registerLazySingleton(
    () => FetchTeacherCoursesUseCase(teacherCoursesRepo  : locator(),),
  );
  locator.registerLazySingleton(
    () => FetchTeacherServicesUseCase(teacherServicesRepo  : locator(),),
  );
  locator.registerLazySingleton(
    () => FetchTeacherPortofolioUseCase(teacherPortofolioRepo  : locator(),),
  );
  locator.registerLazySingleton(
    () => FetchBalanceUseCase(teacherBalanceRepo  : locator(),),
  );
 locator.registerLazySingleton(
    () => FetchTeacherStatUseCase(teacherStatRepo  : locator(),),
  );
locator.registerLazySingleton(
    () => PortofolioDetailsUseCase(portofolioDetailsRepo  : locator(),),
  );
locator.registerLazySingleton(
    () => FetchStudentStatUseCase(statRepo  : locator(),),
  );
  locator.registerLazySingleton(
    () => GetNotificationUseCase(notificationRepo  : locator(),),
  );
locator.registerLazySingleton(
    () => FetchReviewsUseCase(teacherReviewsRepo  : locator(),),
  );
locator.registerLazySingleton(
    () => FetchFaqUseCase(assistenceRepo  : locator(),),
  );

  //repositories
  locator.registerLazySingleton<CategoriesRepo>(
      () => CategoriesRepoImpl(categoriesProvider: locator()));
  locator.registerLazySingleton<LocationRepo>(
      () => LocationRepoImpl(locationProvider: locator()));
  locator.registerLazySingleton<TeacherDetailsRepo>(
      () => TeacherDetailsRepoImpl(teacherDetailsDataProvider: locator()));
  locator.registerLazySingleton<SearchTeachersRepo>(
      () => SearchTeachersRepoImp(searchTeacherDataProvider: locator()));
  locator.registerLazySingleton<LocalizeApp>(() => LocalizeAppImpl());
  locator.registerLazySingleton<CourseDetailsRepo>(
      () => CourseDetailsRepoImpl(courseDetailsDataProvider: locator()));
  locator.registerLazySingleton<SearchCoursesRepo>(
      () => SearchCoursesRepoImp(searchCoursesDataProvider: locator()));
  locator.registerLazySingleton<SearchServicesRepo>(
      () => SearchServicesRepoImp(searchServicesDataProvider: locator()));
  locator.registerLazySingleton<ServicesDetailsRepo>(
      () => ServiceDetailsRepoImpl(serviceDetailsDataProvider: locator()));
  locator.registerLazySingleton<AccountsRepo>(
      () => AccountsRepoImpl(accountsDataProvider: locator()));
  locator.registerLazySingleton<AuthRepo>(() => AuthRepoImpl());
  locator.registerLazySingleton<ChangePasswordRepo>(
      () => ChangePasswordRepoImpl(changePasswordProvider: locator()));
 locator.registerLazySingleton<ConditionsRepo>(
      () => ConditionsRepoImpl(conditionsDataProvider : locator()));
locator.registerLazySingleton<SearchInstitutesRepo>(
      () => SearchInstitutesRepoImp(searchInstitutesDataProvider : locator()));
locator.registerLazySingleton<InstituteDetailsRepo>(
      () =>  InstituteDetailsRepoImpl(instituteDetailsDataProvider  : locator()));
locator.registerLazySingleton<TeacherCoursesRepo>(
      () =>  TeacherCoursesRepoImpl(teacherCoursesDataSource  : locator()));
locator.registerLazySingleton<TeacherServicesRepo>(
      () =>  TeacherServicesRepoImpl(teacherServicesDataSource  : locator()));
locator.registerLazySingleton<TeacherPortofolioRepo>(
      () =>  TeacherPortofolioRepoImpl(teacherPortofoliosDataSource  : locator()));
locator.registerLazySingleton<TeacherBalanceRepo>(
      () =>  TeacherBalanceRepoImp(teacherBalanceDataSource  : locator()));
locator.registerLazySingleton<StatRepo>(
      () =>  StatRepoImp(teacherStatDataSource  : locator()));
locator.registerLazySingleton<PortofolioDetailsRepo>(
      () =>  PortofolioDetailsRepoImpl(portofolioDetailsDataProvider  : locator()));
locator.registerLazySingleton<NotificationRepo>(
      () =>  NotificationRepoImpl(notificationDataProvider  : locator()));
locator.registerLazySingleton<TeacherReviewsRepo>(
      () =>  TeacherReviewsRepoImpl(teacherReviewDataSource  : locator()));
locator.registerLazySingleton<AssistenceRepo>(
      () =>  AssistenceRepoImpl(assistenceDataSource  : locator()));



  //data sources
  locator.registerLazySingleton<CategoriesProvider>(
      () => CategoriesProviderWithDio(client: locator()));
  locator.registerLazySingleton<LocationProvider>(
      () => LocationProviderWithDio(client: locator()));
  locator.registerLazySingleton<TeacherDetailsDataProvider>(
      () => TeacherDetailsDataProviderWithDio(client: locator()));
  locator.registerLazySingleton<SearchTeacherDataProvider>(
      () => SearchTeacherDataProviderWithDio(client: locator()));
  locator.registerLazySingleton<CourseDetailsDataProvider>(
      () => CourseDetailsDataProviderWithDio(client: locator()));
  locator.registerLazySingleton<SearchCoursesDataProvider>(
      () => SearchCoursesDataProviderWithDio(client: locator()));
  locator.registerLazySingleton<SearchServicesDataProvider>(
      () => SearchServicesDataProviderWithDio(client: locator()));
  locator.registerLazySingleton<ServiceDetailsDataProvider>(
      () => ServiceDetailsDataProviderWithDio(client: locator()));
  locator.registerLazySingleton<AccountsDataProvider>(
      () => AccountsDataProviderWithDio(client: locator()));
  locator.registerLazySingleton<ChangePasswordProvider>(
      () => ChangePasswordProviderWithDio(client: locator()));
locator.registerLazySingleton<ConditionsDataProvider>(
      () => ConditionsDataProviderWithDio(client: locator()));
locator.registerLazySingleton<SearchInstitutesDataProvider>(
      () => SearchInstitutesDataProviderWithDio(client: locator()));
locator.registerLazySingleton<InstituteDetailsDataProvider>(
      () => InstituteDetailsDataProviderWithDio(client: locator()));
locator.registerLazySingleton<TeacherCoursesDataSource>(
      () => TeacherCoursesDataSourceWithDio(client: locator()));
locator.registerLazySingleton<TeacherServicesDataSource>(
      () => TeacherServicesDataSourceWithDio(client: locator()));
locator.registerLazySingleton<TeacherPortofoliosDataSource>(
      () => TeacherPortofoliosDataSourceWithDio(client: locator()));
locator.registerLazySingleton<TeacherBalanceDataSource>(
      () => TeacherBalanceDataSourceWithDio(client: locator()));
locator.registerLazySingleton<TeacherStatDataSource>(
      () => TeacherStatDataSourceWithDio(client: locator()));
locator.registerLazySingleton<PortofolioDetailsDataProvider>(
      () => PortofolioDetailsDataProviderWithDio(client: locator()));
locator.registerLazySingleton<NotificationDataProvider>(
      () => NotificationDataProviderWithDio(client: locator()));
locator.registerLazySingleton<TeacherReviewDataSource>(
      () => TeacherReviewDataSourceWithDio(client: locator()));
locator.registerLazySingleton<AssistenceDataSource>(
      () => AssistenceDataSourceWithDio(client: locator()));


  //core
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      internetConnectionChecker: locator(),
    ),
  );

//external
  locator.registerLazySingleton<BaseApiService>(() => NetworkServiceDio());
  locator.registerLazySingleton(() => InternetConnectionChecker());
}
