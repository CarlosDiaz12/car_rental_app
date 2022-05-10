import 'package:car_rental_app/ui/common/layout/layout_page_viewmodel.dart';
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
            onChanged: (int index) {},
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
              )
            ],
          ),
          content: NavigationBody(
            index: viewModel.currentIndex,
            children: [
              ListVehicleTypePage(),
            ],
          ),
        );
      },
    );
  }
}
