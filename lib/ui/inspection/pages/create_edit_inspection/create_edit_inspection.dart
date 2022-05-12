import 'package:auto_route/auto_route.dart';
import 'package:car_rental_app/domain/enums/fuel_quantity.dart';
import 'package:car_rental_app/domain/models/client.dart';
import 'package:car_rental_app/domain/models/employee.dart';
import 'package:car_rental_app/domain/models/inspection.dart';
import 'package:car_rental_app/domain/models/vehicle.dart';
import 'package:car_rental_app/ui/common/view_utils.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../../../domain/enums/form_action_enum.dart';

class CreateEditInspection extends StatefulWidget {
  final FORM_ACTION action;
  final Inspection? data;
  final List<Vehicle> vehicleList;
  final List<Client> clientList;
  final List<Employee> employeeList;
  CreateEditInspection({
    Key? key,
    this.data,
    required this.action,
    required this.vehicleList,
    required this.clientList,
    required this.employeeList,
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
  );
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var title = widget.action == FORM_ACTION.CREATE ? 'Crear' : 'Editar';
    return ContentDialog(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.50,
        maxWidth: MediaQuery.of(context).size.width * 0.62,
      ),
      title: Text('$title Inspeccion',
          style: FluentTheme.of(context).typography.subtitle),
      content: Column(
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
                      child: Combobox<int>(
                        placeholder: Text('Vehiculo'),
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
                    SizedBox(
                      width: 200,
                      child: Combobox<int>(
                        placeholder: Text('Cliente'),
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
                    SizedBox(
                      width: 200,
                      child: Combobox<int>(
                        placeholder: Text('Empleado'),
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
                    SizedBox(
                      width: 200,
                      child: Combobox<int>(
                        placeholder: Text('Cant. Comb.'),
                        isExpanded: true,
                        items: FuelQuantity.values
                            .map((e) => ComboboxItem<int>(
                                  value: e.index,
                                  child: Text(ViewUtils.getFuelQuantityText(e)),
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
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Checkbox(
                      content: Text('Ralladuras'),
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
                      content: Text('Tiene Repuesta'),
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
                      content: Text('Tiene Gato'),
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
                      content: Text('Rotura Cristal'),
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
                SizedBox(
                  width: 200,
                  child: DatePicker(
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
                SizedBox(height: 20),
                Checkbox(
                  content: Text('Estado'),
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
      actions: [
        Button(
          onPressed: () {
            var resultData =
                widget.action == FORM_ACTION.CREATE ? formData : widget.data;
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              AutoRouter.of(context).pop(resultData);
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
}
