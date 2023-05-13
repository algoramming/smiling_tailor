import 'package:flutter/material.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../../utils/transations/down.to.up.dart';

import '../../../../shared/image.widget/image.widget.dart';
import '../../../../shared/image_process/single/pick.photo.dart';
import '../../provider/authentication.provider.dart';

class AuthImageSelect extends StatelessWidget {
  const AuthImageSelect(this.notifier, {super.key});

  final AuthProvider notifier;

  @override
  Widget build(BuildContext context) {
    return DownToUpTransition(
      child: notifier.isSignup
          ? Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(100.0),
                onTap: () async {
                  await pickPhoto(context).then((pk) {
                    if (pk == null) return;
                    notifier.setImage(pk);
                  });
                },
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        border: Border.all(
                          color: context.theme.primaryColor,
                          width: 2.0,
                        ),
                      ),
                      child: notifier.image == null
                          ? const Icon(Icons.add, size: 50.0)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: ImageWidget(notifier.image!),
                            ),
                    ),
                    if (notifier.image != null)
                      Positioned(
                        top: 2,
                        right: 2,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100.0),
                          onTap: () => notifier.removeImage(),
                          child: Container(
                            padding: const EdgeInsetsDirectional.all(2.0),
                            decoration: BoxDecoration(
                              color: context.theme.primaryColor,
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: Icon(
                              Icons.close,
                              color: context.theme.colorScheme.error,
                              size: 18.0,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  border: Border.all(
                    color: context.theme.primaryColor,
                    width: 2.0,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.asset('assets/icons/splash-icon-384x384.png'),
                ),
              ),
            ),
    );
  }
}
