/*
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController {
  static Future<bool> havePermission(Permission permission) async {
    var status = await permission.status;

    if (status.isGranted) {
      return true;
    } else {
      var newStatus = await permission.request();
      if (newStatus.isGranted) {
        return true;
      } else {
        Fluttertoast.showToast(msg: "Permission Denied");
        return false;
      }
    }
  }
}
*/
