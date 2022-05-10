import 'package:car_rental_app/domain/models/vehicle.dart';
import 'package:car_rental_app/domain/repository/vehicle_repository_abstract.dart';
import 'package:stacked/stacked.dart';

class ListVehicleViewModel extends BaseViewModel {
  VehicleRepositoryAbstract repository;
  List<Vehicle>? _list;
  List<Vehicle>? get list => _list;
  List<String> columnNames = [
    'Id',
    'Descripcion',
    'No. Chasis',
    'No. Motor',
    'No. Placa',
    'TipO',
    'Marca',
    'Modelo',
    'Combustible',
    'Estado',
    'Acciones'
  ];
  ListVehicleViewModel({
    required this.repository,
  });

  Future<void> loadData() async {
    clearErrors();
    setBusyForObject(_list, true);
    var res = await repository.getAll();
    res.fold((ex) {
      setError(ex);
    }, (data) {
      _list = data;
    });
    setBusyForObject(_list, false);
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
