import 'package:auto_route/auto_route.dart';
import 'package:car_rental_app/domain/enums/tax_payer_type.dart';
import 'package:car_rental_app/domain/models/client.dart';
import 'package:car_rental_app/ui/common/widgets/labeled_flied_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../../../domain/enums/form_action_enum.dart';
import '../../../common/view_utils.dart';

class CreateEditClient extends StatefulWidget {
  final FORM_ACTION action;
  final Client? data;
  CreateEditClient({
    Key? key,
    required this.action,
    this.data,
  }) : super(key: key);

  @override
  State<CreateEditClient> createState() => _CreateEditClientState();
}

class _CreateEditClientState extends State<CreateEditClient> {
  final formData = Client(status: true);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var title = widget.action == FORM_ACTION.CREATE ? 'Crear' : 'Editar';
    return ContentDialog(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.60,
        maxWidth: MediaQuery.of(context).size.width * 0.65,
      ),
      title: Text('$title Cliente',
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
                              ? formData.identificationCard
                              : widget.data?.identificationCard,
                          onSaved: ((newValue) {
                            if (widget.action == FORM_ACTION.CREATE) {
                              formData.identificationCard = newValue;
                            } else {
                              widget.data?.identificationCard = newValue;
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
                        label: 'No. Tarjeta CR',
                        child: TextFormBox(
                          initialValue: widget.action == FORM_ACTION.CREATE
                              ? formData.creditCardNumber
                              : widget.data?.creditCardNumber,
                          onSaved: ((newValue) {
                            if (widget.action == FORM_ACTION.CREATE) {
                              formData.creditCardNumber = newValue;
                            } else {
                              widget.data?.creditCardNumber = newValue;
                            }
                          }),
                          placeholder: 'No. Tarjeta CR',
                          validator: (String? text) {
                            if (text == null || text.isEmpty)
                              return 'Requerido';
                            return null;
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
                        label: 'Limite Credito',
                        child: TextFormBox(
                          inputFormatters: [ViewUtils.numericInputFormatter()],
                          initialValue: widget.action == FORM_ACTION.CREATE
                              ? formData.creditLimit == null
                                  ? null
                                  : formData.creditLimit.toString()
                              : widget.data?.creditLimit.toString(),
                          onSaved: ((newValue) {
                            if (newValue != null) {
                              double value = double.parse(newValue);
                              if (widget.action == FORM_ACTION.CREATE) {
                                formData.creditLimit = value;
                              } else {
                                widget.data?.creditLimit = value;
                              }
                            }
                          }),
                          placeholder: 'Limite Credito',
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
                        label: 'Tipo Persona',
                        child: Combobox<int>(
                          placeholder: Text('Tipo Persona'),
                          isExpanded: true,
                          items: TaxPayerType.values
                              .map((e) => ComboboxItem<int>(
                                    value: e.index,
                                    child: Text(ViewUtils.getTaxPayerText(e)),
                                  ))
                              .toList(),
                          value: widget.action == FORM_ACTION.CREATE
                              ? formData.taxPayerType?.index
                              : widget.data?.taxPayerType?.index,
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                if (widget.action == FORM_ACTION.CREATE) {
                                  formData.taxPayerType =
                                      TaxPayerType.values[value];
                                } else {
                                  widget.data?.taxPayerType =
                                      TaxPayerType.values[value];
                                }
                              }
                            });
                          },
                        ),
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
                          setState(() {
                            if (widget.action == FORM_ACTION.CREATE) {
                              formData.status = value;
                            } else {
                              widget.data?.status = value;
                            }
                          })
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
