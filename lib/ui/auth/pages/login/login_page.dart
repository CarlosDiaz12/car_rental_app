import 'package:auto_route/auto_route.dart';
import 'package:car_rental_app/core/config/routing/routes.gr.dart';
import 'package:car_rental_app/core/error/exceptions.dart';
import 'package:car_rental_app/domain/repository/auth_repository_abstract.dart';
import 'package:car_rental_app/ui/auth/pages/login/login_viewmodel.dart';
import 'package:car_rental_app/ui/common/widgets/labeled_flied_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart' as material;
import '../../../common/viewmodels/user_state_viewmodel.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(
              authRepository: Provider.of<AuthRepositoryAbstract>(context),
            ),
        builder: (context, viewModel, _) {
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
                      color: material.Colors.black12,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlutterLogo(size: 100),
                          Text(
                            'Car Rental App',
                            style: FluentTheme.of(context).typography.title,
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 7,
                    child: Center(
                      child: Column(
                        children: [
                          Spacer(),
                          Image.asset('assets/images/vehicle_logo.png',
                              width: 300),
                          SizedBox(height: 40),
                          Form(
                            key: viewModel.formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 300,
                                  child: LabeledFieldWidget(
                                    label: 'Usuario',
                                    child: TextFormBox(
                                      controller: viewModel.userNameCtrl,
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
                                      controller: viewModel.passwordCtrl,
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
                          SizedBox(
                            width: 300,
                            child: FilledButton(
                              child: Text('Ingresar'),
                              onPressed: viewModel.isBusy
                                  ? null
                                  : () async {
                                      if (viewModel.formKey.currentState!
                                          .validate()) {
                                        var userName =
                                            viewModel.userNameCtrl.text;
                                        var password =
                                            viewModel.passwordCtrl.text;
                                        var response = await viewModel.login(
                                            userName, password);
                                        if (response != null) {
                                          // go to next page
                                          Provider.of<UserStateViewModel>(
                                                  context,
                                                  listen: false)
                                              .setCurrentUser(response);
                                          AutoRouter.of(context)
                                              .push(NavigationRoute());
                                        } else {
                                          var error = viewModel.modelError
                                              as BaseException;
                                          _showValidationMessage(
                                              context, error.cause);
                                        }
                                      }
                                    },
                            ),
                          ),
                          if (viewModel.isBusy)
                            Container(
                              width: 300,
                              child: ProgressBar(),
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
              },
            )
          ],
        );
      },
    );
  }
}
