import 'package:car_rental_app/domain/models/client.dart';
import 'package:car_rental_app/domain/models/employee.dart';
import 'package:car_rental_app/domain/models/inspection.dart';
import 'package:car_rental_app/domain/models/vehicle.dart';
import 'package:car_rental_app/domain/repository/client_repository_abstract.dart';
import 'package:car_rental_app/domain/repository/employee_respository_abstract.dart';
import 'package:car_rental_app/domain/repository/inspection_repository.dart';
import 'package:car_rental_app/domain/repository/vehicle_repository_abstract.dart';
import 'package:stacked/stacked.dart';

class ListInspectionViewModel extends BaseViewModel {
  InspectionRepositoryAbstract repository;
  ClientRepositoryAbstract clientRepository;
  VehicleRepositoryAbstract vehicleRepository;
  EmployeeRepositoryAbstract employeeRepository;

  List<Vehicle>? _vehicleList;
  List<Vehicle>? get vehicleList => _vehicleList;

  List<Client>? _clientList;
  List<Client>? get clientList => _clientList;

  List<Employee>? _employeeList;
  List<Employee>? get employeeList => _employeeList;

  List<Inspection>? _list;
  List<Inspection>? get list => _list;
  List<String> columnNames = [
    'Id',
    'Fecha',
    'Empleado',
    'Vehiculo',
    'Cliente',
    'Ralladuras',
    'Cant. Comb.',
    'Repuesta',
    'Gato',
    'Rot. Cristal',
    'Estado',
    'Acciones'
  ];

  ListInspectionViewModel(
      {required this.repository,
      required this.clientRepository,
      required this.employeeRepository,
      required this.vehicleRepository});

  Future<void> loadValuesData() async {
    clearErrors();
    setBusy(true);
    // vehicle
    var res = await vehicleRepository.getAll();
    res.fold((ex) {
      setError(ex);
    }, (data) {
      _vehicleList = data;
    });

    // client
    var brandResponse = await clientRepository.getAll();
    brandResponse.fold((ex) {
      setError(ex);
    }, (data) {
      _clientList = data;
    });

    // employee
    var modelResponse = await employeeRepository.getAll();
    modelResponse.fold((ex) {
      setError(ex);
    }, (data) {
      _employeeList = data;
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

  Future<bool> create(Inspection data) async {
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

  Future<bool> update(Inspection data) async {
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
