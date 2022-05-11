import 'package:car_rental_app/ui/brand/pages/list_brand/list_brand_page.dart';
import 'package:car_rental_app/ui/client/pages/list_client/list_client_page.dart';
import 'package:car_rental_app/ui/common/layout/layout_page_viewmodel.dart';
import 'package:car_rental_app/ui/employee/pages/list_employee/list_employee_page.dart';
import 'package:car_rental_app/ui/fuel_type/pages/list_fuel_type/list_fuel_type_page.dart';
import 'package:car_rental_app/ui/model/pages/list_model/list_model_page.dart';
import 'package:car_rental_app/ui/vehicle/pages/list_vehicle/list_vehicle_page.dart';
import 'package:car_rental_app/ui/vehicle_type/pages/list_vehicle_type/list_vehicle_type_page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:stacked/stacked.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LayoutPageViewModel>.reactive(
      viewModelBuilder: () => LayoutPageViewModel(),
      builder: (context, viewModel, _) {
        return NavigationView(
          appBar: NavigationAppBar(
            automaticallyImplyLeading: false,
            title: Padding(
              padding: EdgeInsets.only(left: 12),
              child: DefaultTextStyle(
                style: FluentTheme.of(context).typography.title!.copyWith(
                      fontSize: 26,
                    ),
                child: Text('Car Rental System'),
              ),
            ),
          ),
          pane: NavigationPane(
            header: Padding(
              padding: EdgeInsets.only(left: 12),
              child: DefaultTextStyle(
                style: FluentTheme.of(context).typography.subtitle!,
                child: Text('Menu'),
              ),
            ),
            selected: viewModel.currentIndex,
            displayMode: PaneDisplayMode.auto,
            onChanged: (int index) {
              viewModel.changePageIndex(index);
            },
            items: [
              PaneItem(
                icon: Icon(FluentIcons.car),
                title: Text('Tipos de Vehiculos'),
              ),
              PaneItem(
                icon: Icon(FluentIcons.verified_brand_solid),
                title: Text('Marcas'),
              ),
              PaneItem(
                icon: Icon(FluentIcons.transportation),
                title: Text('Modelos'),
              ),
              PaneItem(
                icon: Icon(FluentIcons.transportation),
                title: Text('Tipos de Combustibles'),
              ),
              PaneItem(
                icon: Icon(FluentIcons.car),
                title: Text('Vehiculos'),
              ),
              PaneItem(
                icon: Icon(FluentIcons.people),
                title: Text('Clientes'),
              ),
              PaneItem(
                icon: Icon(FluentIcons.employee_self_service),
                title: Text('Empleados'),
              )
            ],
          ),
          content: NavigationBody(
            index: viewModel.currentIndex,
            children: [
              ListVehicleTypePage(),
              ListBrandPage(),
              ListModelPage(),
              ListFuelTypePage(),
              ListVehiclePage(),
              ListClientPage(),
              ListEmployeePage()
            ],
          ),
        );
      },
    );
  }
}
