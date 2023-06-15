// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

// class HideKeyboardScrollBehavior extends ScrollBehavior {
//   @override
//   Widget buildOverscrollIndicator(
//     BuildContext context,
//     Widget child,
//     ScrollableDetails details,
//   ) {
//     void hideKeyboard() {
//       if (details.controller?.position.userScrollDirection ==
//           ScrollDirection.reverse) {
//         FocusScope.of(context).unfocus();
//       }
//     }

//     details.controller?.removeListener(hideKeyboard);
//     details.controller?.addListener(hideKeyboard);

//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: child,
//     );
//   }
// }
