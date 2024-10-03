import 'package:flutter/material.dart';

import '../../core/components/app_back_button.dart';
import '../../core/constants/app_defaults.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Về chúng tôi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Về chúng tôi',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text(
                '''Kara Shop là một cửa hàng chuyên về thực phẩm khô, nơi bạn có thể tìm thấy những sản phẩm ngon và bổ dưỡng. Chúng tôi tự hào cung cấp các loại thực phẩm khô không chất bảo quản, đảm bảo an toàn cho sức khỏe của bạn.

Dưới đây là một số sản phẩm thực phẩm khô mà Kara Shop cung cấp:

Chà bông heo: Giá 160.000 ₫.
Chuối lát sấy giòn: Giá 55.000 ₫.
Khô bò miếng: Giá 125.000 ₫.
Khô cá chạch: Giá 530.000 ₫.
Lạp xưởng heo tươi: Giá 205.000 ₫.
Hãy ghé thăm Kara Shop để khám phá thêm nhiều sản phẩm thực phẩm khô hấp dẫn khác. Chúng tôi cam kết cung cấp hàng chất lượng, uy tín và đáng tin cậy cho khách hàng. Mua sắm trực tuyến tại đây với giá rẻ và dịch vụ giao hàng tận nơi!''')
          ],
        ),
      ),
    );
  }
}
