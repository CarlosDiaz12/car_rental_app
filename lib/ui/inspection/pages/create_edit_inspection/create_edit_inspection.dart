import 'package:auto_route/auto_route.dart';
import 'package:car_rental_app/domain/enums/fuel_quantity.dart';
import 'package:car_rental_app/domain/enums/inspection_type.dart';
import 'package:car_rental_app/domain/models/client.dart';
import 'package:car_rental_app/domain/models/employee.dart';
import 'package:car_rental_app/domain/models/inspection.dart';
import 'package:car_rental_app/domain/models/vehicle.dart';
import 'package:car_rental_app/ui/common/view_utils.dart';
import 'package:car_rental_app/ui/common/widgets/labeled_flied_widget.dart';
import 'package:car_rental_app/ui/inspection/pages/list_inspection/list_inspection_viewmodel.dart';
import 'package:fluent_ui/fluent_ui.dart';
import '../../../../domain/dto/check_vehicle_availability_dto.dart';
import '../../../../domain/enums/form_action_enum.dart';

class CreateEditInspection extends StatefulWidget {
  final FORM_ACTION action;
  final Inspection? data;
  final List<Vehicle> vehicleList;
  final List<Client> clientList;
  final List<Employee> employeeList;
  final ListInspectionViewModel viewModel;
  CreateEditInspection({
    Key? key,
    this.data,
    required this.action,
    required this.vehicleList,
    required this.clientList,
    required this.employeeList,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<CreateEditInspection> createState() => _CreateEditInspectionState();
}

class _CreateEditInspectionState extends State<CreateEditInspection> {
  final formData = Inspection(
    status: true,
    inspectionDate: DateTime.now(),
    hasSpareTire: false,
    hasManualJack: false,
    hasGlassBreakage: false,
    hasScratches: false,
    firstTireCondition: false,
    secondTireCondition: false,
    thirdTireCondition: false,
    fourthTireCondition: false,
    inspectionType: InspectionType.IN,
  );
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var title = widget.action == FORM_ACTION.CREATE ? 'Crear' : 'Editar';
    var labelStyle = FluentTheme.of(context).typography.body?.copyWith(
          fontWeight: FontWeight.bold,
        );

    return ContentDialog(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.70,
        maxWidth: MediaQuery.of(context).size.width * 0.62,
      ),
      title: Text('$title Inspeccion',
          style: FluentTheme.of(context).typography.subtitle),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: LabeledFieldWidget(
                          label: 'Vehiculo',
                          child: Combobox<int>(
                            placeholder: Text('Selecciona'),
                            isExpanded: true,
                            items: widget.vehicleList
                                .map((e) => ComboboxItem<int>(
                                      value: e.id,
                                      child: Text(
                                          '${e.brand?.description} ${e.model?.description}'),
                                    ))
                                .toList(),
                            value: widget.action == FORM_ACTION.CREATE
                                ? formData.vehicleId
                                : widget.data?.vehicleId,
                            onChanged: (value) {
                              setState(() {
                                if (value != null) {
                                  if (widget.action == FORM_ACTION.CREATE) {
                                    formData.vehicleId = value;
                                  } else {
                                    widget.data?.vehicleId = value;
                                  }
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: LabeledFieldWidget(
                          label: 'Cliente',
                          child: Combobox<int>(
                            placeholder: Text('Selecciona'),
                            isExpanded: true,
                            items: widget.clientList
                                .map((e) => ComboboxItem<int>(
                                      value: e.id,
                                      child: Text('${e.name}'),
                                    ))
                                .toList(),
                            value: widget.action == FORM_ACTION.CREATE
                                ? formData.clientId
                                : widget.data?.clientId,
                            onChanged: (value) {
                              setState(() {
                                if (value != null) {
                                  if (widget.action == FORM_ACTION.CREATE) {
                                    formData.clientId = value;
                                  } else {
                                    widget.data?.clientId = value;
                                  }
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: LabeledFieldWidget(
                          label: 'Empleado',
                          child: Combobox<int>(
                            placeholder: Text('Selecciona'),
                            isExpanded: true,
                            items: widget.employeeList
                                .map((e) => ComboboxItem<int>(
                                      value: e.id,
                                      child: Text('${e.name}'),
                                    ))
                                .toList(),
                            value: widget.action == FORM_ACTION.CREATE
                                ? formData.employeeId
                                : widget.data?.employeeId,
                            onChanged: (value) {
                              setState(() {
                                if (value != null) {
                                  if (widget.action == FORM_ACTION.CREATE) {
                                    formData.employeeId = value;
                                  } else {
                                    widget.data?.employeeId = value;
                                  }
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: LabeledFieldWidget(
                          label: 'C. Combustible',
                          child: Combobox<int>(
                            placeholder: Text('Selecciona'),
                            isExpanded: true,
                            items: FuelQuantity.values
                                .map((e) => ComboboxItem<int>(
                                      value: e.index,
                                      child: Text(
                                          ViewUtils.getFuelQuantityText(e)),
                                    ))
                                .toList(),
                            value: widget.action == FORM_ACTION.CREATE
                                ? formData.fuelQuantity?.index
                                : widget.data?.fuelQuantity?.index,
                            onChanged: (value) {
                              setState(() {
                                if (value != null) {
                                  if (widget.action == FORM_ACTION.CREATE) {
                                    formData.fuelQuantity =
                                        FuelQuantity.values[value];
                                  } else {
                                    widget.data?.fuelQuantity =
                                        FuelQuantity.values[value];
                                  }
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Checkbox(
                        content: Text(
                          'Ralladuras',
                          style: labelStyle,
                        ),
                        checked: widget.action == FORM_ACTION.CREATE
                            ? formData.hasScratches
                            : widget.data?.hasScratches,
                        onChanged: (value) => {
                          setState(() {
                            if (widget.action == FORM_ACTION.CREATE) {
                              formData.hasScratches = value;
                            } else {
                              widget.data?.hasScratches = value;
                            }
                          })
                        },
                      ),
                      Checkbox(
                        content: Text(
                          'Tiene Repuesta',
                          style: labelStyle,
                        ),
                        checked: widget.action == FORM_ACTION.CREATE
                            ? formData.hasSpareTire
                            : widget.data?.hasSpareTire,
                        onChanged: (value) => {
                          setState(() {
                            if (widget.action == FORM_ACTION.CREATE) {
                              formData.hasSpareTire = value;
                            } else {
                              widget.data?.hasSpareTire = value;
                            }
                          })
                        },
                      ),
                      Checkbox(
                        content: Text(
                          'Tiene Gato',
                          style: labelStyle,
                        ),
                        checked: widget.action == FORM_ACTION.CREATE
                            ? formData.hasManualJack
                            : widget.data?.hasManualJack,
                        onChanged: (value) => {
                          setState(() {
                            if (widget.action == FORM_ACTION.CREATE) {
                              formData.hasManualJack = value;
                            } else {
                              widget.data?.hasManualJack = value;
                            }
                          })
                        },
                      ),
                      Checkbox(
                        content: Text(
                          'Rotura Cristal',
                          style: labelStyle,
                        ),
                        checked: widget.action == FORM_ACTION.CREATE
                            ? formData.hasGlassBreakage
                            : widget.data?.hasGlassBreakage,
                        onChanged: (value) => {
                          setState(() {
                            if (widget.action == FORM_ACTION.CREATE) {
                              formData.hasGlassBreakage = value;
                            } else {
                              widget.data?.hasGlassBreakage = value;
                            }
                          })
                        },
                      ),
                      SizedBox(width: 150),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Estado Gomas', style: labelStyle),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        content: Text(
                          'Izquierda Frontal',
                        ),
                        checked: widget.action == FORM_ACTION.CREATE
                            ? formData.firstTireCondition
                            : widget.data?.firstTireCondition,
                        onChanged: (value) => {
                          setState(() {
                            if (widget.action == FORM_ACTION.CREATE) {
                              formData.firstTireCondition = value;
                            } else {
                              widget.data?.firstTireCondition = value;
                            }
                          })
                        },
                      ),
                      Checkbox(
                        content: Text(
                          'Derecha Frontal',
                        ),
                        checked: widget.action == FORM_ACTION.CREATE
                            ? formData.secondTireCondition
                            : widget.data?.secondTireCondition,
                        onChanged: (value) => {
                          setState(() {
                            if (widget.action == FORM_ACTION.CREATE) {
                              formData.secondTireCondition = value;
                            } else {
                              widget.data?.secondTireCondition = value;
                            }
                          })
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        content: Text(
                          'Izquierda Trasera',
                        ),
                        checked: widget.action == FORM_ACTION.CREATE
                            ? formData.thirdTireCondition
                            : widget.data?.thirdTireCondition,
                        onChanged: (value) => {
                          setState(() {
                            if (widget.action == FORM_ACTION.CREATE) {
                              formData.thirdTireCondition = value;
                            } else {
                              widget.data?.thirdTireCondition = value;
                            }
                          })
                        },
                      ),
                      Checkbox(
                        content: Text(
                          'Derecha Trasera',
                        ),
                        checked: widget.action == FORM_ACTION.CREATE
                            ? formData.fourthTireCondition
                            : widget.data?.fourthTireCondition,
                        onChanged: (value) => {
                          setState(() {
                            if (widget.action == FORM_ACTION.CREATE) {
                              formData.fourthTireCondition = value;
                            } else {
                              widget.data?.fourthTireCondition = value;
                            }
                          })
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*
                      SizedBox(
                        width: 200,
                        child: LabeledFieldWidget(
                          label: 'Tipo Inspeccion',
                          child: Combobox<int>(
                            placeholder: Text('Selecciona'),
                            isExpanded: true,
                            items: InspectionType.values
                                .map((e) => ComboboxItem<int>(
                                      value: e.index,
                                      child: Text(
                                          ViewUtils.getInspectionTypeText(e)),
                                    ))
                                .toList(),
                            value: widget.action == FORM_ACTION.CREATE
                                ? formData.inspectionType?.index
                                : widget.data?.inspectionType?.index,
                            onChanged: (value) {
                              setState(() {
                                if (value != null) {
                                  if (widget.action == FORM_ACTION.CREATE) {
                                    formData.inspectionType =
                                        InspectionType.values[value];
                                  } else {
                                    widget.data?.inspectionType =
                                        InspectionType.values[value];
                                  }
                                }
                              });
                            },
                          ),
                        ),
                      ),                  
                      SizedBox(width: 15),
                      */
                      SizedBox(
                        width: 200,
                        child: DatePicker(
                          headerStyle: labelStyle,
                          header: 'Fecha Inspeccion',
                          selected: widget.action == FORM_ACTION.CREATE
                              ? formData.inspectionDate!
                              : widget.data!.inspectionDate!,
                          onChanged: (value) => {
                            setState(
                              () {
                                if (widget.action == FORM_ACTION.CREATE) {
                                  formData.inspectionDate = value;
                                } else {
                                  widget.data?.inspectionDate = value;
                                }
                              },
                            )
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Checkbox(
                    content: Text(
                      'Estado',
                      style: labelStyle,
                    ),
                    checked: widget.action == FORM_ACTION.CREATE
                        ? formData.status
                        : widget.data?.status,
                    onChanged: (value) => {
                      setState(() {
                        if (widget.action == FORM_ACTION.CREATE) {
                          formData.status = value;
                        } else {
                          widget.data?.status = value;
                        }
                      })
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
      actions: [
        Button(
          onPressed: () async {
            var resultData =
                (widget.action == FORM_ACTION.CREATE ? formData : widget.data)!;
            var inspected = await widget.viewModel
                .checkAvailability(CheckVehicleAvailabilityDto(
              clientId: resultData.clientId!,
              vehicleId: resultData.vehicleId!,
              inspectionDate: resultData.inspectionDate!,
              type: resultData.inspectionType!,
            ));

            if (resultData.clientId != null &&
                resultData.employeeId != null &&
                resultData.vehicleId != null &&
                resultData.fuelQuantity != null &&
                !inspected) {
              AutoRouter.of(context).pop(resultData);
            } else {
              var message = inspected
                  ? 'Actualmente existe una inspeccion de tipo: ${ViewUtils.getInspectionTypeText(resultData.inspectionType!)} para este vehiculo, cliente y fecha.'
                  : 'Complete los campos requeridos.';
              _showValidationMessage(context, message);
            }
          },
          child: Text('Aceptar'),
        ),
        Button(
          onPressed: () {
            AutoRouter.of(context).pop();
          },
          child: Text('Cancelar'),
        )
      ],
    );
  }

  void _showValidationMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return ContentDialog(
          title: Text('Informacion'),
          content: Text(message),
          actions: [
            Button(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }
}
