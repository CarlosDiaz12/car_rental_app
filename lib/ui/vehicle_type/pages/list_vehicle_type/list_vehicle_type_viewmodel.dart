import 'package:car_rental_app/domain/models/vehicle_type.dart';
import 'package:car_rental_app/domain/repository/vehicle_type_respository_abstract.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/error/exceptions.dart';

class ListVehicleTypeViewModel extends BaseViewModel {
  VehicleTypeRepositoryAbstract repository;
  List<VehicleType>? _vehicleTypeList;
  List<VehicleType>? get list => _vehicleTypeList;
  List<String> columnNames = ['Id', 'Descripcion', 'Estado', 'Acciones'];
  BaseException createEditResponse = BaseException('');
  ListVehicleTypeViewModel({
    required this.repository,
  });

  Future<void> loadData() async {
    clearErrors();
    setBusyForObject(_vehicleTypeList, true);
    var res = await repository.getAll();
    res.fold((ex) {
      setError(ex);
    }, (data) {
      _vehicleTypeList = data;
    });
    setBusyForObject(_vehicleTypeList, false);
  }

  Future<bool> create(VehicleType data) async {
    clearErrors();
    var res = await repository.create(data);
    var response = false;
    res.fold((ex) {
      setErrorForObject(createEditResponse, ex);
    }, (data) {
      response = data;
    });
    return response;
  }

  Future<bool> update(VehicleType data) async {
    clearErrors();
    var res = await repository.update(data);
    var response = false;
    res.fold((ex) {
      setErrorForObject(createEditResponse, ex);
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
