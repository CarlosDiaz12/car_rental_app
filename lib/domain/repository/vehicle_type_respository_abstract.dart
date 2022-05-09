import 'package:dartz/dartz.dart';
import 'package:flutter_movies_app/domain/models/vehicle_type.dart';

abstract class VehicleTypeRepositoryAbstract {
  Future<Either<Exception, List<VehicleType>>> getAll();
}
