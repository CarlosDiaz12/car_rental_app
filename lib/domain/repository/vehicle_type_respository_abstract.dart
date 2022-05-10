import 'package:dartz/dartz.dart';
import 'package:car_rental_app/domain/models/vehicle_type.dart';

abstract class VehicleTypeRepositoryAbstract {
  Future<Either<Exception, List<VehicleType>>> getAll();
  Future<Either<Exception, bool>> create(VehicleType object);
  Future<Either<Exception, bool>> update(VehicleType object);
  Future<Either<Exception, bool>> delete(int id);
}
