import 'package:car_rental_app/data/repository/brand_repository.dart';
import 'package:car_rental_app/data/repository/fuel_type_repository.dart';
import 'package:car_rental_app/data/repository/model_repository.dart';
import 'package:car_rental_app/data/repository/vehicle_repository.dart';
import 'package:car_rental_app/domain/repository/brand_repository_abstract.dart';
import 'package:car_rental_app/domain/repository/fuel_type_repository_abstract.dart';
import 'package:car_rental_app/domain/repository/model_repository_abstract.dart';
import 'package:car_rental_app/domain/repository/vehicle_repository_abstract.dart';
import 'package:car_rental_app/domain/repository/vehicle_type_respository_abstract.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:car_rental_app/core/constants/remote_constants.dart';
import 'package:car_rental_app/data/repository/vehicle_type_repository.dart';

class DependencyInjection {
  static List<SingleChildWidget> get providers => _providers;
  DependencyInjection._();
  static List<SingleChildWidget> _providers = [];
  static final List<SingleChildWidget> _networkProviders = [
    Provider.value(value: _initHttpClient()),
    /*
    example:
        ProxyProvider<Dio, ExampleService>(
      update: (context, dioClient, _) => ExampleService(
        client: dioClient,
      ),
    ),
     */
  ];

  static final List<SingleChildWidget> _repositoryProviders = [
    ProxyProvider<Dio, VehicleTypeRepositoryAbstract>(
      update: (context, dioClient, _) => VehicleTypeRepository(
        client: dioClient,
      ),
    ),
    ProxyProvider<Dio, BrandRepositoryAbstract>(
      update: (context, dioClient, _) => BrandRepository(
        client: dioClient,
      ),
    ),
    ProxyProvider<Dio, ModelRepositoryAbstract>(
      update: (context, dioClient, _) => ModelRepository(
        client: dioClient,
      ),
    ),
    ProxyProvider<Dio, FuelTypeRepositoryAbstract>(
      update: (context, dioClient, _) => FuelTypeRepository(
        client: dioClient,
      ),
    ),
    ProxyProvider<Dio, VehicleRepositoryAbstract>(
      update: (context, dioClient, _) => VehicleRepository(
        client: dioClient,
      ),
    ),
    /*Provider.value(value: ExampleRepository),*/

    /*
    example:
        ProxyProvider<Dio, ExampleService>(
      update: (context, dioClient, _) => ExampleService(
        client: dioClient,
      ),
    ),
     */
  ];
/*
  static final List<SingleChildWidget> _uiProviders = [
    /*
    example:
        ProxyProvider<Dio, ExampleService>(
      update: (context, dioClient, _) => ExampleService(
        client: dioClient,
      ),
    ),
     */
  ];
*/
  static Future<void> setup() async {
    _providers = [..._networkProviders, ..._repositoryProviders];
  }

  static Dio _initHttpClient() {
    var client = Dio(
      BaseOptions(
        baseUrl: RemoteConstants.API_URL_BASE,
      ),
    );
    return client;
  }
}
