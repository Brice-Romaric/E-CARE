import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class MultiDropdownFormField<T extends Object> extends FormField<List<T>> {
  MultiDropdownFormField({
    super.key,
    super.onSaved,
    required widget,
    required getValue,
    required List<DropdownItem<T>> items,
    required MultiSelectController<T> controller,
    super.validator,
  }) : super(
          initialValue: items
              .where((item) => item.selected)
              .map((item) => item.value)
              .toList(),
          builder: (FormFieldState<List<T>> state) {
            return MultiDropdown<T>(
              items: items,
              controller: controller,
              singleSelect: !widget.selectMultiple,
              enabled: true,
              searchEnabled: true,
              chipDecoration: const ChipDecoration(
                backgroundColor: Colors.yellow,
                wrap: true,
                runSpacing: 2,
                spacing: 10,
              ),
              fieldDecoration: FieldDecoration(
                hintText: widget.placeholder,
                hintStyle: const TextStyle(color: Colors.black87),
                prefixIcon: widget.leading,
                suffixIcon: widget.trailing,
                showClearIcon: false,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.black87,
                  ),
                ),
              ),
              dropdownDecoration: const DropdownDecoration(
                marginTop: 2,
                maxHeight: 500,
              ),
              dropdownItemDecoration: DropdownItemDecoration(
                selectedIcon: const Icon(Icons.check_box, color: Colors.green),
                disabledIcon: Icon(Icons.lock, color: Colors.grey.shade300),
              ),
              validator: widget.validator,
              onSelectionChange: (value) {
                state.didChange(value);
                if (widget.onChange != null) {
                  widget.onChange!(widget.name, getValue(value));
                }
              },
            );
          },
        );
}
