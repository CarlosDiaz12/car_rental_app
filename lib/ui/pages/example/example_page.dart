import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/repository/example_repository.dart';
import 'package:flutter_movies_app/ui/pages/example/example_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExampleViewModel>.nonReactive(
        viewModelBuilder: () => ExampleViewModel(
              repository: Provider.of<ExampleRepository>(context),
            ),
        builder: (context, viewModel, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Example Page'),
            ),
            body: Column(
              children: [
                Text('Example Page'),
                ElevatedButton(
                  onPressed: () {
                    //viewModel.hello();
                  },
                  child: Text('Call API'),
                ),
              ],
            ),
          );
        });
  }
}
