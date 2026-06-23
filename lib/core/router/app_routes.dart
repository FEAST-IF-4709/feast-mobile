/// Centralised route path constants.
/// All go_router path strings must be defined here — never scattered inline.
abstract final class AppRoutes {
  static const splash = '/';
  static const qrScan = '/qr-scan';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const itemDetail = '/item/:id';
  static const menu = '/menu';
  static const cart = '/cart';
  static const payment = '/payment/:orderId';
  static const orderTracking = '/order-tracking/:orderId';
  static const orderHistory = '/order-history';
  static const orderDetail = '/order-history/:orderId';
  static const profile = '/profile';
  static const editProfile = '/profile/edit';
  static const personalInfo = '/profile/personal-info';
  static const membership = '/membership';
  static const rewards = '/rewards';
  static const brandDetail = '/brand/:brandId';
  static const notifications = '/notifications';
}
