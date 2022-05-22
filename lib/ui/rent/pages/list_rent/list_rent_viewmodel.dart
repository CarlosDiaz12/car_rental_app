import 'dart:io';

import 'package:car_rental_app/core/util/report_util.dart';
import 'package:car_rental_app/domain/dto/is_available_for_rent_dto.dart';
import 'package:car_rental_app/domain/dto/rent_filter_dto.dart';
import 'package:car_rental_app/domain/models/rent.dart';
import 'package:car_rental_app/domain/repository/inspection_repository.dart';
import 'package:car_rental_app/domain/repository/rent_repository_abstract.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
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

  List<Rent>? _filteredList;
  List<Rent>? get filteredList => _filteredList;

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
    'Devuelto',
    'Acciones'
  ];

  RentFilterDto filters = RentFilterDto(
    rentDate: DateTime.now(),
    client: '',
    vehicle: '',
  );
  ListRentViewModel({
    required this.repository,
    required this.clientRepository,
    required this.employeeRepository,
    required this.vehicleRepository,
    required this.inspectionRepository,
  });

  void exportData() async {
    // generate workbook
    var data = _filteredList;
    var workBook = ReportUtil.createRentExcelFile(data!);
    // save to device
    List<int> bytes = workBook.saveAsStream();
    workBook.dispose();
    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName =
        '$path\\report-${DateTime.now().millisecondsSinceEpoch}.xlsx';
    final File file = File(fileName);
    file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
  }

  void setRentDate(DateTime date) {
    filters.rentDate = date;
    notifyListeners();
  }

  void filterList() {
    var filteredList = _list;
    if (filters.client != null && filters.client!.isNotEmpty) {
      filteredList = filteredList
          ?.where((element) => element.client!.name!
              .toLowerCase()
              .contains(filters.client!.toLowerCase()))
          .toList();
    }
    if (filters.vehicle != null && filters.vehicle!.isNotEmpty) {
      filteredList = filteredList
          ?.where((element) => (element.vehicle!.brand!.description! +
                  element.vehicle!.model!.description!)
              .toLowerCase()
              .contains(filters.vehicle!.toLowerCase()))
          .toList();
    }

    if (filters.rentDate != null) {
      var rentDate = filters.rentDate!;
      var rentDateUtc =
          DateTime.utc(rentDate.year, rentDate.month, rentDate.day);
      filteredList = filteredList!
          .where((element) =>
              element.rentDate!.day == rentDateUtc.day &&
              element.rentDate!.month == rentDateUtc.month &&
              element.rentDate!.year == rentDateUtc.year)
          .toList();
    }

    _filteredList = filteredList;
    notifyListeners();
  }

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

  Future<bool> checkAvailabilityForRent(IsAvailableForRentDto data) async {
    clearErrors();
    var res = await repository.isAvailableForRent(data);
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
      _filteredList = data;
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
