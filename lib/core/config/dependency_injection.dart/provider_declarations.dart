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
    ProxyProvider<Dio, VehicleTypeRepository>(
      update: (context, dioClient, _) => VehicleTypeRepository(
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
