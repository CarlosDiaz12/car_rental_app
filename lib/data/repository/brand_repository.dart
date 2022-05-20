import 'package:car_rental_app/core/error/exceptions.dart';
import 'package:car_rental_app/data/remote/response/get_all_brand_response.dart';
import 'package:car_rental_app/domain/models/brand.dart';
import 'package:car_rental_app/domain/repository/brand_repository_abstract.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class BrandRepository extends BrandRepositoryAbstract {
  final Dio _client;
  BrandRepository({required Dio client}) : _client = client;
  @override
  Future<Either<Exception, List<Brand>>> getAll() async {
    try {
      var request = await _client.get(
        '/brand',
      );
      var response = GetAllBrandResponse.fromMap(request.data);
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
  Future<Either<Exception, bool>> create(Brand object) async {
    try {
      object.id = 0;
      var request = await _client.post(
        '/brand',
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
        '/brand',
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
  Future<Either<Exception, bool>> update(Brand object) async {
    try {
      var request = await _client.put(
        '/brand',
        data: object.toMap(),
      );

      var response = request.data['data'];
      if (request.data['success'] == false) {
        return Left(UnknownErrorException(request.data['errorMessage']));
      }
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
