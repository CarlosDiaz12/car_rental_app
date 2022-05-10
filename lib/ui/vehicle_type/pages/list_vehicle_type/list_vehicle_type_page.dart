import 'package:auto_route/auto_route.dart';
import 'package:car_rental_app/domain/models/vehicle_type.dart';
import 'package:car_rental_app/domain/repository/vehicle_type_respository_abstract.dart';
import 'package:car_rental_app/ui/common/view_utils.dart';
import 'package:car_rental_app/ui/common/widgets/table_widget.dart';
import 'package:car_rental_app/ui/vehicle_type/pages/list_vehicle_type/create_edit_vehicle_type/create_edit_vehicle_type.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../../domain/enums/form_action_enum.dart';
import 'list_vehicle_type_viewmodel.dart';

class ListVehicleTypePage extends StatelessWidget {
  const ListVehicleTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListVehicleTypeViewModel>.reactive(
      viewModelBuilder: () => ListVehicleTypeViewModel(
        repository: Provider.of<VehicleTypeRepositoryAbstract>(context),
      ),
      onModelReady: (viewModel) async {
        await viewModel.loadData();
      },
      builder: (context, viewModel, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ScaffoldPage(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            header: PageHeader(
              leading: Text(
                'Tipos de Vehiculos',
                style: FluentTheme.of(context).typography.title!,
              ),
            ),
            content: SingleChildScrollView(
              child: viewModel.busy(viewModel.list)
                  ? Center(child: ProgressRing())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Button(
                          onPressed: () async {
                            manageCreateEdit(
                                context, FORM_ACTION.CREATE, viewModel, null);
                          },
                          child: Text('Agregar'),
                        ),
                        SizedBox(height: 10),
                        TableWidget(
                          columnNames: viewModel.columnNames,
                          rows: [
                            ...viewModel.list!.map(
                              (e) => DataRow(
                                cells: [
                                  ViewUtils.buildTableCell(
                                    e.id,
                                    onTap: () {
                                      manageCreateEdit(context,
                                          FORM_ACTION.UPDATE, viewModel, e);
                                    },
                                  ),
                                  ViewUtils.buildTableCell(e.description),
                                  ViewUtils.buildTableCell((e.status == true)
                                      ? 'Activo'
                                      : 'Inactivo'),
                                  ViewUtils.buildActionTableCell(
                                    child: Icon(fluent.FluentIcons.delete),
                                    onTap: () async {
                                      var delete =
                                          await _showConfirmDialog(context);
                                      if (delete) {
                                        _showLoading(context);
                                        await viewModel.delete(e.id!);
                                        AutoRouter.of(context).pop();
                                        await viewModel.loadData();
                                      }
                                    },
                                  )
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

  Future<bool> _showConfirmDialog(BuildContext context) async {
    var response = await fluent.showDialog(
        context: context, builder: (ctx) => ViewUtils.confirmDialog(context));
    return (response != null && response == true);
  }

  Future<void> manageCreateEdit(BuildContext context, FORM_ACTION action,
      ListVehicleTypeViewModel viewModel, VehicleType? data) async {
    var response = await fluent.showDialog<VehicleType?>(
      context: context,
      builder: (context) {
        return CreateEditVehicleType(
          action: action,
          data: data,
        );
      },
    );

    if (response != null) {
      _showLoading(context);
      if (action == FORM_ACTION.CREATE) {
        await viewModel.create(response);
      } else {
        await viewModel.update(response);
      }

      AutoRouter.of(context).pop();
      viewModel.loadData();
    }
  }

  Future<void> _showLoading(BuildContext context) async {
    await fluent.showDialog<VehicleType?>(
      context: context,
      builder: (context) {
        return ContentDialog(
          constraints: BoxConstraints(maxHeight: 150, maxWidth: 200),
          title: Text('Cargando'),
          content: Center(
            child: ProgressRing(),
          ),
        );
      },
    );
  }
}
