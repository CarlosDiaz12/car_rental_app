import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:car_rental_app/core/config/dependency_injection.dart/provider_declarations.dart';
import 'package:provider/provider.dart';
import 'core/config/routing/routes.gr.dart';

Future<void> main() async {
  await dotenv.load();
  DependencyInjection.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: DependencyInjection.providers,
      child: FluentApp.router(
        debugShowCheckedModeBanner: false,
        color: Colors.blue,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        title: 'Flutter Car Rental App',
        theme: ThemeData(),
      ),
    );
  }
}
