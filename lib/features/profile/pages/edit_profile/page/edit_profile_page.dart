import 'package:flutter/material.dart';
import 'package:vision_app/core/ui/theme/vision_colors.dart';
import 'package:vision_app/core/ui/widgets/vis_avatar_profile_widget.dart';
import 'package:vision_app/core/ui/widgets/vision_button.dart';
import 'package:vision_app/core/ui/widgets/vision_text_form.dart';
import 'package:vision_app/core/utils/constants/sizes/sizes.dart';
import 'package:vision_app/features/auth/repository/model/user_model.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel? user;
  const EditProfilePage({super.key, this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
                      'Edit',
                      style: TextStyle(
                        color: VisionColors.onBackground,
                        fontSize: VisionSizes.mediumM24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: VisionSizes.mediumM14),
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: VisionColors.onBackground,
                        fontSize: VisionSizes.mediumM24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: VisionSizes.largeL42),
                    _profilePhotoWidget(widget.user),
                    SizedBox(height: VisionSizes.largeL42),
                    VisionTextForm(
                      label: 'Name',
                      initialValue: widget.user?.name,
                    ),
                  ],
                ),
              ),
            ),
            VisionButton(onPressed: () {}, textButton: 'Update Profile'),
          ],
        ),
      ),
    );
  }

  Widget _profilePhotoWidget(UserModel? user) {
    return Row(
      children: [
        VisAvatarUserWidget(
          imageUrl: user?.profilePhoto,
          name: user?.name,
          size: 110,
          minSize: 80,
          maxSize: 110,
          onChangePhoto: (filePhoto) {},
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
