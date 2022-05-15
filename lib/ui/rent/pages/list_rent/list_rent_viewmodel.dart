import 'package:car_rental_app/domain/models/rent.dart';
import 'package:car_rental_app/domain/repository/inspection_repository.dart';
import 'package:car_rental_app/domain/repository/rent_repository_abstract.dart';
import 'package:stacked/stacked.dart';

import '../../../../domain/dto/check_vehicle_availability_dto.dart';
import '../../../../domain/models/client.dart';
import '../../../../domain/models/employee.dart';
import '../../../../domain/models/vehicle.dart';
import '../../../../domain/repository/client_repository_abstract.dart';
import '../../../../domain/repository/employee_respository_abstract.dart';
import '../../../../domain/repository/vehicle_repository_abstract.dart';

class ListRentViewModel extends BaseViewModel {
  RentRepositoryAbstract repository;
  ClientRepositoryAbstract clientRepository;
  VehicleRepositoryAbstract vehicleRepository;
  EmployeeRepositoryAbstract employeeRepository;
  InspectionRepositoryAbstract inspectionRepository;
  List<Rent>? _list;
  List<Rent>? get list => _list;

  List<Vehicle>? _vehicleList;
  List<Vehicle>? get vehicleList => _vehicleList;

  List<Client>? _clientList;
  List<Client>? get clientList => _clientList;

  List<Employee>? _employeeList;
  List<Employee>? get employeeList => _employeeList;

  List<String> columnNames = [
    'Id',
    'Empleado',
    'Vehiculo',
    'Cliente',
    'Renta',
    'Devolucion',
    'Monto x Dia',
    'Cant. Dias',
    'Estado',
    'Acciones'
  ];
  ListRentViewModel({
    required this.repository,
    required this.clientRepository,
    required this.employeeRepository,
    required this.vehicleRepository,
    required this.inspectionRepository,
  });

  Future<bool> checkAvailability(CheckVehicleAvailabilityDto data) async {
    clearErrors();
    var res = await inspectionRepository.checkVehicleAvailability(data);
    var response = false;
    res.fold((ex) {
      setError(ex);
    }, (data) {
      response = data;
    });
    return response;
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

  Future<bool> create(Rent data) async {
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

  Future<bool> update(Rent data) async {
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
