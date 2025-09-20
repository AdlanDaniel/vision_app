import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:vision_app/core/ui/widgets/vision_button.dart';
import 'package:vision_app/core/utils/constants/assets.dart';
import 'package:vision_app/core/utils/constants/routes/vision_routes.dart';
import 'package:vision_app/core/utils/constants/sizes/sizes.dart';

class ForgoutPasswordSucessPage extends StatefulWidget {
  const ForgoutPasswordSucessPage({super.key});

  @override
  State<ForgoutPasswordSucessPage> createState() =>
      _ForgoutPasswordSucessPageState();
}

class _ForgoutPasswordSucessPageState extends State<ForgoutPasswordSucessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: VisionSizes.mediumM12,
            right: VisionSizes.mediumM12,
            bottom: VisionSizes.mediumM12,
            top: VisionSizes.largeL80,
          ),
          child: Column(
            children: [
              SvgPicture.asset(
                VisionAssets.logo,
                alignment: Alignment.center,
                width: 32,
                height: 32,
              ),
              const Expanded(flex: 2, child: SizedBox()),
              Text(
                'The instructions were sent!',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: VisionSizes.mediumM12),
              Text(
                'If this was a valid email, instructions to reset your password will be sent to you. Please check your email.',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const Expanded(flex: 5, child: SizedBox()),
              VisionButton(
                textButton: 'Login',
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, VisionRoutes.login),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
