import 'package:stacked/stacked.dart';

class LayoutPageViewModel extends BaseViewModel {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void changePageIndex(int selectedIndex) {
    _currentIndex = selectedIndex;
    notifyListeners();
  }
}
