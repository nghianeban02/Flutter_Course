import 'package:flutter/material.dart';

import '../../core/components/app_back_button.dart';
import 'components/faq_item.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Điều khoản và điều kiện'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            TitleAndParagraph(
                isTitleHeadline: true,
                title:
                    'Điều khoản và điều kiện của ứng dụng Kara Shop được bắt đầu áp dụng từ 01/04/2024:',
                paragraph:
                    '''Điều khoản và điều kiện của ứng dụng Kara Shop được thiết lập như sau:'''),
            TitleAndParagraph(
                isTitleHeadline: false,
                title: '1. Hợp đồng',
                paragraph:
                    '''Các điều khoản và điều kiện này tạo thành hợp đồng giữa bạn (người mua) và Kara Shop.
Hợp đồng áp dụng cho việc mua thiết bị, giấy phép phần mềm và các dịch vụ được ghi rõ trong các tài liệu đặt hàng của Kara Shop.
Nếu đơn đặt hàng của bạn bao gồm phần mềm, các điều khoản của thỏa thuận giấy phép người dùng cuối (EULA) cũng áp dụng và được ưu tiên so với các điều khoản khác.
Các điều khoản khác nhau hoặc khác với các điều khoản này chỉ áp dụng nếu cả hai bên đồng ý bằng văn bản.'''),
            TitleAndParagraph(
                isTitleHeadline: false,
                title: '2. Cấp phép phần mềm:',
                paragraph:
                    '''Kara Shop cấp cho bạn quyền sử dụng phần mềm không độc quyền, không tái cấp phép và không thể chuyển nhượng cho mục đích nội bộ.
Bạn không được thiết kế ngược, dịch ngược hoặc tháo rời phần mềm đã được cấp phép.'''),
            TitleAndParagraph(
                isTitleHeadline: false,
                title: '3. Báo giá và giá công bố:',
                paragraph:
                    '''Báo giá và ưu đãi bán hàng tự động hết hạn sau 30 ngày kể từ ngày ban hành.
Giá công bố có thể thay đổi mà không cần thông báo.'''),
            TitleAndParagraph(
                isTitleHeadline: false,
                title: '4. Chính sách đổi/trả hàng:',
                paragraph:
                    '''Điều kiện đổi/trả hàng được quy định cụ thể trong chính sách của Kara Shop.'''),
            TitleAndParagraph(
                isTitleHeadline: false,
                title: '5. Chính sách hoàn tiền:',
                paragraph:
                    '''Hoàn tiền được thực hiện theo quy định của Kara Shop.        '''),
          ],
        ),
      ),
    );
  }
}
