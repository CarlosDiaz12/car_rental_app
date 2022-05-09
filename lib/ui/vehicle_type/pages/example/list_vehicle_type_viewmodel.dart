import 'package:flutter_movies_app/data/repository/vehicle_type_repository.dart';
import 'package:flutter_movies_app/domain/models/vehicle_type.dart';
import 'package:stacked/stacked.dart';

class ListVehicleTypeViewModel extends BaseViewModel {
  VehicleTypeRepository repository;
  List<VehicleType>? _vehicleTypeList;
  List<VehicleType>? get list => _vehicleTypeList;
  ListVehicleTypeViewModel({
    required this.repository,
  });

  Future<void> loadData() async {
    setBusyForObject(list, true);
    var res = await repository.getAll();
    res.fold((ex) {
      setError(ex);
      print('Error');
    }, (data) {
      _vehicleTypeList = data;
    });
    setBusyForObject(list, false);
  }
}
