import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nobes/app/data/services/font.dart';
import 'package:nobes/app/routes/app_pages.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/images_controller.dart';

class ImagesView extends GetView<ImagesController> {
  const ImagesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: TextFormField(
          controller: controller.linkController,
          onEditingComplete: () => Get.offAndToNamed(Routes.IMAGES,
              parameters: {'link': controller.linkController.text}),
          style: Font.regular(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: WebViewWidget(controller: controller.webViewController),
    );
  }
}
