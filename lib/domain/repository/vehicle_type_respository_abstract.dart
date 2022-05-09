import 'package:dartz/dartz.dart';
import 'package:car_rental_app/domain/models/vehicle_type.dart';

abstract class VehicleTypeRepositoryAbstract {
  Future<Either<Exception, List<VehicleType>>> getAll();
}
