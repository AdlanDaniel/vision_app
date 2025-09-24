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
import 'package:vision_app/features/auth/pages/login/controller/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = InjectionManager.i.get<LoginController>();
  final TextEditingController _emailEC = TextEditingController(text:'dan@email.com');
  final TextEditingController _passwordEC = TextEditingController(text:'12345678');
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: VisionSizes.mediumM12,
            right: VisionSizes.mediumM12,
            bottom: VisionSizes.mediumM12,
          ),
          child: Form(
            key: _formKey,
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
                  'Welcome Back',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontSize: 24),
                ),
                const SizedBox(height: VisionSizes.mediumM12),
                Text(
                  'Look who is here!',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: VisionSizes.largeL70),
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

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, VisionRoutes.forgotPassword);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: VisionColors.onPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: VisionSizes.largeL42),
                Observer(
                  builder: (context) {
                    return VisionButton(
                      textButton: 'Login',
                      isLoading: _controller.isLoading,
                      onPressed: _login,
                    );
                  },
                ),
                const SizedBox(height: VisionSizes.largeL48),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: VisionSizes.smallS2,
                        endIndent: VisionSizes.largeL32,
                      ),
                    ),
                    Text(
                      'Or Sign in With',
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
                const SizedBox(height: VisionSizes.mediumM24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _boxToAlternativeLogin(false),
                    const SizedBox(width: VisionSizes.mediumM18),
                    _boxToAlternativeLogin(true),
                  ],
                ),
                const SizedBox(height: VisionSizes.largeL42),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don’t have an account? ',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: VisionColors.onSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign Up!',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: VisionColors.onPrimary,
                            ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(
                              context,
                              VisionRoutes.registerUser,
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailEC.text;
      final password = _passwordEC.text;
      final result = await _controller.login(email, password);
      result.fold(
        (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error), backgroundColor: Colors.red),
          );
        },
        (success) {
          Navigator.pushReplacementNamed(context, VisionRoutes.home);
        },
      );
    }
  }

  Future<void> _loginWithGoogle() async {
    final result = await _controller.loginWithGoogle();
    result.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: Colors.red),
        );
      },
      (success) {
        Navigator.pushReplacementNamed(context, VisionRoutes.home);
      },
    );
  }

  Widget _boxToAlternativeLogin(bool isApple) {
    return InkWell(
      onTap: !isApple ? _loginWithGoogle : null,
      child: Container(
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
      ),
    );
  }
}
