import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/user/model/register_user_request.dart';
import 'package:smartup/data/user/model/user_response.dart';

abstract class UserRepository {
  Future<NetworkResponse<UserData>> getUserByEmail({required String email});

  Future<NetworkResponse<UserData>> registerUser({required UserBody requestBody});

  Future<NetworkResponse<UserData>> updateUser({required UserBody requestBody});
}
