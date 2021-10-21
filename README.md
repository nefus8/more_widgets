# more_widgets
Add more widgets to use in your apps...

## List of widgets :
### GradientBackground :
Shows a gradient background container. Here is the parameters list:
```dart
final Widget child;
final List<Color> colors;       // Default : const [Color(0xffff9800), Color(0xfff44336)]
final List<Color> darkColors;   // Default : const [Color(0xff13191f), Color(0xff262f3c)]
final List<double> stops;       // Default : const [0.2, 0.8]
final AlignmentGeometry begin;  // Default : FractionalOffset.topLeft
final AlignmentGeometry end;    // Default : FractionalOffset.bottomRight
final bool useDarkMode;         // Default : true
```

### RoundedContainer :
Shows a rounded container. The default color is white. Here is the parameters list:
```dart
final Widget? child;
final Color color;            // Default : Colors.white
final double circularRadius;  // Default : 20
final double margin;          // Default : 20
final double padding;         // Default : 20
```

## List of dialogs :
Those dialogs adapt automatically to the OS and display accordingly.

### Dialogs.infoDialog
This shows an informative dialog with only one button. Here is the parameters list:

```dart
required BuildContext context
required String title
required String message
String buttonText       // Default : "Ok"
Color buttonTextColor   // Default : Colors.lightBlue
VoidCallback? onPressed
Color titleTextColor    // Default : const Color(0xFF424242) (Not for iOS)
Color messageTextColor  // Default : const Color(0xFF424242) (Not for iOS)
```

### Dialogs.dialogWithOptions
Here is the dialog with options, it's useful if you want to pop up a dialog where you can choose between two options. One of them can be set as destructive action. Here is the parameters list:

```dart
required BuildContext context
required String title
required String message
String textLeftButton                 // Default : OK
Color? titleTextColor
Color? messageTextColor
String textRightButton                // Default : Cancel
Function? onPressedLeftButton
Function? onPressedRightButton
bool isRightButtonADestructiveAction  // Default : true
double buttonFontSize                 // Default : 20
double titleFontSize                  // Default : 25
```

### Dialogs.textInputDialog
This method will display a dialog with two buttons that have actions. Here is the parameters list:

```dart
required BuildContext context
required String title
required String message
TextEditingController? editingController
String dismissButtonText                  // Default : 'OK'
Color? titleTextColor
Color? messageTextColor
VoidCallback? onPressed
VoidCallback? onEditingComplete
Function? onChanged
double dismissButtonFontSize              // Default : 20
double titleFontSize                      // Default : 25
String? placeHolder
```

### Dialogs.loadingDialog
This method will display a dialog with a loading indicator inside. Here is the parameters list:

```dart
required BuildContext context
String title
Color? titleTextColor
Color? androidLoadingColor
```