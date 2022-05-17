import 'package:car_rental_app/domain/dto/login_dto.dart';
import 'package:car_rental_app/domain/models/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepositoryAbstract {
  Future<Either<Exception, User>> login(LoginDto dto);
}
