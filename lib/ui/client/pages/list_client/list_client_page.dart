import 'package:auto_route/auto_route.dart';
import 'package:car_rental_app/domain/models/client.dart';
import 'package:car_rental_app/domain/repository/client_repository_abstract.dart';
import 'package:car_rental_app/ui/client/pages/list_client/list_client_viewmodel.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../../domain/enums/form_action_enum.dart';
import '../../../common/view_utils.dart';
import '../../../common/widgets/error_banner.dart';
import '../../../common/widgets/table_widget.dart';
import '../create_edit_client/create_edit_client.dart';

class ListClientPage extends StatelessWidget {
  const ListClientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListClientViewModel>.reactive(
      viewModelBuilder: () => ListClientViewModel(
          repository: Provider.of<ClientRepositoryAbstract>(context)),
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
                'Clientes',
                style: FluentTheme.of(context).typography.title!,
              ),
            ),
            content: SingleChildScrollView(
              child: viewModel.busy(viewModel.list)
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
                              columnWidth: 24,
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
                                      ViewUtils.buildTableCell(e.name),
                                      ViewUtils.buildTableCell(
                                          e.identificationCard),
                                      ViewUtils.buildTableCell(e.creditLimit),
                                      ViewUtils.buildTableCell(
                                          e.creditCardNumber),
                                      ViewUtils.buildTableCell(
                                          ViewUtils.getTaxPayerText(
                                              e.taxPayerType!)),
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
      ListClientViewModel viewModel, Client? data) async {
    var response = await fluent.showDialog<Client?>(
      context: context,
      builder: (context) {
        return CreateEditClient(
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
    await fluent.showDialog<Client?>(
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
