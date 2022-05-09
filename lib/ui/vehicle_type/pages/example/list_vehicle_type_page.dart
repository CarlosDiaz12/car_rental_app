import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/repository/vehicle_type_repository.dart';
import 'package:flutter_movies_app/ui/vehicle_type/pages/example/list_vehicle_type_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class ListVehicleTypePage extends StatelessWidget {
  const ListVehicleTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListVehicleTypeViewModel>.nonReactive(
        viewModelBuilder: () => ListVehicleTypeViewModel(
              repository: Provider.of<VehicleTypeRepository>(context),
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
                    viewModel.loadData();
                  },
                  child: Text('Call API'),
                ),
              ],
            ),
          );
        });
  }
}
