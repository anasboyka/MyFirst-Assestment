import 'package:flutter/material.dart';

//loading
const loadingWidget = Center(
  child: SizedBox(
    width: 24,
    height: 24,
    child: Center(
      child: CircularProgressIndicator.adaptive(),
    ),
  ),
);

//snackbar
class SnackBarLauncher extends StatelessWidget {
  final String? error;

  const SnackBarLauncher({Key? key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => _displaySnackBar(context, error: error!));
    }

    return const SizedBox();
  }

  void _displaySnackBar(BuildContext context, {required String error}) {
    final snackBar = SnackBar(content: Text(error));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
