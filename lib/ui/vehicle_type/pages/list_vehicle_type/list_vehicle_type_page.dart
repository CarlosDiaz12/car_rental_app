import 'package:car_rental_app/ui/common/view_utils.dart';
import 'package:car_rental_app/ui/common/widgets/table_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:car_rental_app/data/repository/vehicle_type_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'list_vehicle_type_viewmodel.dart';

class ListVehicleTypePage extends StatelessWidget {
  const ListVehicleTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListVehicleTypeViewModel>.reactive(
      viewModelBuilder: () => ListVehicleTypeViewModel(
        repository: Provider.of<VehicleTypeRepository>(context),
      ),
      onModelReady: (viewModel) async {
        await viewModel.loadData();
      },
      builder: (context, viewModel, _) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ScaffoldPage(
            header: PageHeader(
              leading: Text(
                'Vehicle Types',
                style: FluentTheme.of(context).typography.title!,
              ),
            ),
            content: SingleChildScrollView(
              child: viewModel.busy(viewModel.list)
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Button(
                          onPressed: () {},
                          child: Text('Agregar'),
                        ),
                        SizedBox(height: 10),
                        TableWidget(
                          columnNames: viewModel.columnNames,
                          rows: [
                            ...viewModel.list!.map(
                              (e) => TableRow(
                                children: [
                                  ViewUtils.buildTableCell(e.id),
                                  ViewUtils.buildTableCell(e.description),
                                  ViewUtils.buildTableCell(e.status),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
