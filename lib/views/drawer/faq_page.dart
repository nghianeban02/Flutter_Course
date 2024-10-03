import 'package:flutter/material.dart';

import '../../core/components/app_back_button.dart';
import 'components/faq_item.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Câu hỏi thường gặp'),
      ),
      body: 
      const SingleChildScrollView(
        child: Column(
        children: [
          TitleAndParagraph(
              title: '1. Việc giao hàng diễn ra như thế nào?',
              paragraph:
                  '''Việc giao hàng tại Kara Shop được thực hiện theo các bước sau:

Đặt hàng: Khách hàng chọn sản phẩm và đặt hàng trực tuyến trên ứng dụng Kara Shop.
Xác nhận đơn hàng: Sau khi đơn hàng được đặt, hệ thống sẽ gửi xác nhận đơn hàng đến khách hàng qua email hoặc tin nhắn.
Chuẩn bị sản phẩm: Nhân viên Kara Shop sẽ chuẩn bị sản phẩm, đóng gói và kiểm tra chất lượng.
Giao hàng: Sản phẩm sẽ được giao đến địa chỉ mà khách hàng đã cung cấp. Thời gian giao hàng phụ thuộc vào địa điểm và phương thức giao hàng (ví dụ: giao hàng nhanh, giao hàng tiết kiệm).
Thanh toán: Khách hàng thanh toán tiền mặt hoặc qua các phương thức thanh toán trực tuyến (ví dụ: thẻ tín dụng, ví điện tử).
Hoàn tất giao dịch: Sau khi khách hàng nhận được sản phẩm và kiểm tra đúng với đơn hàng, giao dịch được hoàn tất.
Kara Shop cam kết cung cấp dịch vụ giao hàng nhanh chóng, an toàn và đảm bảo chất lượng cho khách hàng. Nếu bạn có bất kỳ câu hỏi hoặc cần hỗ trợ, vui lòng liên hệ với chúng tôi qua đây. '''),
          TitleAndParagraph(
              title: '2. Chính sách đổi trả  hàng.',
              paragraph:
                  '''Chính sách đổi/trả hàng tại Kara Shop được thiết lập như sau:

Đổi hàng:
Sản phẩm nguyên giá và giảm giá đến 30% có thể được đổi size/màu hoặc sản phẩm khác (nếu còn hàng). Áp dụng 1 đổi 1, đổi 1 lần/1 đơn hàng.
Tổng giá trị các mặt hàng muốn đổi phải có giá trị tương đương hoặc lớn hơn với mặt hàng trả lại.
Sản phẩm giảm giá trên 30% trở lên chỉ được đổi size (nếu còn hàng), áp dụng 1 đổi 1, đổi 1 lần/1 đơn hàng.
Sản phẩm không áp dụng đổi bao gồm: đồ lót và sản phẩm được tặng kèm trong các chương trình khách hàng đã mua hàng.
Điều kiện đổi sản phẩm:
Đổi hàng trong vòng 7 ngày kể từ ngày khách hàng nhận được sản phẩm.
Sản phẩm còn trong tình trạng ban đầu khi nhận hàng, còn nguyên tem và nhãn mác.
Sản phẩm chưa qua giặt ủi hoặc bẩn, chưa bị hư hỏng, không bị mùi lạ (nước hoa, cơ thể…), chưa qua sử dụng.
Khách hàng mang theo hóa đơn còn nguyên vẹn khi đổi hàng.
Trả hàng:
Khách hàng được trả sản phẩm trong trường hợp có lỗi phát sinh từ nhà sản xuất và không có nhu cầu đổi sang sản phẩm khác.
Các trường hợp lỗi do nhà sản xuất gồm: phai/loang màu, in bong tróc, lỗi đường may.
Hoàn tiền lại sản phẩm gặp lỗi qua tài khoản ngân hàng.
Pantio chịu 100% chi phí vận chuyển trả lại hàng nếu sản phẩm được xác định là lỗi sản phẩm.
Một hoặc một vài sản phẩm trong đơn hàng không thể giao cho khách, hoàn tiền 1 lại sản phẩm không giao được (áp dụng mua hàng online với thanh toán trả trước).
PANTIO xác minh lỗi từ 01 - 03 ngày sau khi nhận được sản phẩm và có phản hồi lại khách hàng thời gian xử lý tiếp theo với từng trường hợp cụ thể.
Chính sách hoàn tiền:
Đối với trường hợp thanh toán trước, khách hàng sẽ được hoàn tiền khi hàng nhận bị lỗi do sản xuất và khách hàng không có nhu cầu đổi sang sản phẩm khác.
Thời gian hoàn tiền từ 03 đến 05 ngày kể từ khi Pantio xác minh sản phẩm bị lỗi sản xuất.
Tiền được hoàn vào tài khoản cá nhân của khách hàng.'''),
        ],
      ),
      ),

