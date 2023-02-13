import 'package:get/get.dart';
import 'package:skill_rate/main.dart';

class PredefinedPageController extends GetxController {
  String htmlText = "";
  String endPoint = "";
  String title = "";
  bool isLoading = false;

  @override
  void onInit() {
    endPoint = Get.arguments["end"];
    title = Get.arguments["title"];
    getData();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getData() async {
    isLoading = true;
    update();

    htmlText = await apiHolder.predefinedPage(endPoint: endPoint);
    isLoading = false;
    update();
  }
}
