import 'package:car_rental_app/domain/models/inspection.dart';
import 'package:car_rental_app/domain/repository/inspection_repository.dart';
import 'package:stacked/stacked.dart';

class ListInspectionViewModel extends BaseViewModel {
  InspectionRepositoryAbstract repository;
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
  ListInspectionViewModel({
    required this.repository,
  });

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
