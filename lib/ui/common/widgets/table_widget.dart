import 'package:fluent_ui/fluent_ui.dart';

class TableWidget extends StatelessWidget {
  final List<String> columnNames;
  final List<TableRow> rows;
  const TableWidget({Key? key, required this.columnNames, required this.rows})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: [
            ...columnNames.map(
              (e) => TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(
                  padding: EdgeInsets.only(left: 8),
                  height: 28,
                  child: Text(
                    e,
                    style: FluentTheme.of(context)
                        .typography
                        .subtitle
                        ?.copyWith(fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
        ...rows
      ],
    );
  }
}
