import 'package:auto_route/auto_route.dart';
import 'package:car_rental_app/domain/models/vehicle.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../../../domain/enums/form_action_enum.dart';

class CreateEditVehicle extends StatefulWidget {
  final FORM_ACTION action;
  final Vehicle? data;
  CreateEditVehicle({
    Key? key,
    required this.action,
    this.data,
  }) : super(key: key);

  @override
  State<CreateEditVehicle> createState() => _CreateEditVehicleState();
}

class _CreateEditVehicleState extends State<CreateEditVehicle> {
  final formData = Vehicle(status: true);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var title = widget.action == FORM_ACTION.CREATE ? 'Crear' : 'Editar';
    return ContentDialog(
      title: Text('$title Vehiculo',
          style: FluentTheme.of(context).typography.subtitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormBox(
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
