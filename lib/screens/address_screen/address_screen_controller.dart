import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopky/utils/constants.dart';

class AddressScreenController extends GetxController {
  late SharedPreferences prefs;
  String name = "", address = "", pincode = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  bool isAddressAvailable = false;
  Future<void> getInstance() async {
    prefs = await SharedPreferences.getInstance();
    String address = getString('address');
    if (address.isNotEmpty) {
      isAddressAvailable = true;
    } else {
      isAddressAvailable = false;
    }

    initializeInfo();
    update();
  }

  void onEdit() async {
    isAddressAvailable = false;
    update();

    await prefs.clear();
  }

  void onTap() async {
    if (nameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        pincodeController.text.isNotEmpty) {
      await saveStrings("name", nameController.text);
      await saveStrings("address", addressController.text);
      await saveStrings("pincode", pincodeController.text);

      getInstance();
    } else {
      showAlert("All fields are required");
    }
  }

  Future<void> saveStrings(String key, String value) async {
    await prefs.setString(key, value);
  }

  String getString(String key) => prefs.getString(key) ?? "";
  void initializeInfo() {
    name = getString('name');
    address = getString('address');
    pincode = getString('pincode');
  }

  @override
  void onInit() {
    super.onInit();
    getInstance();
  }
}
