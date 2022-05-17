import 'package:car_rental_app/domain/models/rent.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ReportUtil {
  static Workbook createRentExcelFile(List<Rent> data) {
    List<String> columns = [
      'Id',
      'Empleado',
      'Vehiculo',
      'Cliente',
      'Fecha Renta',
      'Fecha Devolucion',
      'Monto x Dia',
      'Cant. Dias',
    ];
    // Create a new Excel Document.
    final Workbook workbook = Workbook();

    // Accessing sheet via index.
    final Worksheet sheet = workbook.worksheets[0];

    // insert title rows
    for (var i = 0; i < columns.length; i++) {
      var columnIndex = i + 1;
      var range = sheet.getRangeByIndex(1, columnIndex);
      range.setText(columns[i]);
      range.autoFitColumns();
      range.setBuiltInStyle(BuiltInStyles.heading4);
    }

    // insert data rows
    for (var i = 0; i < data.length; i++) {
      var rowIndex = i + 2;
      var rowData = data[i];
      // insert each column

      sheet.getRangeByIndex(rowIndex, 1)
        ..setText(rowData.id.toString())
        ..autoFitColumns();

      sheet.getRangeByIndex(rowIndex, 2)
        ..setText(rowData.employee!.name)
        ..autoFitColumns();

      sheet.getRangeByIndex(rowIndex, 3)
        ..setText(
            '${rowData.vehicle!.brand!.description} ${rowData.vehicle!.model!.description}')
        ..autoFitColumns();

      sheet.getRangeByIndex(rowIndex, 4)
        ..setText(rowData.client!.name)
        ..autoFitColumns();

      sheet.getRangeByIndex(rowIndex, 5)
        ..setText(rowData.rentDate!.toIso8601String())
        ..autoFitColumns();

      sheet.getRangeByIndex(rowIndex, 6)
        ..setText(rowData.returnDate!.toIso8601String())
        ..autoFitColumns();

      sheet.getRangeByIndex(rowIndex, 7)
        ..setText(rowData.ratePerDay.toString())
        ..autoFitColumns();

      sheet.getRangeByIndex(rowIndex, 8)
        ..setText(rowData.daysQuantity.toString())
        ..autoFitColumns();
    }

    return workbook;
  }
}
