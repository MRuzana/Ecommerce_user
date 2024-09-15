class Validator{

  static String? validateUsername(String? value){
    if(value == null || value.isEmpty){
      return 'Name is required';
    }
    return null;
  }

  static String? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return 'Email is required';
    }
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");
    if(!emailRegExp.hasMatch(value)){
      return 'Invalid email address';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value){
    final phoneNumberRegExp = RegExp(r"^(?:\+91)?[0-9]{10}$");
     if(value == null || value.isEmpty){
      return 'Phone number is required';
    }
   if(!phoneNumberRegExp.hasMatch(value)){
      return 'Invalid phone number';
    }
    return null;
  }

  static String? validatePassword(String? value){
     if(value == null || value.isEmpty){
      return 'Password is required';
    }
    if(value.length < 6){
      return 'password must be atleast 6 charecters long';
    }
    if(!value.contains(RegExp(r'[A-Z]'))){
      return 'password must contain atleast one uppercase letter';
    }
    if(!value.contains(RegExp(r'[0-9]'))){
      return 'password must contain atleast one number';
    }
    return null;
  }

  static String? validateCheckbox(bool value) {
    if (!value) {
      return 'You must agree to the terms to continue';
    }
    return null;
  }
  
  static String? validatePin(String? value){
    if(value == null || value.isEmpty){
      return 'Pin is required';
    }
    final pinRegExp = RegExp(r"^\d{6}$");
    if(!pinRegExp.hasMatch(value)){
      return 'Invalid pin';
    }
    return null;
  }

  static String? validateAddress(String? value){
    if(value == null || value.isEmpty){
      return 'Address is required';
    }
    return null;
  }
  
  static String? validateState(String? value){
    if(value == null || value.isEmpty){
      return 'State is required';
    }
    return null;
  }

  static String? validate(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return '$fieldName is required';
  }
  return null;
}
}