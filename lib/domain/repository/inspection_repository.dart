import 'package:car_rental_app/domain/dto/check_vehicle_availability_dto.dart';
import 'package:car_rental_app/domain/models/inspection.dart';
import 'package:car_rental_app/domain/repository/base_repository_abstract.dart';
import 'package:dartz/dartz.dart';

abstract class InspectionRepositoryAbstract
    extends BaseRepositoryAbstract<Inspection> {
  Future<Either<Exception, bool>> checkVehicleAvailability(
      CheckVehicleAvailabilityDto object);
}
