import 'package:car_rental_app/domain/models/fuel_type.dart';
import 'package:car_rental_app/domain/repository/fuel_type_repository_abstract.dart';
import 'package:stacked/stacked.dart';

class ListFuelTypeViewModel extends BaseViewModel {
  FuelTypeRepositoryAbstract repository;
  List<FuelType>? _list;
  List<FuelType>? get list => _list;
  List<String> columnNames = ['Id', 'Descripcion', 'Estado', 'Acciones'];
  ListFuelTypeViewModel({
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

  Future<bool> create(FuelType data) async {
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

  Future<bool> update(FuelType data) async {
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
