import 'package:flutter/material.dart';

class DateField extends StatefulWidget {
  final void Function(DateTime?)? onChange;
  final String? hintText;
  final DateTime? initialValue;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final BoxDecoration? decoration;

  const DateField(
      {super.key,
      this.onChange,
      this.hintText,
      this.initialValue,
      this.decoration, this.firstDate, this.lastDate});

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialValue;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.initialValue,
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.firstDate ?? DateTime(2100),
    );

    setState(() {
      selectedDate = pickedDate;
      if (widget.onChange != null) widget.onChange!(selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration = widget.decoration ??
        BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.all(Radius.circular(10)));
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 10,
      children: <Widget>[
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
            decoration: decoration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedDate == null
                      ? widget.hintText ?? "Sélectionner une date"
                      : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DateFormField extends FormField<DateTime> {
  DateFormField({
    super.key,
    super.onSaved,
    required getValue,
    required widget,
    DateTime? initialValue,
    BoxDecoration? decoration,
    String? Function(DateTime?)? validator,
    String? hintText,
  }) : super(
          initialValue: initialValue,
          validator: validator,
          builder: (FormFieldState<DateTime> state) {
            if (state.hasError) {
              decoration = decoration?.copyWith(
                      border: Border.all(color: Colors.redAccent)) ??
                  BoxDecoration(
                      border: Border.all(color: Colors.redAccent),
                      borderRadius: BorderRadius.all(Radius.circular(10)));
            } else {
              decoration = decoration?.copyWith(
                  border: Border.all(color: Colors.black87)) ??
                  BoxDecoration(
                      border: Border.all(color: Colors.black87),
                      borderRadius: BorderRadius.all(Radius.circular(10)));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DateField(
                  decoration: decoration,
                  initialValue: initialValue,
                  hintText: hintText,
                  onChange: (value) {
                    state.didChange(value);
                    if (validator != null) validator(value);
                    if (widget.onChange != null) {
                      widget.onChange!(widget.name, value);
                    }
                  },
                ),
                if (state.hasError) // Affichage de l'erreur si elle existe
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 12),
                    child: Text(
                      state.errorText!,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            );
          },
        );
}
