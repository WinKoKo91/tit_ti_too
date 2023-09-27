import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tit/app/data/entities/user_entity.dart';
import 'package:tit/app/data/models/user_model.dart';
import 'package:tit/app/modules/home/home_state.dart';
import 'package:tit/app/routes/app_pages.dart';

import '../../../../core/services/auth/auth_service.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../states/settings_state.dart';

class SettingsController extends GetxController {
  UserRepository userRepository = Get.find<UserRepository>();

  SettingsState state = SettingsState();


  @override
  void onInit() async {
    getUserData();
    super.onInit();
  }

  @override
  void onReady() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  void onDarkModeChange(bool value) {
    state.isDarkMode = value;
  }

  void onNotificationStateChange(bool value) {
    state.isNotificationOn = value;
  }

  void onLogout() async{

    await userRepository.signOut();
  }

  void getUserData() async {
    try{
      state.userEntity = await userRepository.getUser();
    }catch(e){

      print(e);
    }
  }
}