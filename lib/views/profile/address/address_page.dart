import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/components/app_back_button.dart';
import '../../../core/components/app_radio.dart';
import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text(
          'Địa chỉ đã lưu',
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(AppDefaults.margin),
            padding: const EdgeInsets.all(AppDefaults.padding),
            decoration: BoxDecoration(
              color: AppColors.scaffoldBackground,
              borderRadius: AppDefaults.borderRadius,
            ),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return AddressTile(
                  label: 'Nhà riêng',
                  address: '828, Sư Vạn Hạnh,Phường 13\nQuận 10,Hồ Chí Minh',
                  number: '0908754112',
                  isActive: index == 0,
                );
              },
              itemCount: 1,
              separatorBuilder: (context, index) =>
                  const Divider(thickness: 0.2),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.newAddress);
              },
              backgroundColor: AppColors.primary,
              splashColor: AppColors.primary,
              child: const Icon(Icons.add,color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
}

class AddressTile extends StatelessWidget {
  const AddressTile({
    Key? key,
    required this.address,
    required this.label,
    required this.number,
    required this.isActive,
  }) : super(key: key);

  final String address;
  final String label;
  final String number;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Align(
      // padding: const EdgeInsets.all(8.0),
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppRadio(isActive: isActive),
          const SizedBox(width: AppDefaults.padding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 4),
              // Expanded(
              //   child: Text(
              //     address,
              //     style: const TextStyle(
              //       fontSize: 10,
              //     ),
              //     maxLines: 1,
              //     softWrap: true,
              //   ),
              // ),
              Text(
                address,
                style: const TextStyle(
                    // fontSize: 10,
                    ),
                maxLines: 2,
                softWrap: true,
              ),
              const SizedBox(height: 10),
              Text(
                number,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                    ),
              )
            ],
          ),
          const Spacer(),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AppIcons.edit),
                constraints: const BoxConstraints(),
                iconSize: 14,
              ),
              const SizedBox(height: AppDefaults.margin / 2),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AppIcons.deleteOutline),
                constraints: const BoxConstraints(),
                iconSize: 14,
              ),
            ],
          )
        ],
      ),
    );
  }
}
