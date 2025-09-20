import 'package:flutter/material.dart';
import 'package:vision_app/core/ui/theme/vision_colors.dart';
import 'package:vision_app/core/ui/widgets/vision_button.dart';
import 'package:vision_app/core/ui/widgets/vision_text_form.dart';
import 'package:vision_app/core/utils/constants/sizes/sizes.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: VisionColors.onPrimary),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.85,

        padding: EdgeInsets.only(
          left: VisionSizes.mediumM14,
          right: VisionSizes.mediumM14,
          top: VisionSizes.mediumM14,
          bottom: VisionSizes.smallS4,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Change',
                      style: TextStyle(
                        color: VisionColors.onBackground,
                        fontSize: VisionSizes.mediumM24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: VisionSizes.mediumM14),
                    Text(
                      'Password',
                      style: TextStyle(
                        color: VisionColors.onBackground,
                        fontSize: VisionSizes.mediumM24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: VisionSizes.largeL42),
                    VisionTextForm(label: 'Current Password', isPassword: true),
                    SizedBox(height: VisionSizes.largeL30),
                    _divider(),
                    SizedBox(height: VisionSizes.largeL30),
                    VisionTextForm(label: 'New Password', isPassword: true),
                    SizedBox(height: VisionSizes.mediumM14),
                    VisionTextForm(
                      label: 'Confirm New Password',
                      isPassword: true,
                    ),
                  ],
                ),
              ),
            ),
            VisionButton(onPressed: () {}, textButton: 'Change Password'),
          ],
        ),
      ),
    );
  }

  Divider _divider() {
    return Divider(
      color: Colors.white.withValues(alpha: 0.2),
      thickness: VisionSizes.smallS1,
      height: VisionSizes.mediumM18,
    );
  }
}
