import 'package:dio/dio.dart';
import 'package:login_cubit_example/login/model/login_request_model.dart';
import 'package:login_cubit_example/login/model/token_model.dart';

abstract class ILoginService {
  final Dio dio;

  ILoginService(this.dio);

  final String loginPath = ILoginServicePath.login.rawValue;

  Future<Token?> postUserLogin(LoginRequestModel loginRequestModel);
}

enum ILoginServicePath {
  login,
}

extension ILoginServicePAthExtension on ILoginServicePath {
  String get rawValue {
    switch (this) {
      case ILoginServicePath.login:
        return '/login';
    }
  }
}
