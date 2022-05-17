import 'package:car_rental_app/ui/common/layout/layout_page_viewmodel.dart';
import 'package:car_rental_app/ui/common/viewmodels/user_state_viewmodel.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<UserStateViewModel>(
              builder: (context, user, _) => Text(
                'Bienvenid@ ${user.currentUser?.name ?? 'Desconocido'}',
                style: FluentTheme.of(context).typography.title,
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 300,
              height: 40,
              child: FilledButton(
                child: Center(
                  child: Text(
                    'Iniciar',
                    style: FluentTheme.of(context).typography.title?.copyWith(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                  ),
                ),
                onPressed: () {
                  Provider.of<LayoutPageViewModel>(context, listen: false)
                      .changePageIndex(1);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
