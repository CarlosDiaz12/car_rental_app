import 'package:auto_route/auto_route.dart';
import 'package:car_rental_app/domain/enums/work_shift.dart';
import 'package:car_rental_app/domain/models/employee.dart';
import 'package:car_rental_app/ui/common/widgets/labeled_flied_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../../../domain/enums/form_action_enum.dart';
import '../../../common/view_utils.dart';

class CreateEditEmployee extends StatefulWidget {
  final FORM_ACTION action;
  final Employee? data;
  CreateEditEmployee({
    Key? key,
    required this.action,
    this.data,
  }) : super(key: key);

  @override
  State<CreateEditEmployee> createState() => _CreateEditEmployeeState();
}

class _CreateEditEmployeeState extends State<CreateEditEmployee> {
  final formData = Employee(status: true, hireDate: DateTime.now());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var title = widget.action == FORM_ACTION.CREATE ? 'Crear' : 'Editar';
    var labelStyle = FluentTheme.of(context).typography.body?.copyWith(
          fontWeight: FontWeight.bold,
        );
    return ContentDialog(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.60,
        maxWidth: MediaQuery.of(context).size.width * 0.65,
      ),
      title: Text('$title Empleado',
          style: FluentTheme.of(context).typography.subtitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
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
                        label: 'Nombre',
                        child: TextFormBox(
                          initialValue: widget.action == FORM_ACTION.CREATE
                              ? formData.name
                              : widget.data?.name,
                          onSaved: ((newValue) {
                            if (widget.action == FORM_ACTION.CREATE) {
                              formData.name = newValue;
                            } else {
                              widget.data?.name = newValue;
                            }
                          }),
                          placeholder: 'Nombre',
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
                        label: 'Cedula',
                        child: TextFormBox(
                          inputFormatters: [
                            ViewUtils.numericInputFormatter(),
                            ViewUtils.getIdentificationNumberMask()
                          ],
                          initialValue: widget.action == FORM_ACTION.CREATE
                              ? formData.idCard
                              : widget.data?.idCard,
                          onSaved: ((newValue) {
                            if (widget.action == FORM_ACTION.CREATE) {
                              formData.idCard = newValue;
                            } else {
                              widget.data?.idCard = newValue;
                            }
                          }),
                          placeholder: 'Cedula',
                          validator: (String? text) {
                            print(text?.replaceAll('-', '').length);
                            if (text == null || text.isEmpty)
                              return 'Requerido';
                            if ((text.replaceAll('-', '').length < 11) ||
                                !ViewUtils.isValidIdNumber(text))
                              return 'Cedula no valida';
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: LabeledFieldWidget(
                        label: 'Tanda Laboral',
                        child: Combobox<int>(
                          placeholder: Text('Selecciona'),
                          isExpanded: true,
                          items: WorkShift.values
                              .map((e) => ComboboxItem<int>(
                                    value: e.index,
                                    child: Text(ViewUtils.getWorkShiftText(e)),
                                  ))
                              .toList(),
                          value: widget.action == FORM_ACTION.CREATE
                              ? formData.workShift?.index
                              : widget.data?.workShift?.index,
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                if (widget.action == FORM_ACTION.CREATE) {
                                  formData.workShift = WorkShift.values[value];
                                } else {
                                  widget.data?.workShift =
                                      WorkShift.values[value];
                                }
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: LabeledFieldWidget(
                        label: 'Porciento Comision',
                        child: TextFormBox(
                          inputFormatters: [ViewUtils.numericInputFormatter()],
                          initialValue: widget.action == FORM_ACTION.CREATE
                              ? formData.comissionPercentage == null
                                  ? null
                                  : formData.comissionPercentage.toString()
                              : widget.data?.comissionPercentage.toString(),
                          onSaved: ((newValue) {
                            if (newValue != null) {
                              double value = double.parse(newValue);
                              if (widget.action == FORM_ACTION.CREATE) {
                                formData.comissionPercentage = value;
                              } else {
                                widget.data?.comissionPercentage = value;
                              }
                            }
                          }),
                          placeholder: 'Porciento Comision',
                          validator: (String? text) {
                            if (text == null || text.isEmpty || text == '0.0')
                              return 'Requerido';
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: DatePicker(
                        header: 'Fecha Ingreso',
                        headerStyle: labelStyle,
                        selected: widget.action == FORM_ACTION.CREATE
                            ? formData.hireDate!
                            : widget.data!.hireDate!,
                        onChanged: (value) => {
                          setState(
                            () {
                              if (widget.action == FORM_ACTION.CREATE) {
                                formData.hireDate = value;
                              } else {
                                widget.data?.hireDate = value;
                              }
                            },
                          )
                        },
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Checkbox(
                        content: Text('Estado'),
                        checked: widget.action == FORM_ACTION.CREATE
                            ? formData.status
                            : widget.data?.status,
                        onChanged: (value) => {
                          setState(
                            () {
                              if (widget.action == FORM_ACTION.CREATE) {
                                formData.status = value;
                              } else {
                                widget.data?.status = value;
                              }
                            },
                          )
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
      actions: [
        Button(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              var resultData =
                  widget.action == FORM_ACTION.CREATE ? formData : widget.data;
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
