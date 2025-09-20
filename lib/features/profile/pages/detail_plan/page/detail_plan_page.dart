import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:svg_flutter/svg.dart';
import 'package:vision_app/core/injection/injection.dart';
import 'package:vision_app/core/ui/theme/vision_colors.dart';
import 'package:vision_app/core/ui/widgets/vision_button.dart';
import 'package:vision_app/core/utils/constants/assets.dart';
import 'package:vision_app/core/utils/constants/sizes/sizes.dart';
import 'package:vision_app/features/profile/pages/detail_plan/controller/detail_plan_controller.dart';

class DetailPlanPage extends StatefulWidget {
  const DetailPlanPage({super.key});

  @override
  State<DetailPlanPage> createState() => _DetailPlanPageState();
}

class _DetailPlanPageState extends State<DetailPlanPage> {
  final _controller = InjectionManager.i.get<DetailPlanController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Subscription',
          style: TextStyle(color: VisionColors.onBackground),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: VisionColors.onPrimary),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: VisionSizes.mediumM18,
          vertical: VisionSizes.largeL30,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                VisionAssets.logoWithTitle,
                alignment: Alignment.center,
                width: 132,
                height: 92,
              ),
              const SizedBox(height: VisionSizes.largeL48),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: VisionSizes.mediumM12),
                  itemCount: _controller.plans.benefits?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final benefit = _controller.plans.benefits?[index] ?? '';
                    return _cardBenefit(benefit);
                  },
                ),
              ),
              const SizedBox(height: VisionSizes.mediumM24),
              _descriptionPlanWidget(),
              VisionButton(
                textButton: 'Terminate Plan',
                onPressed: () {
                  _dialogDeleteAccount(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardBenefit(String benefit) {
    return Padding(
      padding: EdgeInsets.only(bottom: VisionSizes.largeL30),
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: VisionColors.onPrimary,
            size: VisionSizes.mediumM20,
          ),
          SizedBox(width: VisionSizes.smallS4),
          Expanded(
            child: Text(
              benefit,
              maxLines: 4,
              softWrap: true,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                letterSpacing: VisionSizes.mediumM14 * 0.005,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _descriptionPlanWidget() {
    final format = DateFormat('MMM d, yyyy');
    final dueDateFormatted = _controller.plans.dueDate != null
        ? format.format(_controller.plans.dueDate!)
        : '';
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _controller.plans.name ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: VisionSizes.mediumM16,
                letterSpacing: VisionSizes.mediumM14 * 0.005,
                height: 1,
              ),
            ),
            Text(
              dueDateFormatted,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: VisionSizes.mediumM16,
                letterSpacing: VisionSizes.mediumM14 * 0.005,
                height: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: VisionSizes.mediumM20),
        _divider(),
        const SizedBox(height: VisionSizes.mediumM20),
      ],
    );
  }

  Divider _divider() {
    return Divider(
      color: Colors.white.withValues(alpha: 0.2),
      thickness: VisionSizes.smallS1,
      height: VisionSizes.mediumM18,
    );
  }

  void _dialogDeleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(VisionSizes.mediumM12),
          ),
          child: Container(
            padding: const EdgeInsets.all(VisionSizes.mediumM24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Warning',
                    style: TextStyle(
                      color: VisionColors.onBackground,
                      fontSize: VisionSizes.mediumM16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: VisionSizes.largeL50),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Are you sure you want to cancel your subscription?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: VisionColors.onBackground,
                            fontSize: VisionSizes.mediumM16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: VisionSizes.mediumM16 * 0.02,
                          ),
                        ),
                        const SizedBox(height: VisionSizes.mediumM14),
                        Text(
                          'Please note that cancelling your plan will immediately revoke your access to all features. If you\'re experiencing any issues with our app, we\'d love to help you resolve them.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: VisionColors.onBackground,
                            fontSize: VisionSizes.mediumM16,
                            letterSpacing: VisionSizes.mediumM16 * 0.02,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      SizedBox(width: VisionSizes.mediumM12),
                      Observer(
                        builder: (context) {
                          return VisionButton(
                            width: 160,

                            textButton: 'Terminate Plan',
                            onPressed: () {},
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
