import 'package:flutter/material.dart';
import 'package:car_rental_app/data/repository/vehicle_type_repository.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'list_vehicle_type_viewmodel.dart';

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
