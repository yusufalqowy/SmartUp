import 'package:smartup/core/values/urls.dart';
import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/core/services/dio_client.dart';
import 'package:smartup/data/user/model/register_user_request.dart';
import 'package:smartup/data/user/model/user_response.dart';

abstract class UserApiService{
  Future<NetworkResponse<UserData>> getUserByEmail({required String email});
  Future<NetworkResponse<UserData>> registerUser({required UserBody requestBody});
  Future<NetworkResponse<UserData>> updateUser({required UserBody requestBody});
}

class UserApiServiceImpl implements UserApiService{
  final DioClient dioClient;
  const UserApiServiceImpl({required this.dioClient});
  
  @override
  Future<NetworkResponse<UserData>> getUserByEmail({required String email}) async{
    try{
      var queryParam = {
        "email":email
      };
      var response = await dioClient.get(Urls.users, queryParameters: queryParam);
      if(response.statusCode == 200){
        var userResponse = UserResponse.fromJson(response.data);
        if(userResponse.status == 0){
          return NetworkResponse.error(message: userResponse.message);
        }
        return NetworkResponse.success(userResponse.data);
      }else{
        return NetworkResponse.error(message: response.statusMessage);
      }
    }catch(e){
      return NetworkResponse.error(message: e.toString());
    }
  }

  @override
  Future<NetworkResponse<UserData>> registerUser({required UserBody requestBody}) async {
    try{
      var response = await dioClient.post(Urls.userRegister, body: requestBody.toMap());
      if(response.statusCode == 200){
        var userResponse = UserResponse.fromJson(response.data);
        if(userResponse.status == 0){
          return NetworkResponse.error(message: userResponse.message);
        }
        return NetworkResponse.success(userResponse.data);
      }else{
        return NetworkResponse.error(message: response.statusMessage);
      }
    }catch(e){
      return NetworkResponse.error(message: e.toString());
    }
  }

  @override
  Future<NetworkResponse<UserData>> updateUser({required UserBody requestBody}) async {
    try{
      var response = await dioClient.post(Urls.userRegister, body: requestBody);
      if(response.statusCode == 200){
        var userResponse = UserResponse.fromJson(response.data);
        if(userResponse.status == 0){
          return NetworkResponse.error(message: userResponse.message);
        }
        return NetworkResponse.success(userResponse.data);
      }else{
        return NetworkResponse.error(message: response.statusMessage);
      }
    }catch(e){
      return NetworkResponse.error(message: e.toString());
    }
  }

}