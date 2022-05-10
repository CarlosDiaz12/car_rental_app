import 'package:car_rental_app/data/repository/vehicle_type_repository.dart';
import 'package:car_rental_app/domain/models/vehicle_type.dart';
import 'package:stacked/stacked.dart';

class ListVehicleTypeViewModel extends BaseViewModel {
  VehicleTypeRepository repository;
  List<VehicleType>? _vehicleTypeList;
  List<VehicleType>? get list => _vehicleTypeList;
  List<String> columnNames = ['Id', 'Descripcion', 'Estado'];
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
      setError(ex);
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
      setError(ex);
    }, (data) {
      response = data;
    });
    return response;
  }
}
