library jz_base_page;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jz_base_page/util.dart';

part 'jz_loading_toast.dart';

part 'jz_message_toast.dart';

abstract class JZBasePage extends StatefulWidget {
  const JZBasePage({Key? key}) : super(key: key);

  @override
  JZBasePageState<JZBasePage> createState();
}

abstract class JZBasePageState<T extends JZBasePage> extends State<T> {
  /// The flag indicates whether the loading toast is displayed.
  bool _isLoading = false;

  /// The message of the loading toast.
  String? _loadingMessage;

  /// The message of the message toast.
  String? _toastMessage;

  /// The flag indicates whether the message toast is dismissible by touching the dimmed background.
  bool _barrierDismissible = true;

  /// The timer used to dismiss the toast after a certain duration.
  Timer? _timer;

  ///
  /// Private Getters
  ///

  /// The flag indicates whether the message toast is displayed.
  bool get _isToasting => _toastMessage != null;

  /// The flag indicates whether either one of the loading toast and the message toast is displayed.
  bool get _isBodyCovered => isLoading || isToasting;

  /// The loading toast widget.
  Widget get _loadingToast => JZLoadingToast(
        padding: loadingPadding,
        margin: loadingMargin,
        spacing: loadingSpacing,
        diameter: loadingDiameter,
        strokeWidth: loadingStrokeWidth,
        message: _loadingMessage,
      );

  /// The message toast widget.
  Widget get _messageToast => JZMessageToast(
        margin: toastMargin,
        message: _toastMessage,
      );

  ///
  /// Public Getters
  ///

  bool get isLoading => _isLoading;

  bool get isToasting => _isToasting;

  ///
  /// Constants
  ///

  double get loadingPadding => 40;

  double get loadingMargin => 30;

  double get loadingSpacing => 20;

  double get loadingDiameter => 38;

  double get loadingStrokeWidth => 5;

  double get toastMargin => 30;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        contentBuilder(context),
        if (_isBodyCovered)
          GestureDetector(
            onTap: () {
              if (_isToasting && _barrierDismissible) hideToast();
            },
            child: Container(
              margin: EdgeInsets.zero,
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        if (_isLoading) _loadingToast,
        if (_isToasting) _messageToast,
      ],
    );
  }

  Widget contentBuilder(BuildContext context);

  void startLoading({String? message}) {
    setState(() {
      _isLoading = true;
      _loadingMessage = message;
    });
  }

  void stopLoading() {
    setState(() {
      _isLoading = false;
      _loadingMessage = null;
    });
  }

  void showToast({
    required String message,
    bool barrierDismissible = true,
    Duration? dismissAfterDelay,
  }) {
    _disposeTimer();
    setState(() {
      _toastMessage = message;
      _barrierDismissible = barrierDismissible;
    });
    if (dismissAfterDelay != null) {
      _setupTimer(
        delay: dismissAfterDelay,
        callback: () {
          hideToast();
        },
      );
    }
  }

  void hideToast() {
    setState(() {
      _toastMessage = null;
      _barrierDismissible = false;
    });
  }

  void _setupTimer(
      {required Duration delay, required void Function() callback}) {
    _timer = Timer(delay, callback);
  }

  void _disposeTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
