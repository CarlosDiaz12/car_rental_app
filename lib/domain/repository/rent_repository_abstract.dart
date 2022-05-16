import 'package:car_rental_app/domain/dto/is_available_for_rent_dto.dart';
import 'package:car_rental_app/domain/models/rent.dart';
import 'package:car_rental_app/domain/repository/base_repository_abstract.dart';
import 'package:dartz/dartz.dart';

abstract class RentRepositoryAbstract extends BaseRepositoryAbstract<Rent> {
  Future<Either<Exception, bool>> isAvailableForRent(IsAvailableForRentDto dto);
}
