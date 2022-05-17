import 'package:car_rental_app/domain/models/user.dart';
import 'package:stacked/stacked.dart';

class UserStateViewModel extends BaseViewModel {
  User? _currentUser;
  User? get currentUser => _currentUser;

  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void removeCurrentUser() {
    _currentUser = null;
    notifyListeners();
  }
}
