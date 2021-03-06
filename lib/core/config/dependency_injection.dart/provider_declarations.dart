import 'package:car_rental_app/data/repository/auth_repository.dart';
import 'package:car_rental_app/data/repository/brand_repository.dart';
import 'package:car_rental_app/data/repository/employee_repository.dart';
import 'package:car_rental_app/data/repository/fuel_type_repository.dart';
import 'package:car_rental_app/data/repository/inspection_repository.dart';
import 'package:car_rental_app/data/repository/model_repository.dart';
import 'package:car_rental_app/data/repository/rent_repository.dart';
import 'package:car_rental_app/data/repository/vehicle_repository.dart';
import 'package:car_rental_app/domain/repository/auth_repository_abstract.dart';
import 'package:car_rental_app/domain/repository/brand_repository_abstract.dart';
import 'package:car_rental_app/domain/repository/client_repository_abstract.dart';
import 'package:car_rental_app/domain/repository/employee_respository_abstract.dart';
import 'package:car_rental_app/domain/repository/fuel_type_repository_abstract.dart';
import 'package:car_rental_app/domain/repository/inspection_repository.dart';
import 'package:car_rental_app/domain/repository/model_repository_abstract.dart';
import 'package:car_rental_app/domain/repository/rent_repository_abstract.dart';
import 'package:car_rental_app/domain/repository/vehicle_repository_abstract.dart';
import 'package:car_rental_app/domain/repository/vehicle_type_respository_abstract.dart';
import 'package:car_rental_app/ui/common/viewmodels/user_state_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:car_rental_app/core/constants/remote_constants.dart';
import 'package:car_rental_app/data/repository/vehicle_type_repository.dart';

import '../../../data/repository/client_repository.dart';

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
    ProxyProvider<Dio, ClientRepositoryAbstract>(
      update: (context, dioClient, _) => ClientRepository(
        client: dioClient,
      ),
    ),
    ProxyProvider<Dio, EmployeeRepositoryAbstract>(
      update: (context, dioClient, _) => EmployeeRepository(
        client: dioClient,
      ),
    ),
    ProxyProvider<Dio, InspectionRepositoryAbstract>(
      update: (context, dioClient, _) => InspectionRepository(
        client: dioClient,
      ),
    ),
    ProxyProvider<Dio, RentRepositoryAbstract>(
      update: (context, dioClient, _) => RentRepository(
        client: dioClient,
      ),
    ),
    ProxyProvider<Dio, AuthRepositoryAbstract>(
      update: (context, dioClient, _) => AuthRepository(
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
    ChangeNotifierProvider(create: (context) => UserStateViewModel())
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
    _providers = [
      ..._networkProviders,
      ..._repositoryProviders,
      ..._uiProviders
    ];
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
