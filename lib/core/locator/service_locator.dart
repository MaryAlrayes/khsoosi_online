import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/api_service/network_service_dio.dart';
import 'package:khosousi_online/core/network/check_internet.dart';
import 'package:khosousi_online/features/courses_services_details/data/data%20providers/service_details_data_provider.dart';
import 'package:khosousi_online/features/courses_services_details/data/repositories/service_details_repo_impl.dart';
import 'package:khosousi_online/features/courses_services_details/domain/repositories/course_details_repo.dart';
import 'package:khosousi_online/features/courses_services_details/domain/repositories/services_details_repo.dart';
import 'package:khosousi_online/features/courses_services_details/domain/use%20cases/course_details_use_case.dart';
import 'package:khosousi_online/features/courses_services_details/domain/use%20cases/service_details_use_case.dart';
import 'package:khosousi_online/features/courses_services_details/presentation/courses/bloc/get_course_details_bloc.dart';
import 'package:khosousi_online/features/courses_services_details/presentation/services/bloc/get_services_details_bloc.dart';
import 'package:khosousi_online/features/localization/cubit/lacalization_cubit.dart';
import 'package:khosousi_online/features/localization/localize_app.dart';
import 'package:khosousi_online/features/localization/localize_app_impl.dart';
import 'package:khosousi_online/features/refresh/domain/use_cases/refresh_account_use_case.dart';
import 'package:khosousi_online/features/refresh/presentation/cubit/refresh_account_cubit.dart';
import 'package:khosousi_online/features/search/data/data%20providers/search_courses_data_provider.dart';
import 'package:khosousi_online/features/search/data/data%20providers/search_services_data_provider.dart';
import 'package:khosousi_online/features/search/data/data%20providers/search_teachers_data_provider.dart';
import 'package:khosousi_online/features/search/data/repositories/search_courses_repo_impl.dart';
import 'package:khosousi_online/features/search/data/repositories/search_services_repo_impl.dart';
import 'package:khosousi_online/features/search/data/repositories/search_teacher_repo_impl.dart';
import 'package:khosousi_online/features/search/domain/repositories/search_courses_repo.dart';
import 'package:khosousi_online/features/search/domain/repositories/search_services_repo.dart';
import 'package:khosousi_online/features/search/domain/repositories/search_teachers_repo.dart';
import 'package:khosousi_online/features/search/domain/use%20cases/search_courses_use_case.dart';
import 'package:khosousi_online/features/search/domain/use%20cases/search_services_use_case.dart';
import 'package:khosousi_online/features/search/domain/use%20cases/search_teachers_use_case.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_stepper_cubit.dart';
import 'package:khosousi_online/features/search/presentation/search/cubit/search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/search_courses/bloc/get_courses_bloc.dart';
import 'package:khosousi_online/features/search/presentation/search_services/bloc/get_services_bloc.dart';
import 'package:khosousi_online/features/search/presentation/search_teacher/bloc/get_teachers_bloc.dart';
import 'package:khosousi_online/features/teacher_details/data/data%20provider/teacher_details_data_provider.dart';
import 'package:khosousi_online/features/teacher_details/data/repositories/teacher_details_repo_impl.dart';
import 'package:khosousi_online/features/teacher_details/domain/repositories/teacher_details_repo.dart';
import 'package:khosousi_online/features/teacher_details/domain/use%20cases/get_teaches_details_use_case.dart';
import 'package:khosousi_online/features/teacher_details/presentation/bloc/get_teacher_details_bloc.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/coords_cubit.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/get_cities_bloc.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/get_countries_bloc.dart';
import 'package:khosousi_online/shared_features/data/data%20provider/categories_provider.dart';
import 'package:khosousi_online/shared_features/data/data%20provider/location_provider.dart';
import 'package:khosousi_online/shared_features/data/repositories/categories_repo_impl.dart';
import 'package:khosousi_online/shared_features/data/repositories/location_repo_impl.dart';
import 'package:khosousi_online/shared_features/domain/repositories/categories_repo.dart';
import 'package:khosousi_online/shared_features/domain/repositories/location_repo.dart';
import 'package:khosousi_online/shared_features/domain/use_cases/get_categories_use_case.dart';
import 'package:khosousi_online/shared_features/domain/use_cases/get_cities_use_case.dart';
import 'package:khosousi_online/shared_features/domain/use_cases/get_countries_use_case.dart';
import '../../features/courses_services_details/data/data providers/course_details_data_provider.dart';
import '../../features/courses_services_details/data/repositories/course_details_repo_impl.dart';
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
locator
      .registerFactory(() => GetServicesDetailsBloc(serviceDetailsUseCase: locator()));



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


  //repositories
  locator.registerLazySingleton<CategoriesRepo>(
      () => CategoriesRepoImpl(categoriesProvider: locator()));
  locator.registerLazySingleton<LocationRepo>(
      () => LocationRepoImpl(countriesProvider: locator()));
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
      () => ServiceDetailsRepoImpl(serviceDetailsDataProvider : locator()));



  //data sources
  locator.registerLazySingleton<CategoriesProvider>(
      () => CategoriesProviderWithDio(client: locator()));
  locator.registerLazySingleton<CountriesProvider>(
      () => CountriesProviderWithDio(client: locator()));
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
