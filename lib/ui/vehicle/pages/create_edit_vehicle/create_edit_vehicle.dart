import 'package:auto_route/auto_route.dart';
import 'package:car_rental_app/domain/models/brand.dart';
import 'package:car_rental_app/domain/models/fuel_type.dart';
import 'package:car_rental_app/domain/models/vehicle.dart';
import 'package:car_rental_app/domain/models/vehicle_type.dart';
import 'package:car_rental_app/ui/common/view_utils.dart';
import 'package:fluent_ui/fluent_ui.dart';
import '../../../../domain/enums/form_action_enum.dart';
import '../../../../domain/models/model.dart';

// ignore: must_be_immutable
class CreateEditVehicle extends StatefulWidget {
  final FORM_ACTION action;
  final Vehicle? data;
  List<VehicleType> vehicleTypes;
  List<Brand> brandList;
  List<Model> modelList;
  List<FuelType> fuelTypeList;
  CreateEditVehicle({
    Key? key,
    this.data,
    required this.action,
    required this.vehicleTypes,
    required this.brandList,
    required this.modelList,
    required this.fuelTypeList,
  }) : super(key: key);

  @override
  State<CreateEditVehicle> createState() => _CreateEditVehicleState();
}

class _CreateEditVehicleState extends State<CreateEditVehicle> {
  final formData = Vehicle(status: true);
  final formKey = GlobalKey<FormState>();
  late List<Model> modelListFiltered = [];
  @override
  void initState() {
    if (widget.action == FORM_ACTION.UPDATE) {
      filterModels(widget.data!.brandId!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var title = widget.action == FORM_ACTION.CREATE ? 'Crear' : 'Editar';
    return ContentDialog(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.50,
        maxWidth: MediaQuery.of(context).size.width * 0.62,
      ),
      title: Text('$title Vehiculo',
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
                      child: TextFormBox(
                        initialValue: widget.action == FORM_ACTION.CREATE
                            ? formData.description
                            : widget.data?.description,
                        onSaved: ((newValue) {
                          if (widget.action == FORM_ACTION.CREATE) {
                            formData.description = newValue;
                          } else {
                            widget.data?.description = newValue;
                          }
                        }),
                        placeholder: 'Descripcion',
                        validator: (String? text) {
                          if (text == null || text.isEmpty) return 'Requerido';
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Combobox<int>(
                        placeholder: Text('Marca'),
                        isExpanded: true,
                        items: widget.brandList
                            .map((e) => ComboboxItem<int>(
                                  value: e.id,
                                  child: Text('${e.description}'),
                                ))
                            .toList(),
                        value: widget.action == FORM_ACTION.CREATE
                            ? formData.brandId
                            : widget.data?.brandId,
                        onChanged: (value) {
                          setState(() {
                            if (value != null) {
                              if (widget.action == FORM_ACTION.CREATE) {
                                formData.brandId = value;
                              } else {
                                widget.data?.brandId = value;
                              }
                              filterModels(value);
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextFormBox(
                        inputFormatters: [ViewUtils.numericInputFormatter()],
                        initialValue: widget.action == FORM_ACTION.CREATE
                            ? formData.chassisNumber == null
                                ? null
                                : formData.chassisNumber.toString()
                            : widget.data?.chassisNumber.toString(),
                        onSaved: ((newValue) {
                          if (newValue != null) {
                            int value = int.parse(newValue);
                            if (widget.action == FORM_ACTION.CREATE) {
                              formData.chassisNumber = value;
                            } else {
                              widget.data?.chassisNumber = value;
                            }
                          }
                        }),
                        placeholder: 'No. Chasis',
                        validator: (String? text) {
                          if (text == null || text.isEmpty || text == '0')
                            return 'Requerido';
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextFormBox(
                        inputFormatters: [ViewUtils.numericInputFormatter()],
                        initialValue: widget.action == FORM_ACTION.CREATE
                            ? formData.engineNumber == null
                                ? null
                                : formData.engineNumber.toString()
                            : widget.data?.engineNumber.toString(),
                        onSaved: ((newValue) {
                          if (newValue != null) {
                            int value = int.parse(newValue);
                            if (widget.action == FORM_ACTION.CREATE) {
                              formData.engineNumber = value;
                            } else {
                              widget.data?.engineNumber = value;
                            }
                          }
                        }),
                        placeholder: 'No. Motor',
                        validator: (String? text) {
                          if (text == null || text.isEmpty || text == '0')
                            return 'Requerido';
                          return null;
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
                    SizedBox(
                      width: 200,
                      child: TextFormBox(
                        inputFormatters: [ViewUtils.numericInputFormatter()],
                        initialValue: widget.action == FORM_ACTION.CREATE
                            ? formData.plateNumber == null
                                ? null
                                : formData.plateNumber.toString()
                            : widget.data?.plateNumber.toString(),
                        onSaved: ((newValue) {
                          if (newValue != null) {
                            int value = int.parse(newValue);
                            if (widget.action == FORM_ACTION.CREATE) {
                              formData.plateNumber = value;
                            } else {
                              widget.data?.plateNumber = value;
                            }
                          }
                        }),
                        placeholder: 'No. Placa',
                        validator: (String? text) {
                          if (text == null || text.isEmpty || text == '0')
                            return 'Requerido';
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Combobox<int>(
                          placeholder: Text('Tipo vehiculo'),
                          isExpanded: true,
                          items: widget.vehicleTypes
                              .map((e) => ComboboxItem<int>(
                                    value: e.id,
                                    child: Text('${e.description}'),
                                  ))
                              .toList(),
                          value: widget.action == FORM_ACTION.CREATE
                              ? formData.vehicleTypeId
                              : widget.data?.vehicleTypeId,
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                if (widget.action == FORM_ACTION.CREATE) {
                                  formData.vehicleTypeId = value;
                                } else {
                                  widget.data?.vehicleTypeId = value;
                                }
                              }
                            });
                          }),
                    ),
                    SizedBox(
                      width: 200,
                      child: Combobox<int>(
                          placeholder: Text('Modelo'),
                          isExpanded: true,
                          items: modelListFiltered
                              .map((e) => ComboboxItem<int>(
                                    value: e.id,
                                    child: Text('${e.description}'),
                                  ))
                              .toList(),
                          value: widget.action == FORM_ACTION.CREATE
                              ? formData.modelId
                              : widget.data?.modelId,
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                if (widget.action == FORM_ACTION.CREATE) {
                                  formData.modelId = value;
                                } else {
                                  widget.data?.modelId = value;
                                }
                              }
                            });
                          }),
                    ),
                    SizedBox(
                      width: 200,
                      child: Combobox<int>(
                          placeholder: Text('Tipo Combustible'),
                          isExpanded: true,
                          items: widget.fuelTypeList
                              .map((e) => ComboboxItem<int>(
                                    value: e.id,
                                    child: Text('${e.description}'),
                                  ))
                              .toList(),
                          value: widget.action == FORM_ACTION.CREATE
                              ? formData.fuelTypeId
                              : widget.data?.fuelTypeId,
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                if (widget.action == FORM_ACTION.CREATE) {
                                  formData.fuelTypeId = value;
                                } else {
                                  widget.data?.fuelTypeId = value;
                                }
                              }
                            });
                          }),
                    ),
                  ],
                ),
                SizedBox(height: 5),
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

  void filterModels(int brandSelected) {
    var list = widget.modelList.where((e) => e.brandId == brandSelected);
    modelListFiltered = list.toList();
  }
}
