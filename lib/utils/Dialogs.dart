import 'package:flutter/material.dart';
import 'package:practical/utils/custom_text_style.dart';
import 'package:practical/utils/primary_colors.dart';

class Dialogs {
  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        barrierColor: PrimaryColors().black26Color,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Center(
              widthFactor: 70,
              heightFactor: 70,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: PrimaryColors().blackColor,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        backgroundColor: PrimaryColors().blackColor,
                        valueColor: AlwaysStoppedAnimation<Color>(PrimaryColors().whiteColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text('Please wait...', style: CustomTextStyles().loaderTextStyle),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
