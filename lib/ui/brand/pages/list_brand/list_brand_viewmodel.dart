import 'package:car_rental_app/domain/models/brand.dart';
import 'package:stacked/stacked.dart';

import '../../../../domain/repository/brand_repository_abstract.dart';

class ListBrandViewModel extends BaseViewModel {
  BrandRepositoryAbstract repository;
  List<Brand>? _list;
  List<Brand>? get list => _list;
  List<String> columnNames = ['Id', 'Descripcion', 'Estado', 'Acciones'];
  ListBrandViewModel({
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

  Future<bool> create(Brand data) async {
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

  Future<bool> update(Brand data) async {
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
