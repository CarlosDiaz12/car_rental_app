import 'package:auto_route/auto_route.dart';
import 'package:car_rental_app/domain/models/model.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../../../domain/enums/form_action_enum.dart';
import '../../../../domain/models/brand.dart';

class CreateEditModel extends StatefulWidget {
  final FORM_ACTION action;
  final List<Brand> brandList;
  final Model? data;
  CreateEditModel({
    Key? key,
    required this.brandList,
    required this.action,
    this.data,
  }) : super(key: key);

  @override
  State<CreateEditModel> createState() => _CreateEditModelState();
}

class _CreateEditModelState extends State<CreateEditModel> {
  final formData = Model(status: true);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var title = widget.action == FORM_ACTION.CREATE ? 'Crear' : 'Editar';
    return ContentDialog(
      title: Text('$title Modelo',
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
                SizedBox(height: 5),
                Combobox<int>(
                    placeholder: Text('Selecciona el modelo'),
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
                        }
                      });
                    }),
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
                ),
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
            if (formKey.currentState!.validate() &&
                resultData?.brandId != null) {
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
