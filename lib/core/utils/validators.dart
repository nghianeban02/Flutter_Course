import 'package:form_field_validator/form_field_validator.dart';

class Validators {
  /// Email Validator
  static final email = EmailValidator(errorText: 'Vui lòng nhập đúng định dạng email');
  // static final phone = RangeValidator(min:10,max:10, errorText: 'Số điện thoại tối thiểu phải từ 10 số trở lên');
  static final phone2 = MultiValidator([RequiredValidator(errorText: 'Không được bỏ trống'),RangeValidator(min:10,max:10, errorText: 'Số điện thoại phải đủ 10 số')]);

  /// Password Validator
  static final password = MultiValidator([
    RequiredValidator(errorText: 'Không được bỏ trống'),
    //Note: Nếu muốn xài thì bật cái này (LƯU Ý: Nhớ đổi mật khẩu cho hợp lệ với cái này)
    // MinLengthValidator(8, errorText: 'Mật khẩu phải ít nhất 8 ký tự trở lên'),
    // PatternValidator(r'(?=.*?[#?!@$%^&*-])',
    //     errorText: 'Mật khẩu phải có ít nhất 1 ký tự đặc biệt')
  ]);

  /// Required Validator with Optional Field Name
  static RequiredValidator requiredWithFieldName(String? fieldName) =>
      // RequiredValidator(errorText: '${fieldName ?? 'Field'} is required');
      RequiredValidator(errorText: 'Không được bỏ trống');

  /// Plain Required Validator
  static final required = RequiredValidator(errorText: 'Không được bỏ trống');
}
