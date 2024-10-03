import '../../../core/constants/app_images.dart';
import 'onboarding_model.dart';

class OnboardingData {
  static List<OnboardingModel> items = [
    OnboardingModel(
      imageUrl: AppImages.onboarding1,
      headline: 'Tất cả sản phẩm bạn muốn',
      description:
          'Ở đây chúng tôi có tất cả sản phẩm bách hóa mà bạn muốn tìm kiếm',
    ),
    OnboardingModel(
      imageUrl: AppImages.onboarding2,
      headline: 'Giảm giá & khuyến mãi',
      description:
          'Nhiều chương giảm giá & khuyến mãi đang chờ đón bạn',
    ),
    OnboardingModel(
      imageUrl: AppImages.onboarding3,
      headline: 'Giao hàng toàn quốc',
      description:
          'Vận chuyển 63 tỉnh thành trên toàn quốc',
    ),
  ];
}
