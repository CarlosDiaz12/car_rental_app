import 'package:dartz/dartz.dart';

abstract class BaseRepositoryAbstract<T> {
  Future<Either<Exception, List<T>>> getAll();
  Future<Either<Exception, List<bool>>> create(T object);
  Future<Either<Exception, List<bool>>> update(T object);
  Future<Either<Exception, List<bool>>> delete(int id);
}
