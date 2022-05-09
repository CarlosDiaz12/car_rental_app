import 'package:auto_route/auto_route.dart';
import 'package:flutter_movies_app/main.dart';
import 'package:flutter_movies_app/ui/vehicle_type/pages/example/list_vehicle_type_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: ListVehicleTypePage),
  ],
)
class $AppRouter {}
