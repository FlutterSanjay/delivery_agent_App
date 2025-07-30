import 'package:get/get.dart';

import '../modules/agent_dashboard/bindings/agent_dashboard_binding.dart';
import '../modules/agent_dashboard/views/agent_dashboard_view.dart';
import '../modules/day_complete/bindings/day_complete_binding.dart';
import '../modules/day_complete/views/day_complete_view.dart';
import '../modules/delivery_agent_profile/bindings/delivery_agent_profile_binding.dart';
import '../modules/delivery_agent_profile/views/delivery_agent_profile_view.dart';
import '../modules/end_of_day/bindings/end_of_day_binding.dart';
import '../modules/end_of_day/views/end_of_day_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login_process/bindings/onboaeding_binding.dart';
import '../modules/login_process/views/onboaeding_view.dart';
import '../modules/onBoarding_page/bindings/on_boarding_page_binding.dart';
import '../modules/onBoarding_page/views/on_boarding_page_view.dart';
import '../modules/order/bindings/order_binding.dart';
import '../modules/order/views/order_view.dart';
import '../modules/page_not_found/bindings/page_not_found_binding.dart';
import '../modules/page_not_found/views/page_not_found_view.dart';
import '../modules/payment_page/bindings/payment_page_binding.dart';
import '../modules/payment_page/views/payment_page_view.dart';
import '../modules/record_sales/bindings/record_sales_binding.dart';
import '../modules/record_sales/views/record_sales_view.dart';
import '../modules/signUp_page/bindings/sign_up_page_binding.dart';
import '../modules/signUp_page/views/sign_up_page_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/store_assign/bindings/store_assign_binding.dart';
import '../modules/store_assign/views/store_assign_view.dart';
import '../modules/store_list/bindings/store_list_binding.dart';
import '../modules/store_list/views/store_list_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(name: _Paths.HOME, page: () => const HomeView(), binding: HomeBinding()),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOAEDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.STORE_LIST,
      page: () => const StoreListView(),
      binding: StoreListBinding(),
    ),
    GetPage(
      name: _Paths.STORE_ASSIGN,
      page: () => const StoreAssignView(),
      binding: StoreAssignBinding(),
    ),
    GetPage(name: _Paths.ORDER, page: () => OrderView(), binding: OrderBinding()),
    GetPage(
      name: _Paths.RECORD_SALES,
      page: () => const RecordSalesView(),
      binding: RecordSalesBinding(),
    ),
    GetPage(
      name: _Paths.END_OF_DAY,
      page: () => const EndOfDayView(),
      binding: EndOfDayBinding(),
    ),
    GetPage(
      name: _Paths.DAY_COMPLETE,
      page: () => const DayCompleteView(),
      binding: DayCompleteBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_PAGE,
      page: () => const PaymentPageView(),
      binding: PaymentPageBinding(),
    ),
    GetPage(
      name: _Paths.DELIVERY_AGENT_PROFILE,
      page: () => const DeliveryAgentProfileView(),
      binding: DeliveryAgentProfileBinding(),
    ),
    GetPage(
      name: _Paths.AGENT_DASHBOARD,
      page: () => const AgentDashboardView(),
      binding: AgentDashboardBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP_PAGE,
      page: () => const SignUpPageView(),
      binding: SignUpPageBinding(),
    ),
    GetPage(
      name: _Paths.ON_BOARDING_PAGE,
      page: () => const OnBoardingPageView(),
      binding: OnBoardingPageBinding(),
    ),
    GetPage(
      name: _Paths.PAGE_NOT_FOUND,
      page: () => const PageNotFoundView(),
      binding: PageNotFoundBinding(),
    ),
  ];
}
