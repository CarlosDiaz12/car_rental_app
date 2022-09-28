import 'package:car_rental_app/data/remote/response/get_all_fuel_type_response.dart';
import 'package:car_rental_app/domain/models/fuel_type.dart';
import 'package:car_rental_app/domain/repository/fuel_type_repository_abstract.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/error/exceptions.dart';

class FuelTypeRepository extends FuelTypeRepositoryAbstract {
  final Dio _client;
  FuelTypeRepository({required Dio client}) : _client = client;
  @override
  Future<Either<Exception, List<FuelType>>> getAll() async {
    try {
      var request = await _client.get(
        '/fueltype',
      );
      var response = GetAllFuelTypeResponse.fromMap(request.data);
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
  Future<Either<Exception, bool>> create(FuelType object) async {
    try {
      var request = await _client.post(
        '/fueltype',
        data: object.toMap(),
      );
      var response = request.data['data'];
      return Right(response);
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return Left(UnknownErrorException(e.response?.data['errorMessage']));
      }
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
        '/fueltype',
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
  Future<Either<Exception, bool>> update(FuelType object) async {
    try {
      var request = await _client.put(
        '/fueltype',
        data: object.toMap(),
      );
      var response = request.data['data'];
      return Right(response);
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return Left(UnknownErrorException(e.response?.data['errorMessage']));
      }
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
