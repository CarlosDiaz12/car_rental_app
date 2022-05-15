import 'package:car_rental_app/domain/models/rent.dart';
import 'package:car_rental_app/domain/repository/rent_repository_abstract.dart';
import 'package:stacked/stacked.dart';

class ListRentViewModel extends BaseViewModel {
  RentRepositoryAbstract repository;
  List<Rent>? _list;
  List<Rent>? get list => _list;
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
