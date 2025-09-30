import 'package:flutter/gestures.dart';
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
import 'package:vision_app/features/auth/pages/register/controller/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _controller = InjectionManager.i.get<RegisterController>();
  final TextEditingController _emailEC = TextEditingController();
  final TextEditingController _passwordEC = TextEditingController();
  final TextEditingController _confirmPasswordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(VisionSizes.mediumM12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SvgPicture.asset(
                  VisionAssets.logoWithTitle,
                  alignment: Alignment.center,
                  width: 132,
                  height: 92,
                ),
                const SizedBox(height: VisionSizes.mediumM16),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account?',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: VisionColors.onSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign In!',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: VisionColors.onPrimary,
                            ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(
                              context,
                              VisionRoutes.login,
                            );
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: VisionSizes.largeL60),
                Text(
                  'Create an account',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontSize: 24),
                ),
                const SizedBox(height: VisionSizes.mediumM12),
                Text(
                  'To get started, please complete your account registration.',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: VisionSizes.largeL36),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _boxToAlternativeLogin(false),
                    const SizedBox(width: VisionSizes.mediumM18),
                    _boxToAlternativeLogin(true),
                  ],
                ),
                const SizedBox(height: VisionSizes.largeL36),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: VisionSizes.smallS2,
                        endIndent: VisionSizes.largeL32,
                      ),
                    ),
                    Text(
                      'Or Sign up With',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: VisionColors.onSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: VisionSizes.smallS1,
                        indent: VisionSizes.largeL32,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: VisionSizes.largeL42),
                VisionTextForm(
                  label: 'Email',
                  controller: _emailEC,
                  validator: _controller.validateEmail,
                ),
                SizedBox(height: VisionSizes.mediumM14),
                VisionTextForm(
                  label: 'Password',
                  controller: _passwordEC,
                  isPassword: true,
                  validator: _controller.validatePassword,
                ),
                SizedBox(height: VisionSizes.mediumM14),
                VisionTextForm(
                  label: 'Confirm your Password',
                  controller: _confirmPasswordEC,
                  isPassword: true,
                  validator: _validateConfirmPassword,
                ),

                const SizedBox(height: VisionSizes.largeL42),
                Observer(
                  builder: (context) {
                    return VisionButton(
                      textButton: 'Create Account',
                      isLoading: _controller.isLoading,
                      onPressed: _signUp,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    final email = _emailEC.text;
    final password = _passwordEC.text;
    Navigator.pushNamed(
      context,
      VisionRoutes.onBoardUser,
      arguments: {"email": email, "password": password},
    );
    // if (_formKey.currentState!.validate()) {
    //   final email = _emailEC.text;
    //   final password = _passwordEC.text;

    //   final result = await _controller.register(email, password);
    //   result.fold(
    //     (error) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text('Registration failed: ${error.toString()}')),
    //       );
    //     },
    //     (success) {
    //       Navigator.pushNamed(
    //         context,
    //         VisionRoutes.onBoardUser,
    //         arguments: {"email": email, "password": password},
    //       );
    //     },
    //   );
    // }
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirme sua senha';
    }
    if (value != _passwordEC.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  Widget _boxToAlternativeLogin(bool isApple) {
    return Container(
      width: 70,
      height: 70,
      alignment: Alignment.center,

      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isApple ? VisionColors.onSecondary : VisionColors.primary,
      ),
      child: SvgPicture.asset(
        isApple ? VisionAssets.appleLogo : VisionAssets.googleLogo,
        width: 30,
        height: 30,
      ),
    );
  }
}
