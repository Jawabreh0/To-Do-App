// Clean

import 'package:flutter/material.dart';
import 'package:todo/core/constants/lang_keys.dart';
import 'package:todo/core/constants/palette.dart';
import 'package:todo/core/constants/assset_keys.dart';
import 'package:todo/core/presentation/widgets/build_svg_icon.dart';

class LoginWidgets {
  static Widget buildBody() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BuildSvgIcon(assetKey: AssetKeys.appLogo),
            ],
          ),
        ),
      ],
    );
  }

  static Widget buildBottomButton(
      Function authentication, Function getAvailableBiometrics) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 75.0, left: 20, right: 20),
      child: ElevatedButton(
        onPressed: () {
          authentication();
          getAvailableBiometrics();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: appSecondaryColor,
          minimumSize: const Size.fromHeight(45),
        ),
        child: const Text(
          LangKeys.UNLOCK_APP,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            height: 1.505,
          ),
        ),
      ),
    );
  }
}