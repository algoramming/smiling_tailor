import 'package:flutter/material.dart';

import '../../../utils/extensions/extensions.dart';
import '../../../utils/themes/themes.dart';

class TimerSnackbarContent extends StatelessWidget {
  const TimerSnackbarContent({
    super.key,

    /// Main body message
    required this.contentText,

    /// action button prefix child
    this.buttonPrefixWidget,

    /// button label
    this.buttonLabel = 'Undo',

    /// This method will execute after time finish. The default time is 4 seconds.
    this.onTap,

    /// default time set 4 seconds.
    this.second = 4,

    /// default TextStyle is none.
    this.contentTextStyle,

    /// Alignment of the content text
    this.alignment = Alignment.center,
  });

  final String contentText;
  final Widget? buttonPrefixWidget;
  final String buttonLabel;
  final void Function()? onTap;
  final int second;
  final TextStyle? contentTextStyle;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // screen dimensions
    bool isMobile = size.width <= 768;
    // bool isTablet = size.width > 768 && size.width <= 992;
    bool isDesktop = size.width >= 992;

    return Row(
      children: [
        if (alignment == Alignment.center)
          !isMobile ? const Spacer() : SizedBox(width: size.width * 0.01),
        if (alignment == Alignment.centerRight)
          !isMobile ? const Spacer() : SizedBox(width: size.width * 0.02),
        Expanded(
          flex: !isDesktop ? 8 : 1,
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: const BoxConstraints(maxHeight: 22.0),
                  child: TweenAnimationBuilder(
                    tween:
                        Tween<double>(begin: 0, end: second * 1000.toDouble()),
                    duration: Duration(seconds: second),
                    builder: (context, double value, child) {
                      return Stack(
                        fit: StackFit.loose,
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 20.0,
                            width: 20.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              value: value / (second * 1000),
                              color: Colors.grey[850],
                              backgroundColor: Colors.white,
                            ),
                          ),
                          Center(
                            child: Text(
                              (second - (value / 1000)).toInt().toString(),
                              textScaler: const TextScaler.linear(0.85),
                              style: contentTextStyle ??
                                  context.text.labelLarge!
                                      .copyWith(color: white),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    contentText,
                    style: contentTextStyle ??
                        context.text.labelLarge!.copyWith(color: white),
                  ),
                ),
                const SizedBox(width: 12.0),
                InkWell(
                  splashColor: Colors.white,
                  onTap: onTap,
                  child: Container(
                    color: Colors.grey[850],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (buttonPrefixWidget != null)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: buttonPrefixWidget,
                          ),
                        Text(
                          buttonLabel,
                          style: contentTextStyle ??
                              context.text.labelLarge!
                                  .copyWith(color: context.theme.primaryColor),
                          textScaler: const TextScaler.linear(1.1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (alignment == Alignment.center)
          !isMobile ? const Spacer() : SizedBox(width: size.width * 0.01),
        if (alignment == Alignment.centerLeft)
          !isMobile ? const Spacer() : SizedBox(width: size.width * 0.02),
      ],
    );
  }
}
