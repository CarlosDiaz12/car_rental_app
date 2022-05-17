import 'package:car_rental_app/ui/auth/pages/login/login_viewmodel.dart';
import 'package:car_rental_app/ui/common/widgets/labeled_flied_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:stacked/stacked.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, viewModel, _) {
          final formKey = GlobalKey<FormState>();
          final userNameCtrl = TextEditingController();
          final passwordCtrl = TextEditingController();
          return ScaffoldPage(
            content: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      color: Colors.blue,
                    ),
                  ),
                  Flexible(
                    flex: 7,
                    child: Center(
                      child: Column(
                        children: [
                          Spacer(),
                          FlutterLogo(size: 100),
                          SizedBox(height: 40),
                          Flexible(
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 300,
                                    child: LabeledFieldWidget(
                                      label: 'Usuario',
                                      child: TextFormBox(
                                        controller: userNameCtrl,
                                        validator: (String? text) {
                                          if (text == null || text.isEmpty)
                                            return 'Requerido';
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  SizedBox(
                                    width: 300,
                                    child: LabeledFieldWidget(
                                      label: 'Contraseña',
                                      child: TextFormBox(
                                        controller: passwordCtrl,
                                        obscureText: true,
                                        validator: (String? text) {
                                          if (text == null || text.isEmpty)
                                            return 'Requerido';
                                          return null;
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            child: FilledButton(
                              child: Text('Ingresar'),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  var userName = userNameCtrl.text;
                                  var password = passwordCtrl.text;
                                }
                              },
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
