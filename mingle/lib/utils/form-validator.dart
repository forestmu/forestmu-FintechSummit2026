import 'package:multi_dropdown/multi_dropdown.dart' show DropdownItem;

class FormValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? isEmpty(String? value, String? type) {
    if (value == null || value.trim().isEmpty) return 'Please enter your $type';
    return null;
  }

  static String? isEmptyList(List<DropdownItem<String>>? value, String? type) {
    if (value == null || value.isEmpty) return 'Please enter your $type';
    return null;
  }
}