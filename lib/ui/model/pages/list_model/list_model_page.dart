import 'package:auto_route/auto_route.dart';
import 'package:car_rental_app/domain/models/model.dart';
import 'package:car_rental_app/domain/repository/brand_repository_abstract.dart';
import 'package:car_rental_app/domain/repository/model_repository_abstract.dart';
import 'package:car_rental_app/ui/model/pages/list_model/list_model_viewmodel.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../domain/enums/form_action_enum.dart';
import '../../../common/view_utils.dart';
import '../../../common/widgets/error_banner.dart';
import '../../../common/widgets/table_widget.dart';
import '../create_edit_model/create_edit_model.dart';

class ListModelPage extends StatelessWidget {
  const ListModelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListModelViewModel>.reactive(
      viewModelBuilder: () => ListModelViewModel(
          brandRepository: Provider.of<BrandRepositoryAbstract>(context),
          repository: Provider.of<ModelRepositoryAbstract>(context)),
      onModelReady: (viewModel) async {
        await viewModel.loadData();
        await viewModel.loadBrandData();
      },
      builder: (context, viewModel, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ScaffoldPage(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            header: PageHeader(
              leading: Text(
                'Modelos',
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
                                      ViewUtils.buildTableCell(
                                          e.brand?.description),
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
      ListModelViewModel viewModel, Model? data) async {
    var response = await fluent.showDialog<Model?>(
      context: context,
      builder: (context) {
        return CreateEditModel(
          brandList: viewModel.brandList!,
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
      await AutoRouter.of(context).pop();

      var exception = viewModel.error(viewModel.createEditResponse);
      if (exception != null) {
        var error = exception as BaseException;
        _showValidationMessage(context, error.cause);
      } else {
        viewModel.loadData();
      }
    }
  }

  void _showValidationMessage(BuildContext context, String message) {
    fluent.showDialog(
      context: context,
      builder: (context) {
        return ContentDialog(
          title: Text('Informacion'),
          content: Text(message),
          actions: [
            Button(
              child: Text('Ok'),
              onPressed: () {
                AutoRouter.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Future<void> _showLoading(BuildContext context) async {
    await fluent.showDialog<Model?>(
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
