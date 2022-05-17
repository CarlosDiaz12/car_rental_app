import 'package:auto_route/auto_route.dart';
import 'package:car_rental_app/core/config/routing/routes.gr.dart';
import 'package:car_rental_app/ui/brand/pages/list_brand/list_brand_page.dart';
import 'package:car_rental_app/ui/client/pages/list_client/list_client_page.dart';
import 'package:car_rental_app/ui/common/layout/layout_page_viewmodel.dart';
import 'package:car_rental_app/ui/common/viewmodels/user_state_viewmodel.dart';
import 'package:car_rental_app/ui/employee/pages/list_employee/list_employee_page.dart';
import 'package:car_rental_app/ui/fuel_type/pages/list_fuel_type/list_fuel_type_page.dart';
import 'package:car_rental_app/ui/home/home_page.dart';
import 'package:car_rental_app/ui/model/pages/list_model/list_model_page.dart';
import 'package:car_rental_app/ui/rent/pages/list_rent/list_rent_page.dart';
import 'package:car_rental_app/ui/vehicle/pages/list_vehicle/list_vehicle_page.dart';
import 'package:car_rental_app/ui/vehicle_type/pages/list_vehicle_type/list_vehicle_type_page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../inspection/pages/list_inspection/list_inspection_page.dart';

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
              child: Row(
                children: [
                  Icon(FluentIcons.car, size: 24),
                  SizedBox(width: 10),
                  Text(
                    'Car Rental System',
                    style: FluentTheme.of(context).typography.title!.copyWith(
                          fontSize: 24,
                        ),
                  ),
                ],
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
            displayMode: PaneDisplayMode.compact,
            onChanged: (int index) {
              viewModel.changePageIndex(index);
            },
            items: [
              PaneItem(
                icon: Icon(Icons.home_outlined, size: 24),
                title: Text('Inicio'),
              ),
              PaneItem(
                icon: Icon(Icons.car_rental_outlined, size: 24),
                title: Text('Rentas'),
              ),
              PaneItem(
                icon: Icon(Icons.rate_review_outlined, size: 24),
                title: Text('Inspecciones'),
              ),
              PaneItemSeparator(),
              PaneItemHeader(
                header: Text('Mantenimientos'),
              ),
              PaneItem(
                icon: Icon(Icons.car_repair_outlined, size: 24),
                title: Text('Tipos de Vehiculos'),
              ),
              PaneItem(
                icon: Icon(Icons.list_alt_outlined, size: 24),
                title: Text('Marcas'),
              ),
              PaneItem(
                icon: Icon(Icons.checklist_rtl_outlined, size: 24),
                title: Text('Modelos'),
              ),
              PaneItem(
                icon: Icon(Icons.local_gas_station_outlined, size: 24),
                title: Text('Tipos de Combustibles'),
              ),
              PaneItem(
                icon: Icon(Icons.directions_car_outlined, size: 24),
                title: Text('Vehiculos'),
              ),
              PaneItem(
                icon: Icon(Icons.group_outlined, size: 24),
                title: Text('Clientes'),
              ),
              PaneItem(
                icon: Icon(Icons.badge_outlined, size: 24),
                title: Text('Empleados'),
              ),
            ],
            footerItems: [
              PaneItemAction(
                onTap: () {
                  Provider.of<UserStateViewModel>(context, listen: false)
                      .removeCurrentUser();
                  AutoRouter.of(context).replace(LoginRoute());
                },
                icon: Icon(Icons.exit_to_app_outlined, size: 24),
                title: Text('Cerrar Sesion'),
              ),
            ],
          ),
          content: NavigationBody(
            index: viewModel.currentIndex,
            children: [
              HomePage(),
              ListRentPage(),
              ListInspectionPage(),
              ListVehicleTypePage(),
              ListBrandPage(),
              ListModelPage(),
              ListFuelTypePage(),
              ListVehiclePage(),
              ListClientPage(),
              ListEmployeePage(),
            ],
          ),
        );
      },
    );
  }
}
