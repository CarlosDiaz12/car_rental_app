import 'package:dartz/dartz.dart';

abstract class BaseRepositoryAbstract<T> {
  Future<Either<Exception, List<T>>> getAll();
  Future<Either<Exception, bool>> create(T object);
  Future<Either<Exception, bool>> update(T object);
  Future<Either<Exception, bool>> delete(int id);
}
