import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshPage extends StatelessWidget {
  final Widget child;
  final String routes;
  final Map<String, String>? parameters;
  const RefreshPage({
    super.key,
    required this.child,
    required this.routes,
    this.parameters,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: RefreshController(),
      onRefresh: () => Get.offAndToNamed(
        routes,
        parameters: parameters,
      ),
      child: child,
    );
  }
}
