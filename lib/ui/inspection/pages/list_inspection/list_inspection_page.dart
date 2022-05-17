import 'package:auto_route/auto_route.dart';
import 'package:car_rental_app/domain/enums/inspection_type.dart';
import 'package:car_rental_app/domain/models/inspection.dart';
import 'package:car_rental_app/domain/repository/client_repository_abstract.dart';
import 'package:car_rental_app/domain/repository/employee_respository_abstract.dart';
import 'package:car_rental_app/domain/repository/inspection_repository.dart';
import 'package:car_rental_app/domain/repository/vehicle_repository_abstract.dart';
import 'package:car_rental_app/ui/inspection/pages/list_inspection/list_inspection_viewmodel.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import '../../../../domain/enums/form_action_enum.dart';
import '../../../common/view_utils.dart';
import '../../../common/widgets/error_banner.dart';
import '../../../common/widgets/table_widget.dart';
import '../create_edit_inspection/create_edit_inspection.dart';

class ListInspectionPage extends StatelessWidget {
  const ListInspectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListInspectionViewModel>.reactive(
      viewModelBuilder: () => ListInspectionViewModel(
        clientRepository: Provider.of<ClientRepositoryAbstract>(context),
        employeeRepository: Provider.of<EmployeeRepositoryAbstract>(context),
        vehicleRepository: Provider.of<VehicleRepositoryAbstract>(context),
        repository: Provider.of<InspectionRepositoryAbstract>(context),
      ),
      onModelReady: (viewModel) async {
        await viewModel.loadData();
        await viewModel.loadValuesData();
      },
      builder: (context, viewModel, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ScaffoldPage(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            header: PageHeader(
              leading: Text(
                'Inspecciones',
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
                          children: [
                            Button(
                              onPressed: () async {
                                manageCreateEdit(context, FORM_ACTION.CREATE,
                                    viewModel, null);
                              },
                              child: Text('Agregar'),
                            ),
                            SizedBox(height: 10),
                            TableWidget(
                              columnWidth: 20,
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
                                      ViewUtils.buildTableCell(
                                          ViewUtils.formatDate(
                                              e.inspectionDate!)),
                                      ViewUtils.buildTableCell(
                                          e.employee?.name),
                                      ViewUtils.buildTableCell(
                                          '${e.vehicle?.brand?.description} - ${e.vehicle?.model?.description}'),
                                      ViewUtils.buildTableCell(e.client?.name),
                                      ViewUtils.buildTableCell(
                                          e.hasScratches! ? 'Si' : 'No'),
                                      ViewUtils.buildTableCell(
                                          ViewUtils.getFuelQuantityText(
                                              e.fuelQuantity!)),
                                      ViewUtils.buildTableCell(
                                          e.hasSpareTire! ? 'Si' : 'No'),
                                      ViewUtils.buildTableCell(
                                          e.hasManualJack! ? 'Si' : 'No'),
                                      ViewUtils.buildTableCell(
                                          e.hasGlassBreakage! ? 'Si' : 'No'),
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
      ListInspectionViewModel viewModel, Inspection? data) async {
    data?.inspectionType = InspectionType.IN;
    var response = await fluent.showDialog<Inspection?>(
      context: context,
      builder: (context) {
        return CreateEditInspection(
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
    await fluent.showDialog<Inspection?>(
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
