import 'package:bloc_demo/model/user_post_response.dart';
import 'package:bloc_demo/model/user.dart';
import 'package:bloc_demo/model/user_put_response.dart';
import 'package:bloc_demo/request_param/user_param.dart';
import 'package:dio/dio.dart';
import 'package:g_json/g_json.dart';

class HomeRepository {
  final baseUrl = 'https://reqres.in/api';
  final dio = Dio();

  Future<User> getUser({required String id}) async {
    Response userData = await dio.get(baseUrl + '/users/$id');

    User user = User.fromJson(JSON(userData.data));

    return user;
  }

  Future<UserPostResponse> postUser({required UserParam userParam}) async {
    Response userPostResponseData =
        await dio.post(baseUrl + '/users', data: userParam.toJson());

    UserPostResponse userPostResponse =
        UserPostResponse.fromJson(JSON(userPostResponseData.data));

    return userPostResponse;
  }

  Future<UserPutResponse> putUser({required UserParam userParam}) async {
    Response userPutResponseData =
        await dio.put(baseUrl + '/users', data: userParam.toJson());

    UserPutResponse userPutResponse =
        UserPutResponse.fromJson(JSON(userPutResponseData.data));

    return userPutResponse;
  }
}
