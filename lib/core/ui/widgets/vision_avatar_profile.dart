import 'package:flutter/material.dart';

class VisionAvatarUser extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double? size; // opcional, se não passar vai calcular
  final double minSize; // limite mínimo
  final double maxSize; // limite máximo

  const VisionAvatarUser({
    super.key,
    this.imageUrl,
    this.name,
    this.size,
    this.minSize = 32, // padrão
    this.maxSize = 80, // padrão
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // define tamanho (fixo ou proporcional à tela)
    double avatarSize = size ?? screenWidth * 0.12;

    // aplica limites
    avatarSize = avatarSize.clamp(minSize, maxSize);

    return CircleAvatar(
      radius: avatarSize / 2,
      backgroundColor: Colors.grey[300],
      backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
          ? NetworkImage(imageUrl!)
          : null,
      child: (imageUrl == null || imageUrl!.isEmpty)
          ? Text(
              (name != null && name!.isNotEmpty)
                  ? name!.substring(0, 1).toUpperCase()
                  : "?",
              style: TextStyle(
                fontSize: avatarSize / 2,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}