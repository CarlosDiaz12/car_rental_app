import 'package:dio/dio.dart';
import 'package:flutter_movies_app/core/constants/remote_constants.dart';
import 'package:flutter_movies_app/data/repository/example_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

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
    ProxyProvider<Dio, ExampleRepository>(
      update: (context, dioClient, _) => ExampleRepository(
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

  static Future<void> setup() async {
    _providers = [..._networkProviders, ..._repositoryProviders];
  }

  static Dio _initHttpClient() {
    var client = Dio(
      BaseOptions(
        // TODO: change later
        baseUrl: RemoteConstants.API_URL_BASE,
      ),
    );
    return client;
  }
}
