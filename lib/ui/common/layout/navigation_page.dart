import 'package:car_rental_app/ui/brand/pages/list_brand/list_brand_page.dart';
import 'package:car_rental_app/ui/common/layout/layout_page_viewmodel.dart';
import 'package:car_rental_app/ui/fuel_type/pages/list_fuel_type/list_fuel_type_page.dart';
import 'package:car_rental_app/ui/model/pages/list_model/list_model_page.dart';
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
          appBar: NavigationAppBar(automaticallyImplyLeading: false),
          pane: NavigationPane(
            selected: viewModel.currentIndex,
            displayMode: PaneDisplayMode.auto,
            onChanged: (int index) {
              viewModel.changePageIndex(index);
            },
            header: Padding(
              padding: EdgeInsets.only(left: 12),
              child: DefaultTextStyle(
                style: FluentTheme.of(context).typography.title!,
                child: Text('Car Rental App'),
              ),
            ),
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
              )
            ],
          ),
          content: NavigationBody(
            index: viewModel.currentIndex,
            children: [
              ListVehicleTypePage(),
              ListBrandPage(),
              ListModelPage(),
              ListFuelTypePage()
            ],
          ),
        );
      },
    );
  }
}
