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
import 'package:vision_app/features/auth/pages/on_board/controller/on_board_controller.dart';

class OnBoardUserPage extends StatefulWidget {
  final String email;
  final String password;
  const OnBoardUserPage({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<OnBoardUserPage> createState() => _OnBoardUserPageState();
}

class _OnBoardUserPageState extends State<OnBoardUserPage> {
  final _controller = InjectionManager.i.get<OnBoardController>();
  final TextEditingController _nameEC = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: VisionSizes.mediumM12,
            right: VisionSizes.mediumM12,
            bottom: VisionSizes.mediumM12,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  VisionAssets.logo,
                  alignment: Alignment.center,
                  width: 32,
                  height: 32,
                ),
                const SizedBox(height: VisionSizes.largeL60),
                Text(
                  'Tell us more!',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontSize: 24),
                ),
                const SizedBox(height: VisionSizes.mediumM12),
                Text(
                  'Complete your profile',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: VisionSizes.largeL60),

                _boxChoosePhotoWidget(),
                const SizedBox(height: VisionSizes.largeL60),

                VisionTextForm(
                  label: 'Your Name',
                  controller: _nameEC,
                  validator: _controller.validateNome,
                ),

                const SizedBox(height: VisionSizes.largeL70),
                Observer(
                  builder: (context) {
                    return VisionButton(
                      width: 230,
                      isLoading: _controller.isLoading,
                      textButton: 'Continue',
                      onPressed: _finishOnBoard,
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
        ),
      ),
    );
  }

  Future<void> _finishOnBoard() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameEC.text;

      final result = await _controller.finishOnBoarding(name);
      result.fold(
        (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration failed: ${error.toString()}')),
          );
        },
        (success) async {
          final result = await _controller.loginWithOnBoard(
            email: widget.email,
            password: widget.password,
          );
          result.fold(
            (error) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Login falhou!')));
            },
            (success) {
              Navigator.pushReplacementNamed(context, VisionRoutes.home);
            },
          );
        },
      );
    }
  }

  Widget _boxChoosePhotoWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 116,
          height: 116,
          alignment: Alignment.center,

          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(VisionSizes.largeL32),
            color: VisionColors.primary,
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.camera_enhance_outlined,
              size: 24,
              color: VisionColors.onPrimary,
            ),
          ),
        ),
        const SizedBox(width: VisionSizes.mediumM20),
        SizedBox(
          width: 92,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CHOOSE IMAGE',

                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: VisionColors.onBackground,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: VisionSizes.smallS8),
              Text(
                'A square .jpg, .gif, or .png image 200x200 or larger',
                softWrap: true,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: VisionColors.onBackground,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
