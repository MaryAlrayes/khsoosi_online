
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return NetworkErrorFailure(
            responseCode: ResponseCode.SUCCESS,
            message: ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return NetworkErrorFailure(
            responseCode: ResponseCode.NO_CONTENT,
            message: ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return NetworkErrorFailure(
            responseCode: ResponseCode.BAD_REQUEST,
            message: ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return NetworkErrorFailure(
            responseCode: ResponseCode.FORBIDDEN,
            message: ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTORISED:
        return NetworkErrorFailure(
            responseCode: ResponseCode.UNAUTORISED,
            message: ResponseMessage.UNAUTORISED);
      case DataSource.NOT_FOUND:
        return NetworkErrorFailure(
            responseCode: ResponseCode.NOT_FOUND,
            message: ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return NetworkErrorFailure(
            responseCode: ResponseCode.INTERNAL_SERVER_ERROR,
            message: ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return NetworkErrorFailure(
            responseCode: ResponseCode.CONNECT_TIMEOUT,
            message: ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return NetworkErrorFailure(
            responseCode: ResponseCode.CANCEL, message: ResponseMessage.CANCEL);
      case DataSource.RECIEVE_TIMEOUT:
        return NetworkErrorFailure(
            responseCode: ResponseCode.RECIEVE_TIMEOUT,
            message: ResponseMessage.RECIEVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return NetworkErrorFailure(
            responseCode: ResponseCode.SEND_TIMEOUT,
            message: ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return NetworkErrorFailure(
            responseCode: ResponseCode.CACHE_ERROR,
            message: ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return OfflineFailure();
      case DataSource.DEFAULT:
        return NetworkErrorFailure(
            responseCode: ResponseCode.DEFAULT,
            message: ResponseMessage.DEFAULT);

    }
  }
}


class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST =
      400; // NetworkErrorFailure, API rejected request
  static const int UNAUTORISED =
      401; // NetworkErrorFailure, user is not authorised
  static const int FORBIDDEN =
      403; //  NetworkErrorFailure, API rejected request
  static const int INTERNAL_SERVER_ERROR =
      500; // NetworkErrorFailure, crash in server side
  static const int NOT_FOUND = 404; // NetworkErrorFailure, not found

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}



class ResponseMessage {
  static const String SUCCESS = AppStrings.success; // success with data
  static const String NO_CONTENT =
      AppStrings.success; // success with no data (no content)
  static const String BAD_REQUEST = AppStrings
      .strBadRequestError; // NetworkErrorFailure, API rejected request
  static const String UNAUTORISED = AppStrings
      .strUnauthorizedError; // NetworkErrorFailure, user is not authorised
  static const String FORBIDDEN = AppStrings
      .strForbiddenError; //  NetworkErrorFailure, API rejected request
  static const String INTERNAL_SERVER_ERROR = AppStrings
      .strInternalServerError; // NetworkErrorFailure, crash in server side
  static const String NOT_FOUND =
      AppStrings.strNotFoundError; // NetworkErrorFailure, crash in server side

  // local status code
  static const String CONNECT_TIMEOUT = AppStrings.strTimeoutError;
  static const String CANCEL = AppStrings.strDefaultError;
  static const String RECIEVE_TIMEOUT = AppStrings.strTimeoutError;
  static const String SEND_TIMEOUT = AppStrings.strTimeoutError;
  static const String CACHE_ERROR = AppStrings.strCacheError;
  static const String NO_INTERNET_CONNECTION = AppStrings.strNoInternetError;
  static const String DEFAULT = AppStrings.strDefaultError;
}
