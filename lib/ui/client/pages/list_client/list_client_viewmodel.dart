import 'package:car_rental_app/domain/models/client.dart';
import 'package:car_rental_app/domain/repository/client_repository_abstract.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/error/exceptions.dart';

class ListClientViewModel extends BaseViewModel {
  ClientRepositoryAbstract repository;
  List<Client>? _list;
  List<Client>? get list => _list;
  BaseException createEditResponse = BaseException('');
  List<String> columnNames = [
    'Id',
    'Nombre',
    'Cedula',
    'Limite Cred.',
    'No. Tarj.',
    'Tipo Cont.',
    'Estado',
    'Acciones'
  ];
  ListClientViewModel({
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

  Future<bool> create(Client data) async {
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

  Future<bool> update(Client data) async {
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
