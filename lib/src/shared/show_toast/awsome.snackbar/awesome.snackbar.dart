import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/extensions/extensions.dart';

// class AssetsPath {
//   static const String help = 'assets/types/help.svg';
//   static const String failure = 'assets/types/failure.svg';
//   static const String success = 'assets/types/success.svg';
//   static const String warning = 'assets/types/warning.svg';

//   static const String back = 'assets/types/back.svg';
//   static const String bubbles = 'assets/types/bubbles.svg';
// }

class DefaultColors {
  /// help
  static const Color helpBlue = Color(0xff3282B8);

  /// failure
  static const Color failureRed = Color(0xffc72c41);

  /// success
  static const Color successGreen = Color(0xff2D6A4F);

  /// warning
  static const Color warningYellow = Color(0xffFCA652);
}

/// to handle failure, success, help and warning `ContentType` class is being used
class MessageType {
  /// message is `required` parameter
  final String message;

  /// color is optional, if provided null then `DefaultColors` will be used
  final Color? color;

  MessageType(this.message, [this.color]);

  static MessageType help = MessageType('help', DefaultColors.helpBlue);
  static MessageType failure = MessageType('failure', DefaultColors.failureRed);
  static MessageType success =
      MessageType('success', DefaultColors.successGreen);
  static MessageType warning =
      MessageType('warning', DefaultColors.warningYellow);
}

class AwesomeSnackbarContent extends StatelessWidget {
  /// `IMPORTANT NOTE` for SnackBar properties before putting this in `content`
  /// backgroundColor: Colors.transparent
  /// behavior: SnackBarBehavior.floating
  /// elevation: 0.0

  /// /// `IMPORTANT NOTE` for MaterialBanner properties before putting this in `content`
  /// backgroundColor: Colors.transparent
  /// forceActionsBelow: true,
  /// elevation: 0.0
  /// [inMaterialBanner = true]

  /// title is the header String that will show on top
  final String title;

  /// message String is the body message which shows only 2 lines at max
  final String message;

  /// `optional` color of the SnackBar/MaterialBanner body
  final Color? color;

  /// contentType will reflect the overall theme of SnackBar/MaterialBanner: failure, success, help, warning
  final MessageType messageType;

  /// if you want to use this in materialBanner
  final bool inMaterialBanner;

  const AwesomeSnackbarContent({
    super.key,
    this.color,
    required this.title,
    required this.message,
    required this.messageType,
    this.inMaterialBanner = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // screen dimensions
    bool isMobile = size.width <= 768;
    bool isTablet = size.width > 768 && size.width <= 992;
    bool isDesktop = size.width >= 992;

    /// For reflecting different color shades in the SnackBar
    final hsl = HSLColor.fromColor(color ?? messageType.color!);
    final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));

    return Row(
      children: [
        !isMobile
            ? const Spacer()
            : SizedBox(
                width: size.width * 0.01,
              ),
        Expanded(
          flex: !isDesktop ? 8 : 1,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              /// SnackBar Body
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: isTablet ? size.width * 0.1 : 0,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? size.width * 0.1 : size.width * 0.05,
                  vertical:
                      !isMobile ? size.height * 0.03 : size.height * 0.025,
                ),
                decoration: BoxDecoration(
                  color: color ?? messageType.color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: isMobile ? 8 : 25,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// `title` parameter
                              Expanded(
                                flex: 3,
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: isTablet || isDesktop
                                        ? size.height * 0.03
                                        : size.height * 0.025,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              InkWell(
                                onTap: () {
                                  if (inMaterialBanner) {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentMaterialBanner();
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                  }
                                },
                                child: SvgPicture.asset(
                                  'assets/types/failure.svg',
                                  height: size.height * 0.022,
                                ),
                              ),
                            ],
                          ),

                          /// `message` body text parameter
                          Text(
                            message,
                            style: TextStyle(
                              fontSize: size.height * 0.016,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// other SVGs in body
              Positioned(
                bottom: 0,
                left: isTablet ? size.width * 0.1 : 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  ),
                  child: SvgPicture.asset(
                    'assets/types/bubbles.svg',
                    height: size.height * 0.06,
                    width: size.width * 0.05,
                    colorFilter: hslDark.toColor().toColorFilter,
                  ),
                ),
              ),

              Positioned(
                top: -size.height * 0.02,
                left: isTablet ? size.width * 0.125 : size.width * 0.02,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/types/back.svg',
                      height: size.height * 0.06,
                      colorFilter: hslDark.toColor().toColorFilter,
                    ),
                    Positioned(
                      top: size.height * 0.015,
                      child: SvgPicture.asset(
                        assetSVG(messageType),
                        height: size.height * 0.022,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        !isMobile
            ? const Spacer()
            : SizedBox(
                width: size.width * 0.01,
              ),
      ],
    );
  }

  /// Reflecting proper icon based on the contentType
  String assetSVG(MessageType messageType) {
    if (messageType == MessageType.failure) {
      /// failure will show `CROSS`
      return 'assets/types/failure.svg';
    } else if (messageType == MessageType.success) {
      /// success will show `CHECK`
      return 'assets/types/success.svg';
    } else if (messageType == MessageType.warning) {
      /// warning will show `EXCLAMATION`
      return 'assets/types/warning.svg';
    } else if (messageType == MessageType.help) {
      /// help will show `QUESTION MARK`
      return 'assets/types/help.svg';
    } else {
      return 'assets/types/failure.svg';
    }
  }
}
