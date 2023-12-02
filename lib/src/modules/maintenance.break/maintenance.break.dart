import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/constants.dart';
import '../../localization/loalization.dart';

class MaintenanceBreak extends StatelessWidget {
  const MaintenanceBreak({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/svgs/maintenance.svg',
                semanticsLabel: 'Maintenance Break',
                width: size.height * 0.22,
                placeholderBuilder: (_) => Container(
                  padding: const EdgeInsets.all(30.0),
                  child: const CircularProgressIndicator(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'We are under maintenance.',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                  ),
                  textScaler: TextScaler.linear(1.4),
                ),
              ),
              const Text(
                'We will be back soon.',
                textScaler: TextScaler.linear(1.1),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: InkWell(
                  onTap: () async => await launchUrl(
                      Uri.parse('http://sabikrahat.github.io/')),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 3.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Row(
                      mainAxisSize: mainMin,
                      children: [
                        const Icon(Icons.engineering),
                        const SizedBox(width: 10.0),
                        Text(
                          t.contactWithAdmin,
                          textScaler: const TextScaler.linear(0.8),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
