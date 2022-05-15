import 'package:fluent_ui/fluent_ui.dart';

class LabeledFieldWidget extends StatelessWidget {
  final Widget child;
  final String label;
  const LabeledFieldWidget({
    Key? key,
    required this.child,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 4.0),
          child: Text(
            label,
            style: FluentTheme.of(context).typography.body?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        child
      ],
    );
  }
}
