import 'package:auto_route/auto_route.dart';
import 'package:car_rental_app/domain/models/rent.dart';
import 'package:car_rental_app/domain/repository/inspection_repository.dart';
import 'package:car_rental_app/domain/repository/rent_repository_abstract.dart';
import 'package:car_rental_app/ui/rent/pages/create_edit_rent/create_edit_rent.dart';
import 'package:car_rental_app/ui/rent/pages/list_rent/list_rent_viewmodel.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../../domain/enums/form_action_enum.dart';
import '../../../../domain/repository/client_repository_abstract.dart';
import '../../../../domain/repository/employee_respository_abstract.dart';
import '../../../../domain/repository/vehicle_repository_abstract.dart';
import '../../../common/view_utils.dart';
import '../../../common/widgets/error_banner.dart';
import '../../../common/widgets/labeled_flied_widget.dart';
import '../../../common/widgets/table_widget.dart';

class ListRentPage extends StatelessWidget {
  const ListRentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListRentViewModel>.reactive(
      viewModelBuilder: () => ListRentViewModel(
        repository: Provider.of<RentRepositoryAbstract>(context),
        clientRepository: Provider.of<ClientRepositoryAbstract>(context),
        employeeRepository: Provider.of<EmployeeRepositoryAbstract>(context),
        vehicleRepository: Provider.of<VehicleRepositoryAbstract>(context),
        inspectionRepository:
            Provider.of<InspectionRepositoryAbstract>(context),
      ),
      onModelReady: (viewModel) async {
        await viewModel.loadData();
        await viewModel.loadValuesData();
      },
      builder: (context, viewModel, _) {
        var labelStyle = FluentTheme.of(context).typography.body?.copyWith(
              fontWeight: FontWeight.bold,
            );
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ScaffoldPage(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            header: PageHeader(
              leading: Text(
                'Rentas',
                style: FluentTheme.of(context).typography.title!,
              ),
            ),
            content: SingleChildScrollView(
              child: viewModel.isBusy
                  ? Center(child: ProgressRing())
                  : viewModel.hasError
                      ? ErrorBanner(
                          exception: viewModel.modelError,
                          callBack: viewModel.loadData)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            fluent.Card(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: LabeledFieldWidget(
                                      label: 'Cliente',
                                      child: TextFormBox(
                                        placeholder: 'Cliente',
                                        onChanged: (value) {
                                          viewModel.filters.client = value;
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  SizedBox(
                                    width: 200,
                                    child: LabeledFieldWidget(
                                      label: 'Vehiculo',
                                      child: TextFormBox(
                                        placeholder: 'Vehiculo',
                                        onChanged: (value) {
                                          viewModel.filters.vehicle = value;
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  SizedBox(
                                    width: 200,
                                    child: DatePicker(
                                      selected: viewModel.filters.rentDate!,
                                      headerStyle: labelStyle,
                                      header: 'Fecha Renta',
                                      onChanged: (value) {
                                        viewModel.setRentDate(value);
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  LabeledFieldWidget(
                                    label: '',
                                    child: fluent.FilledButton(
                                      onPressed: viewModel.filterList,
                                      child: Text('Filtrar'),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  LabeledFieldWidget(
                                    label: '',
                                    child: Button(
                                      onPressed: viewModel.loadData,
                                      child: Text('Limpiar'),
                                    ),
                                  ),
                                  SizedBox(width: 200),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Button(
                                  onPressed: () async {
                                    manageCreateEdit(context,
                                        FORM_ACTION.CREATE, viewModel, null);
                                  },
                                  child: Text('Agregar'),
                                ),
                                SizedBox(width: 10),
                                fluent.FilledButton(
                                  onPressed: viewModel.exportData,
                                  child: Text('Exportar'),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            TableWidget(
                              columnWidth: 24,
                              columnNames: viewModel.columnNames,
                              rows: [
                                ...viewModel.filteredList!.map(
                                  (e) => DataRow(
                                    cells: [
                                      ViewUtils.buildTableCell(
                                        e.id,
                                        onTap: () {
                                          manageCreateEdit(context,
                                              FORM_ACTION.UPDATE, viewModel, e);
                                        },
                                      ),
                                      ViewUtils.buildTableCell(
                                          e.employee?.name),
                                      ViewUtils.buildTableCell(
                                          '${e.vehicle?.brand?.description} ${e.vehicle?.model?.description}'),
                                      ViewUtils.buildTableCell(e.client?.name),
                                      ViewUtils.buildTableCell(
                                          ViewUtils.formatDate(e.rentDate!)),
                                      ViewUtils.buildTableCell(
                                          ViewUtils.formatDate(e.returnDate!)),
                                      ViewUtils.buildTableCell(e.ratePerDay),
                                      ViewUtils.buildTableCell(e.daysQuantity),
                                      ViewUtils.buildTableCell(
                                          (e.status == true)
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
      ListRentViewModel viewModel, Rent? data) async {
    var response = await fluent.showDialog<Rent?>(
      context: context,
      builder: (context) {
        return CreateEditRent(
          viewModel: viewModel,
          employeeList: viewModel.employeeList!,
          clientList: viewModel.clientList!,
          vehicleList: viewModel.vehicleList!,
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
    await fluent.showDialog<Rent?>(
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
