import 'package:car_rental_app/domain/models/employee.dart';
import 'package:car_rental_app/domain/repository/employee_respository_abstract.dart';
import 'package:stacked/stacked.dart';

class ListEmployeeViewModel extends BaseViewModel {
  EmployeeRepositoryAbstract repository;
  List<Employee>? _list;
  List<Employee>? get list => _list;
  List<String> columnNames = [
    'Id',
    'Nombre',
    'Cedula',
    'Turno Labor.',
    'Porc. Comision',
    'Fecha Ingreso'
        'Estado',
    'Acciones'
  ];
  ListEmployeeViewModel({
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

  Future<bool> create(Employee data) async {
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

  Future<bool> update(Employee data) async {
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
