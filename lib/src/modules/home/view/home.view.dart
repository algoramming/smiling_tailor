import 'package:flutter/material.dart';

import '../../../config/is.under.min.size.dart';
import '../../../config/screen_enlarge_warning.dart';
import '../../../pocketbase/auth.store/helpers.dart';
import '../../../shared/page_not_found/page_not_found.dart';
import '../../../utils/extensions/extensions.dart';
import '../../authentication/view/authentication.dart';
import 'components/body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!isServerRunning) return const KServerNotRunning();
    if (!pb.authStore.isValid) return const AuthenticationView();
    if (isUnderMinSize(context.mq.size)) return const ScreenEnlargeWarning();
    return const Scaffold(
      body: HomeBody(),
    );
  }
}
