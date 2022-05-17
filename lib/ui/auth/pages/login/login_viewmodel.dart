import 'package:car_rental_app/domain/dto/login_dto.dart';
import 'package:car_rental_app/domain/models/user.dart';
import 'package:car_rental_app/domain/repository/auth_repository_abstract.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  AuthRepositoryAbstract authRepository;
  final formKey = GlobalKey<FormState>();
  final userNameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  LoginViewModel({
    required this.authRepository,
  });

  Future<User?> login(String userName, String password) async {
    clearErrors();
    setBusy(true);
    var res = await authRepository
        .login(LoginDto(userName: userName, password: password));
    User? response;
    res.fold((ex) {
      setError(ex);
      response = null;
    }, (data) {
      response = data;
    });
    setBusy(false);
    return response;
  }
}
