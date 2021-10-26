import 'package:bloc_demo/model/Coffee/coffee.dart';
import 'package:dio/dio.dart';
import 'package:g_json/g_json.dart';

class CoffeeRepository  {
  final baseUrl = 'https://api.sampleapis.com';
  final dio = Dio();

  Future<List<Coffee>> getCoffees({required String type}) async {
    print("getting");
    Response coffeeData = await dio.get(
      baseUrl + '/coffee/$type'
    );
    print(coffeeData.data);
    print(coffeeData.data.runtimeType);
    List<Coffee> coffees = (coffeeData.data as List).map((e) => Coffee.fromJson(e)).toList();
    return coffees;
  }

  // final baseUrl = 'https://reqres.in/api';
  // final dio = Dio();
  //
  // Future<User> getUser({required String id}) async {
  //   Response userData = await dio.get(baseUrl + '/users/$id');
  //
  //   User user = User.fromJson(JSON(userData.data));
  //
  //   return user;
  // }

}