//       const Column(
//         children: [
//           TitleAndParagraph(
//               title: '1. Việc giao hàng diễn ra như thế nào?',
//               paragraph:
//                   '''Việc giao hàng tại Kara Shop được thực hiện theo các bước sau:

// Đặt hàng: Khách hàng chọn sản phẩm và đặt hàng trực tuyến trên ứng dụng Kara Shop.
// Xác nhận đơn hàng: Sau khi đơn hàng được đặt, hệ thống sẽ gửi xác nhận đơn hàng đến khách hàng qua email hoặc tin nhắn.
// Chuẩn bị sản phẩm: Nhân viên Kara Shop sẽ chuẩn bị sản phẩm, đóng gói và kiểm tra chất lượng.
// Giao hàng: Sản phẩm sẽ được giao đến địa chỉ mà khách hàng đã cung cấp. Thời gian giao hàng phụ thuộc vào địa điểm và phương thức giao hàng (ví dụ: giao hàng nhanh, giao hàng tiết kiệm).
// Thanh toán: Khách hàng thanh toán tiền mặt hoặc qua các phương thức thanh toán trực tuyến (ví dụ: thẻ tín dụng, ví điện tử).
// Hoàn tất giao dịch: Sau khi khách hàng nhận được sản phẩm và kiểm tra đúng với đơn hàng, giao dịch được hoàn tất.
// Kara Shop cam kết cung cấp dịch vụ giao hàng nhanh chóng, an toàn và đảm bảo chất lượng cho khách hàng. Nếu bạn có bất kỳ câu hỏi hoặc cần hỗ trợ, vui lòng liên hệ với chúng tôi qua đây. '''),
//           TitleAndParagraph(
//               title: '2. Chính sách đổi trả  hàng.',
//               paragraph:
//                   '''Chính sách đổi/trả hàng tại Kara Shop được thiết lập như sau:

// Đổi hàng:
// Sản phẩm nguyên giá và giảm giá đến 30% có thể được đổi size/màu hoặc sản phẩm khác (nếu còn hàng). Áp dụng 1 đổi 1, đổi 1 lần/1 đơn hàng.
// Tổng giá trị các mặt hàng muốn đổi phải có giá trị tương đương hoặc lớn hơn với mặt hàng trả lại.
// Sản phẩm giảm giá trên 30% trở lên chỉ được đổi size (nếu còn hàng), áp dụng 1 đổi 1, đổi 1 lần/1 đơn hàng.
// Sản phẩm không áp dụng đổi bao gồm: đồ lót và sản phẩm được tặng kèm trong các chương trình khách hàng đã mua hàng.
// Điều kiện đổi sản phẩm:
// Đổi hàng trong vòng 7 ngày kể từ ngày khách hàng nhận được sản phẩm.
// Sản phẩm còn trong tình trạng ban đầu khi nhận hàng, còn nguyên tem và nhãn mác.
// Sản phẩm chưa qua giặt ủi hoặc bẩn, chưa bị hư hỏng, không bị mùi lạ (nước hoa, cơ thể…), chưa qua sử dụng.
// Khách hàng mang theo hóa đơn còn nguyên vẹn khi đổi hàng.
// Trả hàng:
// Khách hàng được trả sản phẩm trong trường hợp có lỗi phát sinh từ nhà sản xuất và không có nhu cầu đổi sang sản phẩm khác.
// Các trường hợp lỗi do nhà sản xuất gồm: phai/loang màu, in bong tróc, lỗi đường may.
// Hoàn tiền lại sản phẩm gặp lỗi qua tài khoản ngân hàng.
// Pantio chịu 100% chi phí vận chuyển trả lại hàng nếu sản phẩm được xác định là lỗi sản phẩm.
// Một hoặc một vài sản phẩm trong đơn hàng không thể giao cho khách, hoàn tiền 1 lại sản phẩm không giao được (áp dụng mua hàng online với thanh toán trả trước).
// PANTIO xác minh lỗi từ 01 - 03 ngày sau khi nhận được sản phẩm và có phản hồi lại khách hàng thời gian xử lý tiếp theo với từng trường hợp cụ thể.
// Chính sách hoàn tiền:
// Đối với trường hợp thanh toán trước, khách hàng sẽ được hoàn tiền khi hàng nhận bị lỗi do sản xuất và khách hàng không có nhu cầu đổi sang sản phẩm khác.
// Thời gian hoàn tiền từ 03 đến 05 ngày kể từ khi Pantio xác minh sản phẩm bị lỗi sản xuất.
// Tiền được hoàn vào tài khoản cá nhân của khách hàng.'''),
//         ],
//       ),
    );
  }
}
