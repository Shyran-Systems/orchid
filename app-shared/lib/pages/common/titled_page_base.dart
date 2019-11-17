import 'package:flutter/material.dart';
import 'package:orchid/pages/app_colors.dart';

/// A base class for stateless second level pages reached through navigation.
/// These pages have a title with a back button.
class TitledPageBase extends StatelessWidget {
  final String title;

  TitledPageBase({this.title});

  @override
  Widget build(BuildContext context) {
    return TitledPage(title: title, child: buildPage(context));
  }

  Widget buildPage(BuildContext context) {
    throw AssertionError("override this method");
  }
}

// A callback to perform the back button action (normally popping the view).
// Note that this requires the current build context in order to perform the pop.
typedef void BackAction(BuildContext context);

/// A second level page reached through navigation.
/// These pages have a title with a back button.
class TitledPage extends StatelessWidget {
  final String title;
  final Widget child;
  final bool lightTheme;
  final List<Widget> actions;
  final VoidCallback backAction;

  TitledPage(
      {@required this.title,
      @required this.child,
      this.lightTheme = false,
      this.actions = const [],
      this.backAction});

  @override
  Widget build(BuildContext context) {
    var foregroundColor = lightTheme ? Colors.black : Colors.white;
    var backgroundColor = lightTheme ? Colors.white : Colors.deepPurple;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: foregroundColor),
            onPressed: backAction ??
                () {
                  Navigator.pop(context);
                },
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          ),
          title: Text(
            this.title,
            style: TextStyle(color: foregroundColor),
          ),
          titleSpacing: 0,
          backgroundColor: backgroundColor,
          actions: actions,
          elevation: 0.0),
      body: Container(
        child: child,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.grey_7, AppColors.grey_6])),
      ),

      // Note: Setting this to false is a workaround for:
      // https://github.com/flutter/flutter/issues/23926
      // however that breaks the automated keyboard accommodation.
      resizeToAvoidBottomInset: true,
    );
  }
}
