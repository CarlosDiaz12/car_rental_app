import 'package:car_rental_app/domain/models/brand.dart';
import 'package:car_rental_app/domain/models/fuel_type.dart';
import 'package:car_rental_app/domain/models/model.dart';
import 'package:car_rental_app/domain/models/vehicle.dart';
import 'package:car_rental_app/domain/models/vehicle_type.dart';
import 'package:car_rental_app/domain/repository/brand_repository_abstract.dart';
import 'package:car_rental_app/domain/repository/fuel_type_repository_abstract.dart';
import 'package:car_rental_app/domain/repository/model_repository_abstract.dart';
import 'package:car_rental_app/domain/repository/vehicle_repository_abstract.dart';
import 'package:car_rental_app/domain/repository/vehicle_type_respository_abstract.dart';
import 'package:stacked/stacked.dart';

class ListVehicleViewModel extends BaseViewModel {
  VehicleRepositoryAbstract repository;
  VehicleTypeRepositoryAbstract vehicleTypeRepository;
  BrandRepositoryAbstract brandRepository;
  ModelRepositoryAbstract modelRepository;
  FuelTypeRepositoryAbstract fuelTypeRepository;

  List<VehicleType>? _vehicleTypeList;
  List<VehicleType>? get vehicleTypeList => _vehicleTypeList;

  List<Brand>? _brandList;
  List<Brand>? get brandList => _brandList;

  List<Model>? _modelList;
  List<Model>? get modelList => _modelList;

  List<FuelType>? _fuelTypeList;
  List<FuelType>? get fuelTypeList => _fuelTypeList;

  List<Vehicle>? _list;
  List<Vehicle>? get list => _list;
  List<String> columnNames = [
    'Id',
    'Descripcion',
    'No. Chasis',
    'No. Motor',
    'No. Placa',
    'Tipo',
    'Marca',
    'Modelo',
    'Combustible',
    'Estado',
    'Acciones'
  ];
  ListVehicleViewModel({
    required this.vehicleTypeRepository,
    required this.brandRepository,
    required this.modelRepository,
    required this.fuelTypeRepository,
    required this.repository,
  });

  Future<void> loadValuesData() async {
    clearErrors();
    setBusy(true);
    // vehicle types
    var res = await vehicleTypeRepository.getAll();
    res.fold((ex) {
      setError(ex);
    }, (data) {
      _vehicleTypeList = data;
    });

    // brand
    var brandResponse = await brandRepository.getAll();
    brandResponse.fold((ex) {
      setError(ex);
    }, (data) {
      _brandList = data;
    });

    // model
    var modelResponse = await modelRepository.getAll();
    modelResponse.fold((ex) {
      setError(ex);
    }, (data) {
      _modelList = data;
    });

    // fuel type
    var fuelTypeResponse = await fuelTypeRepository.getAll();
    fuelTypeResponse.fold((ex) {
      setError(ex);
    }, (data) {
      _fuelTypeList = data;
    });
    setBusy(false);
  }

  Future<void> loadData() async {
    clearErrors();
    setBusy(true);
    var res = await repository.getAll();
    res.fold((ex) {
      setError(ex);
    }, (data) {
      _list = data;
    });
    setBusy(false);
  }

  Future<bool> create(Vehicle data) async {
    clearErrors();
    var res = await repository.create(data);
    var response = false;
    res.fold((ex) {
      setError(ex);
    }, (data) {
      response = data;
    });
    return response;
  }

  Future<bool> update(Vehicle data) async {
    clearErrors();
    var res = await repository.update(data);
    var response = false;
    res.fold((ex) {
      setError(ex);
    }, (data) {
      response = data;
    });
    return response;
  }

  Future<bool> delete(int id) async {
    clearErrors();
    var res = await repository.delete(id);
    var response = false;
    res.fold((ex) {
      setError(ex);
    }, (data) {
      response = data;
    });
    return response;
  }
}
