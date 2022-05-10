import 'package:auto_route/auto_route.dart';
import 'package:car_rental_app/main.dart';

import '../../../ui/vehicle_type/pages/list_vehicle_type/list_vehicle_type_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: ListVehicleTypePage),
  ],
)
class $AppRouter {}
