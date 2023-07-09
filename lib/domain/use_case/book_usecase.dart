import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/user/model/register_user_request.dart';
import 'package:smartup/data/user/model/user_response.dart';
import 'package:smartup/domain/repository/user_repository.dart';

abstract class UserUseCase {
  Future<NetworkResponse<UserData>> getUserByEmail({required String email});

  Future<NetworkResponse<UserData>> registerUser({required UserBody requestBody});

  Future<NetworkResponse<UserData>> updateUser({required UserBody requestBody});
}

class UserUseCaseImpl implements UserUseCase{
  final UserRepository userRepository;
  const UserUseCaseImpl({required this.userRepository});

  @override
  Future<NetworkResponse<UserData>> getUserByEmail({required String email}) async => userRepository.getUserByEmail(email: email);

  @override
  Future<NetworkResponse<UserData>> registerUser({required UserBody requestBody}) async => userRepository.registerUser(requestBody: requestBody);

  @override
  Future<NetworkResponse<UserData>> updateUser({required UserBody requestBody}) async => userRepository.updateUser(requestBody: requestBody);

}
