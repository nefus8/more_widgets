import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This class is used to display dialogs easily without worrying about what
/// platform you use to display the dialog. It will automatically adapt to iOS
/// or other platforms
class Dialogs {
  /// This method will display an informative dialog with just one button
  static void infoDialog({
    required BuildContext context,
    required String title,
    required String message,

    /// Button text, default : Ok
    String buttonText = "Ok",

    /// Button text color, default : lightBlue
    Color buttonTextColor = Colors.lightBlue,
    VoidCallback? onPressed,

    /// Not for iOS : default is Color(0xFF424242)
    Color titleTextColor = const Color(0xFF424242),

    /// Not for iOS : default is Color(0xFF424242)
    Color messageTextColor = const Color(0xFF424242),
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          /// Checking the platform
          if (Theme.of(context).platform == TargetPlatform.iOS) {
            return CupertinoAlertDialog(
              title: Center(child: Text(title)),
              content: Text(message),
              actions: <Widget>[
                CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text(
                      buttonText,
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: buttonTextColor),
                    ),
                    onPressed: () {
                      Navigator.pop(context);

                      /// If no function, only pop the dialog.
                      if (onPressed != null) {
                        onPressed();
                      }
                    })
              ],
            );
          } else {
            return AlertDialog(
              elevation: 5,
              title: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: titleTextColor),
                ),
              ),
              content: Text(
                message,
                style: TextStyle(color: messageTextColor),
              ),
              actions: [
                TextButton(
                  /// usually buttons at the bottom of the dialog
                  child: Text(
                    buttonText,
                    style: TextStyle(fontSize: 20, color: buttonTextColor),
                  ),
                  onPressed: () {
                    Navigator.pop(context);

                    /// If no function, only pop the dialog.
                    if (onPressed != null) {
                      onPressed();
                    }
                  },
                ),
              ],
            );
          }
        });
  }

  /// Here is the dialog with options, it's useful if you want to pop up a dialog where you can choose between two
  /// options. One of them can be set as destructive action.
  static void dialogWithOptions(
      {required BuildContext context,
      required String title,
      required String message,
      String textLeftButton = 'OK',
      Color? titleTextColor,
      Color? messageTextColor,

      /// You can change the dismiss button text
      String textRightButton = 'Cancel',
      Function? onPressedLeftButton,
      Function? onPressedRightButton,

      /// If set to true, the right button will be considered as a destructive button and will be colored in red
      bool isRightButtonADestructiveAction = true,
      double buttonFontSize = 20,
      double titleFontSize = 25}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          if (Theme.of(context).platform == TargetPlatform.iOS) {
            /// Cupertino dialogs
            return CupertinoAlertDialog(
              title: Center(child: Text(title)),
              content: Text(message),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text(
                    textLeftButton,
                    textAlign: TextAlign.justify,
                  ),
                  isDefaultAction: true,

                  /// This is the default action
                  onPressed: onPressedLeftButton != null
                      ? () {
                          Navigator.pop(context);
                          onPressedLeftButton();
                        }
                      : () => Navigator.of(context).pop(),
                ),
                CupertinoDialogAction(
                  child: Text(
                    textRightButton,
                    textAlign: TextAlign.justify,
                  ),

                  /// If the function is null, we just pop the dialog.
                  onPressed: onPressedRightButton != null
                      ? () {
                          Navigator.pop(context);
                          onPressedRightButton();
                        }
                      : () => Navigator.of(context).pop(),
                  isDestructiveAction: isRightButtonADestructiveAction,
                ),
              ],
            );
          } else {
            return AlertDialog(
              elevation: 5,
              title: Center(
                  child: Text(
                title,
                style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: titleTextColor),
              )),
              content: Text(
                message,
                textAlign: TextAlign.justify,
                style: TextStyle(color: messageTextColor),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    textLeftButton,
                    style: TextStyle(fontSize: buttonFontSize),
                  ),
                  onPressed: onPressedLeftButton != null
                      ? () {
                          Navigator.pop(context);
                          onPressedLeftButton();
                        }
                      : () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text(
                    textRightButton,
                    style: TextStyle(
                        fontSize: buttonFontSize,
                        color: isRightButtonADestructiveAction
                            ? Colors.redAccent
                            : Colors.white),
                  ),

                  /// If the function is null, we just pop the dialog.
                  onPressed: onPressedRightButton != null
                      ? () {
                          Navigator.pop(context);
                          onPressedRightButton();
                        }

                      /// If the function is null, we just pop the dialog.
                      : () => Navigator.of(context).pop(),
                ),
              ],
            );
          }
        });
  }

  /// This method will display a dialog with two buttons
  /// that have actions
  static void textInputDialog({
    required BuildContext context,
    required String title,
    required String message,
    TextEditingController? editingController,
    String dismissButtonText = 'OK',
    Color? titleTextColor,
    Color? messageTextColor,
    VoidCallback? onPressed,
    VoidCallback? onEditingComplete,
    Function? onChanged,
    double dismissButtonFontSize = 20,
    double titleFontSize = 25,
    String? placeHolder,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (Theme.of(context).platform == TargetPlatform.iOS) {
          return CupertinoAlertDialog(
            title: Center(child: Text(title)),
            content: Column(
              children: [
                Text(message),
                const SizedBox(
                  height: 10,
                ),
                CupertinoTextField(
                  controller: editingController,
                  onChanged: (value) =>
                      onChanged == null ? {} : onChanged(value),
                  onEditingComplete: () =>
                      onEditingComplete == null ? {} : onEditingComplete(),
                  placeholder: placeHolder,
                )
              ],
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  dismissButtonText,
                  textAlign: TextAlign.justify,
                ),
                onPressed: () {
                  Navigator.pop(context);

                  /// Pop and do the function if not null
                  if (onPressed != null) {
                    onPressed();
                  }
                },
              )
            ],
          );
        } else {
          return AlertDialog(
            elevation: 5,
            title: Center(
                child: Text(
              title,
              style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: titleTextColor),
            )),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: messageTextColor),
                ),
                TextField(
                  onChanged: (value) =>
                      onChanged == null ? {} : onChanged(value),
                  onEditingComplete: () =>
                      onEditingComplete == null ? {} : onEditingComplete(),
                  controller: editingController,
                  decoration: InputDecoration(
                    labelText: placeHolder,
                  ),
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  dismissButtonText,
                  style: TextStyle(fontSize: dismissButtonFontSize),
                ),
                onPressed: () {
                  Navigator.pop(context);

                  /// Pop and do the function if not null
                  if (onPressed != null) {
                    onPressed();
                  }
                },
              ),
            ],
          );
        }
      },
    );
  }

  /// This method will display a dialog with a loading indicator inside
  static void loadingDialog({
    required BuildContext context,
    String title = "",
    Color? androidLoadingColor,
    Color? titleTextColor,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          double padding = title.isEmpty ? 0.0 : 10.0;
          if (Theme.of(context).platform == TargetPlatform.iOS) {
            return CupertinoAlertDialog(
              title: Center(child: Text(title)),
              content: Padding(
                padding: EdgeInsets.only(top: padding),
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
            );
          } else {
            return AlertDialog(
                elevation: 5,
                title: title.isEmpty
                    ? null
                    : Center(
                        child: Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: titleTextColor ?? Colors.grey.shade800),
                      )),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: padding),
                      child: CircularProgressIndicator(
                        color: androidLoadingColor,
                      ),
                    )),
                  ],
                ));
          }
        });
  }
}
