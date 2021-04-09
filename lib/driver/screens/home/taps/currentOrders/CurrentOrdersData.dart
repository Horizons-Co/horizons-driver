part of 'CurrentOrdersImports.dart';

class CurrentOrdersData {

  final CustomPushNotification globalNotification = new CustomPushNotification();

  final PagingController<int, OrderItemModel> pagingController =
      PagingController(firstPageKey: 1);

  void fetchPage(BuildContext context, int pageKey) async {
    var _events = await DriverRepository(context).getCurrentOrders(pageKey);
    final isLastPage = _events.length < 10;
    if (isLastPage) {
      pagingController.appendLastPage(_events);
    } else {
      final nextPageKey = pageKey + 1;
      pagingController.appendPage(_events, nextPageKey);
    }
  }

  void streamListener(BuildContext context, mounted) {
    globalNotification.notificationSubject.stream.listen((data) {
      fetchPage(context,1);
    });
  }

}
