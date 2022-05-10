import 'package:car_rental_app/domain/models/brand.dart';
import 'package:car_rental_app/domain/models/model.dart';
import 'package:car_rental_app/domain/repository/brand_repository_abstract.dart';
import 'package:car_rental_app/domain/repository/model_repository_abstract.dart';
import 'package:stacked/stacked.dart';

class ListModelViewModel extends BaseViewModel {
  ModelRepositoryAbstract repository;
  BrandRepositoryAbstract brandRepository;
  List<Model>? _list;
  List<Model>? get list => _list;
  List<Brand>? _brandList;
  List<Brand>? get brandList => _brandList;
  List<String> columnNames = [
    'Id',
    'Descripcion',
    'Marca',
    'Estado',
    'Acciones'
  ];
  ListModelViewModel({
    required this.brandRepository,
    required this.repository,
  });

  Future<void> loadBrandData() async {
    clearErrors();
    setBusy(true);
    var res = await brandRepository.getAll();
    res.fold((ex) {
      setError(ex);
    }, (data) {
      _brandList = data;
    });
    setBusy(false);
  }

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

  Future<bool> create(Model data) async {
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

  Future<bool> update(Model data) async {
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
