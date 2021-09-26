import 'package:form_field_validator/form_field_validator.dart';

var passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required.'),
  MinLengthValidator(4, errorText: 'Password must be at least 4 digits long.'),
  // PatternValidator(r'(?=.*?[#?!@$%^&*-])',
  //     errorText: 'Passwords must have at least one special character.')
]);

var emailValidator = MultiValidator([
  RequiredValidator(errorText: 'Email is required.'),
  EmailValidator(errorText: "Please enter a valid email.")
]);
