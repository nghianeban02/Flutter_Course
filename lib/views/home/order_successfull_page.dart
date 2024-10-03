import 'package:flutter/material.dart';

import '../../core/components/network_image.dart';
import '../../core/constants/app_defaults.dart';
import '../../../core/routes/app_routes.dart';

class OrderSuccessfullPage extends StatelessWidget {
  const OrderSuccessfullPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(flex: 2),
          Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: const AspectRatio(
                aspectRatio: 1 / 1,
                child: NetworkImageWithLoader(
                  'https://i.imgur.com/Fj9gVGy.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: Column(
              children: [
                Text(
                  'Đơn hàng đã đặt thành công!',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppDefaults.padding),
                  child: Text(
                    'Cảm ơn bạn đã mua hàng tại Kara Shop\nChúng tôi sẽ liên hệ bạn trong thời gian sớm để xác nhận đơn hàng.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // UiUtil.openDialog(
                        //   context: context,
                        //   widget: const DeliverySuccessfullDialog(),
                        // );
                        Navigator.pushNamed(context, AppRoutes.entryPoint);
                      },
                      child: const Text('Tiếp tục mua hàng',style: TextStyle(fontSize: 17),),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDefaults.padding,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.myOrder);
                      },
                      child: const Text('Đơn hàng của tôi',style: TextStyle(fontSize: 15),),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
