import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FieldValidator {
  static String? validateDoB(String? value) {
    if (value!.isEmpty) {
      return "please select date of birth";
    }
    return null;
  }

  static String? validateEmpty(String? value) {
    if (value!.trim().isEmpty) {
      return 'Field is required';
    } else if (value.startsWith(' ')) {
      return 'Name should not start with spaces';
    }

    return null;
  }

  static String? validateEmptyAndZero(String? value) {
    if (value!.isEmpty) {
      return 'This field is required.';
    }

    if (double.tryParse(value) == 0) {
      return 'Value cannot be zero.';
    }

    return null;
  }

  static String? validateMonthUses(String? value) {
    if (value!.isEmpty) {
      return 'Field is required';
    } else if (value == "0") {
      return "Uses should be greater than 0";
    }
    return null;
  }

  static String? validateId(String? value) {
    if (value!.isEmpty) {
      return "please enter your ID Number";
    }
    Pattern pattern = r'^[0-9]{13}$';
    if (!RegExp(pattern.toString()).hasMatch(value)) {
      return "valid ID number required please try again";
    }
    if (value.length == 13) {
      bool valid = checkIDNumberValid(value);
      if (valid) {
        return null;
      } else {
        return "valid ID number required please try again";
      }
    }
    return null;
  }

  static String? validateMemberTitle(String? value) {
    if (value!.trim().isEmpty) {
      return 'Enter membership title';
    } else if (value.startsWith(' ')) {
      return 'Name should not start with spaces';
    }
    return null;
  }

  // static String? validateMemberTitle(String? value) {
  //   if (value!.trim().isEmpty) {
  //     return 'Enter membership title';
  //   }
  //   return null;
  // }

  static bool checkIDNumberValid(String value) {
    List<int> arr = value.characters.map((e) => int.parse(e)).toList();
    int sum = 0;
    int n = arr.length;
    for (int i = 1; i < n; i = i + 2) {
      var v = arr[n - 1 - i] * 2;
      if (v > 9) {
        arr[n - 1 - i] = v - 9;
      } else {
        arr[n - 1 - i] = v;
      }
    }
    for (var i = 0; i < n; i++) {
      sum = sum + arr[i];
    }

    if (sum % 10 == 0) {
      return true;
    } else {
      return false;
    }
  }

  static String? validateOTP(String? value) {
    if (value!.isEmpty) {
      return "invalid otp";
    }
    if (value.length < 6) {
      return "please enter the otp";
    }
    Pattern pattern = r'^[0-9]{6}$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value.trim())) {
      return "invalid otp";
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'please enter your name';
    }
    if (!RegExp(r'^[^\s]+(\s+[^\s]+)*$').hasMatch(value)) {
      return "invalid name";
    }
    return null;
  }

  static String? validateBranchName(String? value) {
    if (value!.isEmpty) {
      return 'please enter branch name';
    }
    if (!RegExp(r'^[^\s]+(\s+[^\s]+)*$').hasMatch(value)) {
      return "invalid name";
    }
    return null;
  }

  static String? validateSurName(String? value) {
    if (value!.isEmpty) {
      return 'please enter your surname';
    }
    if (!RegExp(r'^[^\s]+(\s+[^\s]+)*$').hasMatch(value)) {
      return "invalid surname";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "please enter your email address";
    }
    if (!RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(value)) {
      return "valid email address required please try again";
    }
    return null;
  }

  static String? validateBranchEmail(String? value) {
    if (value!.isEmpty) {
      return "please enter branch email address";
    }
    if (!RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(value)) {
      return "valid email address required please try again";
    }
    return null;
  }

  static String? validateEmptyField(String? value) {
    if (value!.isEmpty) {
      return "field cant be empty";
    } else if (value.startsWith(' ')) {
      return 'Name should not start with spaces';
    }
    return null;
  }

  static String? validateYourEmployerName(String? value) {
    if (value!.isEmpty) {
      return 'please enter your employer name';
    }
    if (!RegExp(r'^[^\s]+(\s+[^\s]+)*$').hasMatch(value)) {
      return "invalid name";
    }
    return null;
  }

  static String? validateEmploymentStartDate(String? value) {
    if (value!.isEmpty) {
      return 'please select your employment start date';
    }
    return null;
  }

  static String? validatePayDay(String? value) {
    if (value!.isEmpty) {
      return 'please select your salary pay day';
    }
    return null;
  }

  static String? validateYearPick(String? value) {
    if (value!.isEmpty) {
      return 'please enter the period';
    }
    //// make check with age
    if (value.toString() == '2030') {
      return "the years account open exceeds your age";
    }
    return null;
  }

  static String? validateAccountNumber(String? value) {
    if (value!.isEmpty) {
      return 'account number is required';
    }
    return null;
  }

  static String? validateBankUserName(String? value) {
    if (value!.isEmpty) {
      return 'bank username is required';
    }
    return null;
  }

  static String? validateDayOfWeek(String? value) {
    if (value!.isEmpty) {
      return 'please select days';
    }
    return null;
  }

  static String? validateWeeksOfTheMonth(String? value) {
    if (value?.isEmpty ?? true) {
      return 'please select weeks';
    }
    return null;
  }

  static String? validatePickDay(String? value) {
    if (value!.isEmpty) {
      return 'please select a day';
    }
    return null;
  }

  static String? validatePickYears(String? value) {
    if (value!.isEmpty) {
      return 'please select years';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "please enter password";
    }
    if (value.length < 8) {
      return "password should contain at least eight character";
    }
    if (!RegExp(r"^(?=.*[A-Za-z@#$])(?=.*\d).{8,}$").hasMatch(value)) {
      return "password should be alphanumeric";
    }
    if (!RegExp(r"([A-Z])").hasMatch(value)) {
      return "password should have capital alphabet";
    }

    if (!RegExp(r'^(?=.*?[!@#$%^&*()_+\-=\[\]{}€÷×;:"\\|,.<>\/?])')
        .hasMatch(value.trim())) {
      return "password should 1 special character";
    }

    return null;
  }

  static String? validateOldPassword(String? value, String? pwd) {
    if (value!.isEmpty) {
      return "please enter your password";
    }
    if (value != pwd) {
      return "Password doesnt match";
    }
    return null;
  }

  static String? validateBankPassword(String? value) {
    if (value!.isEmpty) {
      return "please enter your password";
    }
    return null;
  }

  static String? validateGrossIncome(String? value) {
    if (value!.isEmpty) {
      return 'gross income is required';
    }
    if (double.parse(value.replaceAll("R ", "").replaceAll(",", "")) < 500) {
      return 'gross income must be greater than 500';
    }

    return null;
  }

  static String? validateNetIncome(String value, String value2) {
    if (value.isEmpty) {
      return 'net income is required';
    }

    if (value2.isEmpty) {
      return 'gross income is required';
    }

    if (double.parse(value.replaceAll("R ", "").replaceAll(",", "")) < 500) {
      return 'net income must be greater than 500';
    }

    if (double.parse(value.replaceAll("R ", "").replaceAll(",", "")) >
        double.parse(value2.replaceAll("R ", "").replaceAll(",", ""))) {
      return 'your net income must be lower than your gross income';
    }
    return null;
  }

  static String? validateMonthlyExpense(String? value) {
    if (value!.isEmpty) {
      return 'monthly expense is required';
    }
    if (double.parse(value.replaceAll("R ", "").replaceAll(",", "")) < 500) {
      return 'monthly expense must be greater than 500';
    }
    return null;
  }

  static String? validateStreetName(String? value) {
    if (value!.isEmpty) {
      return 'please enter your street name';
    }
    return null;
  }

  static String? validateStreetNumber(String? value) {
    if (value!.isEmpty) {
      return 'please enter your street number';
    }
    return null;
  }

  static String? validateLocation(String? value) {
    if (value!.isEmpty) {
      return 'please enter your location';
    }
    return null;
  }

  static String? validateSubrub(String? value) {
    if (value!.isEmpty) {
      return 'please enter your suburb';
    }
    return null;
  }

  static String? validatePostalCode(String? value) {
    if (value!.isEmpty) {
      return 'please enter your post code';
    }
    return null;
  }

  static String? validateContactPreference(String? value) {
    if (value!.isEmpty) {
      return 'please select your contact preference';
    }
    return null;
  }

  static String? validatePurposeLoan(String? value) {
    if (value!.isEmpty) {
      return 'please select a purpose of loan option';
    }
    return null;
  }

  static String? validateNumber(String? value) {
    if (value!.isEmpty) {
      return 'number is required';
    }
    return null;
  }

  static String? phoneNumber(String? value) {
    if (value!.isEmpty) {
      return 'Phone Number is Required';
    } else if (value.length > 20) {
      return "Phone number must be less than 20 digits";
    }
    if (!RegExp(r"(?:[+0]9)?[0-9]{10}$").hasMatch(value)) {
      return 'Please enter valid phone number';
    }

    return null;
  }
}

class PercentageInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final double? parsedValue = double.tryParse(newValue.text);
    if (parsedValue == null) {
      return oldValue; // Rejects the change if it's not a valid number
    }
    if (parsedValue < 0) {
      return const TextEditingValue(
        text: '0', // Sets the value to 0 if it's less than 0
        selection: TextSelection.collapsed(offset: 1),
      );
    } else if (parsedValue > 100) {
      return const TextEditingValue(
        text: '100.00', // Sets the value to 100 if it's greater than 100
        selection: TextSelection.collapsed(offset: 6),
      );
    }
    return newValue; // Accepts the change if it's within the range
  }
}
