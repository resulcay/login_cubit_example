import 'dart:io';

import 'package:dio/dio.dart';
import 'package:login_cubit_example/login/model/login_request_model.dart';
import 'package:login_cubit_example/login/model/token_model.dart';
import 'package:login_cubit_example/login/service/i_login_service.dart';

class LoginService extends ILoginService {
  LoginService(Dio dio) : super(dio);

  @override
  Future<Token?> postUserLogin(LoginRequestModel loginRequestModel) async {
    final response = await dio.post(loginPath, data: loginRequestModel);

    if (response.statusCode == HttpStatus.ok) {
      return Token.fromJson(response.data);
    } else {
      return null;
    }
  }
}
