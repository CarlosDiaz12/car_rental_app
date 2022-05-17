import 'package:car_rental_app/data/remote/response/login_user_response.dart';
import 'package:car_rental_app/domain/dto/login_dto.dart';
import 'package:car_rental_app/domain/models/user.dart';
import 'package:car_rental_app/domain/repository/auth_repository_abstract.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/error/exceptions.dart';

class AuthRepository extends AuthRepositoryAbstract {
  final Dio _client;
  AuthRepository({required Dio client}) : _client = client;
  @override
  Future<Either<Exception, User>> login(LoginDto dto) async {
    try {
      var request = await _client.post(
        '/auth/login',
        data: dto.toMap(),
      );
      var response = LoginUserResponse.fromMap(request.data);
      if (response.success!) {
        return Right(response.data!);
      }

      return Left(LoginFailedException());
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return Left(NotFoundException());
      }
      if (e.response?.statusCode == 401) {
        return Left(NotAuthorizedException());
      }
      return Left(ServerException(null, e.response?.statusCode ?? 500));
    } catch (e) {
      return Left(UnknownErrorException('Error inesperado: ${e.toString()}'));
    }
  }
}
