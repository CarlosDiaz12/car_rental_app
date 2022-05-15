import 'package:auto_route/auto_route.dart';
import 'package:car_rental_app/domain/enums/inspection_type.dart';
import 'package:car_rental_app/domain/models/rent.dart';
import 'package:car_rental_app/ui/rent/pages/list_rent/list_rent_viewmodel.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../../../domain/dto/check_vehicle_availability_dto.dart';
import '../../../../domain/enums/form_action_enum.dart';
import '../../../../domain/models/client.dart';
import '../../../../domain/models/employee.dart';
import '../../../../domain/models/vehicle.dart';
import '../../../common/view_utils.dart';
import '../../../common/widgets/labeled_flied_widget.dart';

class CreateEditRent extends StatefulWidget {
  final FORM_ACTION action;
  final Rent? data;
  final List<Vehicle> vehicleList;
  final List<Client> clientList;
  final List<Employee> employeeList;
  final ListRentViewModel viewModel;

  const CreateEditRent({
    Key? key,
    this.data,
    required this.viewModel,
    required this.action,
    required this.vehicleList,
    required this.clientList,
    required this.employeeList,
  }) : super(key: key);

  @override
  State<CreateEditRent> createState() => _CreateEditRentState();
}

class _CreateEditRentState extends State<CreateEditRent> {
  final formData = Rent(
    status: true,
    returned: false,
    rentDate: DateTime.now(),
    returnDate: DateTime.now(),
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
      title: Text('$title Renta',
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
                      SizedBox(width: 200),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: DatePicker(
                          headerStyle: labelStyle,
                          header: 'Fecha Renta',
                          selected: widget.action == FORM_ACTION.CREATE
                              ? formData.rentDate!
                              : widget.data!.rentDate!,
                          onChanged: (value) => {
                            setState(
                              () {
                                if (widget.action == FORM_ACTION.CREATE) {
                                  formData.rentDate = value;
                                } else {
                                  widget.data?.rentDate = value;
                                }
                              },
                            )
                          },
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: DatePicker(
                          headerStyle: labelStyle,
                          header: 'Fecha Devolucion',
                          selected: widget.action == FORM_ACTION.CREATE
                              ? formData.returnDate!
                              : widget.data!.returnDate!,
                          onChanged: (value) => {
                            setState(
                              () {
                                if (widget.action == FORM_ACTION.CREATE) {
                                  formData.returnDate = value;
                                } else {
                                  widget.data?.returnDate = value;
                                }
                              },
                            )
                          },
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Checkbox(
                          content: Text(
                            'Devuelto',
                            style: labelStyle,
                          ),
                          checked: widget.action == FORM_ACTION.CREATE
                              ? formData.returned
                              : widget.data?.returned,
                          onChanged: (value) => {
                            setState(() {
                              if (widget.action == FORM_ACTION.CREATE) {
                                // formData.returned = value;
                              } else {
                                widget.data?.returned = value;
                              }
                            })
                          },
                        ),
                      ),
                      SizedBox(width: 200),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: LabeledFieldWidget(
                          label: 'Comentario',
                          child: TextFormBox(
                            initialValue: widget.action == FORM_ACTION.CREATE
                                ? formData.comment
                                : widget.data?.comment,
                            onSaved: ((newValue) {
                              if (widget.action == FORM_ACTION.CREATE) {
                                formData.comment = newValue;
                              } else {
                                widget.data?.comment = newValue;
                              }
                            }),
                            placeholder: 'Comentario',
                            validator: (String? text) {
                              if (text == null || text.isEmpty)
                                return 'Requerido';
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: LabeledFieldWidget(
                          label: 'Monto por Dia',
                          child: TextFormBox(
                            inputFormatters: [
                              ViewUtils.numericInputFormatter()
                            ],
                            initialValue: widget.action == FORM_ACTION.CREATE
                                ? formData.ratePerDay == null
                                    ? null
                                    : formData.ratePerDay.toString()
                                : widget.data?.ratePerDay.toString(),
                            onSaved: ((newValue) {
                              if (newValue != null) {
                                double value = double.parse(newValue);
                                if (widget.action == FORM_ACTION.CREATE) {
                                  formData.ratePerDay = value;
                                } else {
                                  widget.data?.ratePerDay = value;
                                }
                              }
                            }),
                            placeholder: 'Monto x Dia',
                            validator: (String? text) {
                              if (text == null || text.isEmpty || text == '0')
                                return 'Requerido';
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: LabeledFieldWidget(
                          label: 'Cantidad de Dias',
                          child: TextFormBox(
                            inputFormatters: [
                              ViewUtils.numericInputFormatter()
                            ],
                            initialValue: widget.action == FORM_ACTION.CREATE
                                ? formData.daysQuantity == null
                                    ? null
                                    : formData.daysQuantity.toString()
                                : widget.data?.daysQuantity.toString(),
                            onSaved: ((newValue) {
                              if (newValue != null) {
                                int value = int.parse(newValue);
                                if (widget.action == FORM_ACTION.CREATE) {
                                  formData.daysQuantity = value;
                                } else {
                                  widget.data?.daysQuantity = value;
                                }
                              }
                            }),
                            placeholder: 'Cantidad de dias',
                            validator: (String? text) {
                              if (text == null || text.isEmpty || text == '0')
                                return 'Requerido';
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 200),
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
              inspectionDate: resultData.rentDate!,
              type: InspectionType.IN,
            ));

            if (formKey.currentState!.validate() &&
                resultData.clientId != null &&
                resultData.employeeId != null &&
                resultData.vehicleId != null &&
                inspected) {
              formKey.currentState?.save();
              AutoRouter.of(context).pop(resultData);
            } else {
              var message = !inspected
                  ? 'Este vehiculo necesita inspeccion.'
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
