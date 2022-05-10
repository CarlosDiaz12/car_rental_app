import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:car_rental_app/core/error/exceptions.dart';
import 'package:car_rental_app/data/remote/response/get_all_vehicle_type_response.dart';
import 'package:car_rental_app/domain/models/vehicle_type.dart';
import 'package:car_rental_app/domain/repository/vehicle_type_respository_abstract.dart';

class VehicleTypeRepository extends VehicleTypeRepositoryAbstract {
  final Dio _client;
  VehicleTypeRepository({required Dio client}) : _client = client;

  @override
  Future<Either<Exception, List<VehicleType>>> getAll() async {
    try {
      var request = await _client.get(
        '/vehicleType',
      );
      var response = GetAllVehicleTypeResponse.fromMap(request.data);
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
  Future<Either<Exception, bool>> create(VehicleType object) async {
    try {
      object.id = 0;
      var request = await _client.post(
        '/vehicleType',
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
  Future<Either<Exception, bool>> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, bool>> update(VehicleType object) async {
    try {
      var request = await _client.put(
        '/vehicleType',
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
