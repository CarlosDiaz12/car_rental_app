import 'package:car_rental_app/data/remote/response/get_all_employee_response.dart';
import 'package:car_rental_app/domain/models/employee.dart';
import 'package:car_rental_app/domain/repository/employee_respository_abstract.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/error/exceptions.dart';

class EmployeeRepository extends EmployeeRepositoryAbstract {
  final Dio _client;
  EmployeeRepository({required Dio client}) : _client = client;
  @override
  Future<Either<Exception, List<Employee>>> getAll() async {
    try {
      var request = await _client.get(
        '/employee',
      );
      var response = GetAllEmployeeResponse.fromMap(request.data);
      return Right(response.data!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return Left(NotFoundException());
      }
      if (e.response?.statusCode == 401) {
        return Left(NotAuthorizedException());
      }
      return Left(ServerException(null, e.response?.statusCode ?? 500));
    } catch (e) {
      return Left(UnknownErrorException('Error inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, bool>> create(Employee object) async {
    try {
      object.id = 0;
      var request = await _client.post(
        '/employee',
        data: object.toMap(),
      );
      var response = request.data['data'];
      return Right(response);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return Left(NotFoundException());
      }
      if (e.response?.statusCode == 401) {
        return Left(NotAuthorizedException());
      }
      return Left(ServerException(null, e.response?.statusCode ?? 500));
    } catch (e) {
      return Left(UnknownErrorException('Error inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, bool>> delete(int id) async {
    try {
      var request = await _client.delete(
        '/employee',
        queryParameters: {'id': id},
      );
      var response = request.data['data'];
      return Right(response);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return Left(NotFoundException());
      }
      if (e.response?.statusCode == 401) {
        return Left(NotAuthorizedException());
      }
      return Left(ServerException(null, e.response?.statusCode ?? 500));
    } catch (e) {
      return Left(UnknownErrorException('Error inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, bool>> update(Employee object) async {
    try {
      var request = await _client.put(
        '/employee',
        data: object.toMap(),
      );
      var response = request.data['data'];
      return Right(response);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return Left(NotFoundException());
      }
      if (e.response?.statusCode == 401) {
        return Left(NotAuthorizedException());
      }
      return Left(ServerException(null, e.response?.statusCode ?? 500));
    } catch (e) {
      return Left(UnknownErrorException('Error inesperado: ${e.toString()}'));
    }
  }
}
