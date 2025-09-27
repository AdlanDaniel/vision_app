import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vision_app/core/ui/theme/vision_colors.dart';
import 'package:vision_app/core/ui/widgets/vision_pick_image.dart';
import 'package:vision_app/core/utils/constants/sizes/sizes.dart';

class VisionBoxChooseImage extends StatefulWidget {
  final Function(XFile?) onSelectedImage;
  const VisionBoxChooseImage({super.key, required this.onSelectedImage});

  @override
  State<VisionBoxChooseImage> createState() => _VisionBoxChooseImageState();
}

class _VisionBoxChooseImageState extends State<VisionBoxChooseImage> {
  Uint8List? _imageBytes;

  Future<void> _loadImageBytes(XFile? image) async {
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 116,
          height: 116,
          alignment: Alignment.center,

          decoration: BoxDecoration(
            image: (_imageBytes != null && _imageBytes!.isNotEmpty)
                ? DecorationImage(
                    image: MemoryImage(_imageBytes!),
                    fit: BoxFit.cover,
                  )
                : null,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(VisionSizes.largeL32),
            color: VisionColors.primary,
          ),

          child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _optionsPickImage();
                },
              );
            },
            icon: Icon(
              Icons.camera_enhance_outlined,
              size: 24,
              color: VisionColors.primary,
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

  Widget _optionsPickImage() {
    return Dialog(
      backgroundColor: VisionColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "CHOOSE IMAGE",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Botões de opção
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                VisionPickImage(
                  label: "Take a photo",
                  isFromCamera: true,

                  icon: Icons.camera_enhance_outlined,
                  color: VisionColors.primary,
                  onImageSelected: (image) {
                    _loadImageBytes(image);
                    widget.onSelectedImage(image);
                  },
                ),
                VisionPickImage(
                  label: "Choose from gallery",
                  icon: Icons.photo,
                  isFromCamera: false,
                  color: VisionColors.secondary,
                  onImageSelected: (image) {
                    _loadImageBytes(image);
                    widget.onSelectedImage(image);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
