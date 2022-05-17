import 'package:car_rental_app/domain/dto/login_dto.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepositoryAbstract {
  Future<Either<Exception, bool>> login(LoginDto dto);
}
