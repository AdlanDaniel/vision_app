// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vision_app/core/ui/theme/vision_colors.dart';

class VisionPickImage extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isFromCamera; //camera ou galeria
  final Function(XFile?) onImageSelected;

  const VisionPickImage({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onImageSelected,
    this.isFromCamera = true,
  });

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    ImageSource source = isFromCamera
        ? ImageSource.camera
        : ImageSource.gallery;
    final XFile? image = await picker.pickImage(source: source);
    onImageSelected(image);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pickImage();
        Navigator.of(context).pop();
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isFromCamera ? VisionColors.onPrimary : VisionColors.surface,
            width: 0.8,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isFromCamera ? VisionColors.onPrimary : Colors.white,
              size: 18,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(color: VisionColors.surface),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
