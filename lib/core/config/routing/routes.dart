import 'package:auto_route/auto_route.dart';
import 'package:car_rental_app/ui/common/layout/navigation_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: NavigationPage, initial: true),
  ],
)
class $AppRouter {}
