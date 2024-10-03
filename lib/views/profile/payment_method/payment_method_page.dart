import 'package:flutter/material.dart';
import '../../../core/constants/app_defaults.dart';
import '../../../core/components/app_back_button.dart';
import 'components/payment_option_tile.dart';
import '../../../core/constants/constants.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Phương thức thanh toán',style: TextStyle(fontSize: 17),),
      ),
      body: Column(
        children: [
          const SizedBox(height: AppDefaults.padding),
          
          PaymentOptionTile(
            icon: 'https://i.imgur.com/aRJj3iU.png',
            label: 'Thanh toán khi nhận hàng',
            accountName: '',
            onTap: () {},
          ),
          PaymentOptionTile(
            icon: 'https://upload.wikimedia.org/wikipedia/vi/f/fe/MoMo_Logo.png',
            label: 'Momo',
            accountName: '',
            onTap: () {},
          ),
          PaymentOptionTile(
            icon: 'https://icons.veryicon.com/png/Business/Business/Credit%20cards.png',
            label: 'Thẻ tín dụng',
            accountName: '',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
