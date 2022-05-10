import 'package:car_rental_app/domain/models/brand.dart';
import 'package:dartz/dartz.dart';

abstract class BrandRepositoryAbstract {
  Future<Either<Exception, List<Brand>>> getAll();
  Future<Either<Exception, bool>> create(Brand object);
  Future<Either<Exception, bool>> update(Brand object);
  Future<Either<Exception, bool>> delete(int id);
}
