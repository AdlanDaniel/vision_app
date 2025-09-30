import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vision_app/core/ui/theme/vision_colors.dart';
import 'package:vision_app/core/ui/widgets/vision_pick_image.dart';

class VisAvatarUserWidget extends StatefulWidget {
  final String? imageUrl;
  final String? name;
  final double? size;
  final double minSize; // limite mínimo
  final double maxSize; // limite máximo
  final VoidCallback? onTap;
  final Function(XFile?)? onChangePhoto;

  const VisAvatarUserWidget({
    super.key,
    this.imageUrl,
    this.name,
    this.size,
    this.minSize = 32, // padrão
    this.maxSize = 80, // padrão
    this.onTap,
    this.onChangePhoto,
  });

  @override
  State<VisAvatarUserWidget> createState() => _VisAvatarUserWidgetState();
}

class _VisAvatarUserWidgetState extends State<VisAvatarUserWidget> {
  Uint8List? _imageSelectedBytes;

  Future<void> _loadImageBytes(XFile? image) async {
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _imageSelectedBytes = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // define tamanho (fixo ou proporcional à tela)
    double avatarSize = widget.size ?? screenWidth * 0.1;

    // aplica limites
    avatarSize = avatarSize.clamp(widget.minSize, widget.maxSize);

    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: [
          CircleAvatar(
            radius: avatarSize / 2,
            backgroundColor: Color(0xFFBC4CF1),
            // backgroundImage: widget.imageUrl != null && widget.imageUrl!.isNotEmpty
            //     ? NetworkImage(widget.imageUrl!)
            //     : null,
            // child: (imageUrl == null || imageUrl!.isEmpty)
            //     ? Text(
            //         (name != null && name!.isNotEmpty)
            //             ? name!.substring(0, 1).toUpperCase()
            //             : "?",
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //           fontSize: avatarSize / 1.5,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.white,
            //         ),
            //       )
            //     : null,
            // child: widget.imageUrl == null
            //     ? Icon(
            //         Icons.person,
            //         // size: VisionSizes.largeL32,
            //         size: avatarSize / 1.5,
            //         color: Colors.white,
            //       )
            //     : null,
            backgroundImage: _imageSelectedBytes != null
                ? MemoryImage(_imageSelectedBytes!)
                : (widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                      ? NetworkImage(widget.imageUrl!)
                      : null),
            child:
                (_imageSelectedBytes == null &&
                    (widget.imageUrl == null || widget.imageUrl!.isEmpty))
                ? Icon(
                    Icons.person,
                    size: avatarSize / 1.5,
                    color: Colors.white,
                  )
                : null,
          ),
          if (widget.onChangePhoto != null)
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return _optionsPickImage();
                    },
                  );
                },
                child: Container(
                  width: avatarSize * 0.35,
                  height: avatarSize * 0.35,
                  decoration: BoxDecoration(
                    color: Colors.brown, // cor de fundo
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: avatarSize * 0.18,
                    color: Colors.purpleAccent, // cor do ícone
                  ),
                ),
              ),
            ),
        ],
      ),
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
                    widget.onChangePhoto!(image);
                  },
                ),
                VisionPickImage(
                  label: "Choose from gallery",
                  icon: Icons.photo,
                  isFromCamera: false,
                  color: VisionColors.secondary,
                  onImageSelected: (image) {
                    _loadImageBytes(image);
                    widget.onChangePhoto!(image);
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
