String? validateEmail(String value) {
  late String pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[gmail,yahoo,cloud]+.com";
  RegExp regex =  RegExp(pattern);
  if (!regex.hasMatch(value) || value.isEmpty) {
    return 'Enter a valid email address';
  }
  return null;
}