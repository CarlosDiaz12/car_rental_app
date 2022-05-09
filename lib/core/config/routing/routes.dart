import 'package:auto_route/auto_route.dart';
import 'package:flutter_movies_app/main.dart';
import 'package:flutter_movies_app/ui/pages/example/example_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: ExamplePage),
  ],
)
class $AppRouter {}
