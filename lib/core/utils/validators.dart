import 'package:form_field_validator/form_field_validator.dart';

class Validators {
  /// Email Validator
  static final email = MultiValidator([
    RequiredValidator(errorText: 'O email é obrigatório'),
    EmailValidator(errorText: 'Insira um endereço de e-mail válido')
  ]);

  /// Password Validator
  static final password = MultiValidator([
    RequiredValidator(errorText: 'A palavra-passe é necessária'),
    // MinLengthValidator(8,
    //     errorText: 'A palavra-passe deve ter, pelo menos, 8 dígitos'),
    // PatternValidator(r'(?=.*?[#?!@$%^&*-])',
    //     errorText: 'As senhas devem ter pelo menos um caractere especial')
  ]);

  /// Required Validator with Optional Field Name
  static RequiredValidator requiredWithFieldName(String? fieldName) =>
      RequiredValidator(errorText: '${fieldName ?? 'Field'} é obrigatório');

  /// Plain Required Validator
  static final required = RequiredValidator(errorText: 'Field é obrigatório');
}
