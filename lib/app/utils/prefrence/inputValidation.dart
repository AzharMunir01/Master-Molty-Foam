class InputValidation{


  static String emailValidation(String val){
    if (val == "") {
      return "Please Enter email";
    } else if(!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(val)) {
      return "Email format is not valid";
    } else {
      return '';
    }
  }

  // static String numberValidation(String val){
  //   if (val == "") {
  //     return "Please enter phone number";
  //   } else if(val.length != 10) {
  //     return "Phone number is not valid";
  //   } else {
  //     return '';
  //   }
  // }
  static bool numberValidation(String number) {
    // Define the regex pattern for validating mobile numbers
    final RegExp regex = RegExp(r"^((\+92)?(0092)?(92)?(0)?)(3)([0-9]{9})$");

    // Check if the number matches the regex pattern
    return regex.hasMatch(number);
  }
  static String cnicValidation(String val){
    if (val == "") {
      return "Please enter cnic";
    } else if(val.length != 15 && val.length < 6) {
      return "Cnic is not valid";
    }else if (!isValidCNIC(val) || val.length > 15){
      return 'Cnic format XXXXX-XXXXXXX-X';
    } else {
      return '';
    }
  }


  static bool isValidCNIC(String cnic) {
    RegExp check = RegExp("^[0-9]{5}-[0-9]{7}-[0-9]{1}");
    bool valid = false;
    valid = check.hasMatch(cnic);
    return valid;
  }

}