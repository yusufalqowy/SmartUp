import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/user/data_source/remote/user_api_service.dart';
import 'package:smartup/data/user/model/register_user_request.dart';
import 'package:smartup/data/user/model/user_response.dart';
import 'package:smartup/domain/user/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApiService userApiService;

  const UserRepositoryImpl({required this.userApiService});

  @override
  Future<NetworkResponse<UserData>> getUserByEmail({required String email}) async => await userApiService.getUserByEmail(email: email);

  @override
  Future<NetworkResponse<UserData>> registerUser({required UserBody requestBody}) async => await userApiService.registerUser(requestBody: requestBody);

  @override
  Future<NetworkResponse<UserData>> updateUser({required UserBody requestBody}) async => await userApiService.updateUser(requestBody: requestBody);
}
