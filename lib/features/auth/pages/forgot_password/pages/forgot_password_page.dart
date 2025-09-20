import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:svg_flutter/svg.dart';
import 'package:vision_app/core/injection/injection.dart';
import 'package:vision_app/core/ui/theme/vision_colors.dart';
import 'package:vision_app/core/ui/widgets/vision_button.dart';
import 'package:vision_app/core/ui/widgets/vision_text_form.dart';
import 'package:vision_app/core/utils/constants/assets.dart';
import 'package:vision_app/core/utils/constants/routes/vision_routes.dart';
import 'package:vision_app/core/utils/constants/sizes/sizes.dart';
import 'package:vision_app/features/auth/pages/forgot_password/controller/forgot_password_controller.dart';

class ForgoutPasswordPage extends StatefulWidget {
  const ForgoutPasswordPage({super.key});

  @override
  State<ForgoutPasswordPage> createState() => _ForgoutPasswordPageState();
}

class _ForgoutPasswordPageState extends State<ForgoutPasswordPage> {
  final _controller = InjectionManager.i.get<ForgotPasswordController>();
  final TextEditingController _emailEC = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                    const SizedBox(height: VisionSizes.largeL60),
                    Text(
                      'Forgout Password?',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(fontSize: 24),
                    ),
                    const SizedBox(height: VisionSizes.mediumM12),
                    Text(
                      'Enter the email address you used when you joined and we\'ll send you instructions to reset your password.',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: VisionSizes.largeL70),
                    Form(
                      key: _formKey,
                      child: VisionTextForm(
                        label: 'Email',
                        controller: _emailEC,
                        validator: _controller.validateEmail,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: VisionSizes.mediumM14),
            Observer(
              builder: (context) {
                return VisionButton(
                  width: 230,
                  isLoading: _controller.isLoading,
                  textButton: 'Send reset instructions',
                  onPressed: _resetPassword,
                );
              },
            ),
            const SizedBox(height: VisionSizes.mediumM18),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Back',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: VisionColors.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailEC.text;

      final result = await _controller.resetPassword(email);
      result.fold(
        (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password reset failed: ${error.toString()}'),
            ),
          );
        },
        (success) {
          Navigator.pushReplacementNamed(
            context,
            VisionRoutes.successForgotPassword,
          );
        },
      );
    }
  }
}
