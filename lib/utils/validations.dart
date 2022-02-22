class Validations {
  static String validateEmpty(String input, String hint) {
    if (input.isEmpty)
      return "Please enter " + hint;
    else
      return "";
  }

  static String validateName(String input, String hint) {
    Pattern pattern = '[a-zA-Z]';
    RegExp regex = new RegExp(pattern);

    if (input.isEmpty)
      return "Please enter " + hint;
    else if (input.length < 2)
      return "Please enter valid " + hint;
    else if (!regex.hasMatch(input))
      return "Please enter valid " + hint;
    else
      return "";
  }

  static String validateEmail(String input, String hint) {
    if (validateEmpty(input, hint).isEmpty) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(input))
        return "Please enter valid " + hint;
      else
        return "";
    } else
      return "Please enter " + hint;
  }

  static String validateMobile(String input, String hint) {
    if (input.isEmpty || input.length <= 7) {
      return "Please enter valid " + hint;
    } else {
      return "";
    }
  }

  static String validateUserName(String input, String hint) {
    if (input.isEmpty) {
      return "Please enter " + hint;
    } else if (isMobileNumber(input)) {
      return validateMobile(input, hint);
    } else {
      return validateEmail(input, hint);
    }
  }

  static String validatePassword(String input, String hint) {
    if (input.isEmpty) {
      return "Please enter " + hint;
    } else if (input.length < 8 || input.length > 16) {
      return "Password must be between 8-16 characters";
    } else {
      return "";
    }
  }

  static String validateCVV(String input, String hint) {
    if (input.isEmpty || input.length < 3) {
      return "Invalid " + hint;
    } else {
      return "";
    }
  }

  static String cardExpiryDate(String input, String hint) {
    var split = input.split('/');

    if (input.isEmpty) {
      return "Please enter " + hint;
    } else if (int.parse(split[0]) >= 13) {
      return "Enter valid date ";
    } else if (input.length != 7) {
      return "Enter valid date ";
    } else {
      return "";
    }
  }

  static String validatecardNumber(String input, String hint) {
    if (input.isEmpty) {
      return "Please enter " + hint;
    } else if (input.length != 19) {
      return "Please enter valide number";
    } else {
      return "";
    }
  }

  static bool iscardNumberValid(String value) {
    RegExp regex = RegExp(r'^-?[0-9]+$');
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  static bool isMobileNumber(String value) {
    RegExp regex = RegExp(r'^-?[0-9]+$');
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }
}
