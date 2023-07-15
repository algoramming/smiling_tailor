// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:rive/rive.dart';

// import '../../utils/logger/logger_helper.dart';

// class DashFlutterMuscot extends StatefulWidget {
//   const DashFlutterMuscot({super.key, this.width = 180.0, this.height = 180.0});

//   final double width;
//   final double height;

//   @override
//   State<DashFlutterMuscot> createState() => _DashFlutterMuscotState();
// }

// class _DashFlutterMuscotState extends State<DashFlutterMuscot> {
//   Artboard? riveArtboard;
//   SMIBool? isDance;
//   SMITrigger? isLookUp;

//   @override
//   void initState() {
//     super.initState();
//     rootBundle.load('assets/riv/dash_flutter_muscot.riv').then(
//       (data) async {
//         try {
//           final file = RiveFile.import(data);
//           final artboard = file.mainArtboard;
//           final controller =
//               StateMachineController.fromArtboard(artboard, 'birb');
//           if (controller != null) {
//             artboard.addController(controller);
//             isDance = controller.findSMI('dance');
//             isLookUp = controller.findSMI('look up');
//           }
//           setState(() => riveArtboard = artboard);
//         } catch (e) {
//           log.e('Dash Flutter Muscot Error: $e');
//         }
//       },
//     );
//   }

//   void toggleDance(bool v) => setState(() => isDance!.value = v);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: widget.height,
//       width: widget.width,
//       child: riveArtboard == null
//           ? Center(
//               child: Image.asset(
//                 'assets/gifs/loading.gif',
//                 height: widget.height / 3,
//                 width: widget.width / 3,
//               ),
//             )
//           : GestureDetector(
//               onTap: () => toggleDance(!isDance!.value),
//               onLongPress: () => isLookUp?.value = true,
//               child: Rive(artboard: riveArtboard!),
//             ),
//     );
//   }
// }
