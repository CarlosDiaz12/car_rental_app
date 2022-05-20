import 'package:car_rental_app/data/remote/response/get_all_vehicle_response.dart';
import 'package:car_rental_app/domain/models/vehicle.dart';
import 'package:car_rental_app/domain/repository/vehicle_repository_abstract.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/error/exceptions.dart';

class VehicleRepository extends VehicleRepositoryAbstract {
  final Dio _client;
  VehicleRepository({required Dio client}) : _client = client;
  @override
  Future<Either<Exception, List<Vehicle>>> getAll() async {
    try {
      var request = await _client.get(
        '/vehicle',
      );
      var response = GetAllVehicleResponse.fromMap(request.data);
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
  Future<Either<Exception, bool>> create(Vehicle object) async {
    try {
      object.id = 0;
      var request = await _client.post(
        '/vehicle',
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
        '/vehicle',
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
  Future<Either<Exception, bool>> update(Vehicle object) async {
    try {
      object.brand = null;
      object.vehicleType = null;
      object.model = null;
      object.fuelType = null;
      var request = await _client.put(
        '/vehicle',
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
