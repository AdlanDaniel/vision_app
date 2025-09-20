import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:vision_app/core/injection/injection.dart';
import 'package:vision_app/core/ui/theme/vision_colors.dart';
import 'package:vision_app/core/ui/widgets/vision_button.dart';
import 'package:vision_app/core/utils/constants/assets.dart';
import 'package:vision_app/core/utils/constants/routes/vision_routes.dart';
import 'package:vision_app/core/utils/constants/sizes/sizes.dart';
import 'package:vision_app/features/auth/pages/login/controller/login_controller.dart';
import 'package:vision_app/features/auth/repository/model/user_model.dart';
import 'package:vision_app/features/profile/pages/profile_details/controller/profile_detail_controller.dart';

class ProfileDetailPage extends StatefulWidget {
  const ProfileDetailPage({super.key});

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  final _controller = InjectionManager.i.get<ProfileDetailController>();
  final _authController = InjectionManager.i.get<LoginController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _controller.fetchUserData();
    });
  }

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
        actions: [
          _OutlinedButton(onPressed: () {}, textButton: 'Edit Profile'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: VisionSizes.largeL32),
        child: Observer(
          builder: (context) {
            if (_controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(VisionSizes.mediumM16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        _profilePhotoWidget(_controller.user),
                        const SizedBox(height: VisionSizes.mediumM12),

                        SizedBox(height: VisionSizes.largeL30),
                        _optionCards(
                          title: 'Change Password',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              VisionRoutes.changePassword,
                            );
                          },
                        ),
                        SizedBox(height: VisionSizes.mediumM12),
                        _optionCards(
                          title: 'Delete my account',
                          onTap: () {
                            _dialogDeleteAccount(context);
                          },
                        ),
                        const SizedBox(height: VisionSizes.largeL36),
                        Text(
                          "Subscriptions",
                          style: TextStyle(
                            color: VisionColors.onBackground,
                            fontSize: VisionSizes.mediumM18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _cardSubscription(
                          title: 'STREAM Premium',
                          subtitle: 'Jan 22, 2023',
                        ),

                        const SizedBox(height: VisionSizes.largeL36),

                        const Text(
                          "History",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _controller
                                .historicMovies
                                .length, // quantidade de itens
                            itemBuilder: (context, index) {
                              final movie = _controller.historicMovies[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: _buildHistoryCard(
                                  movie.name ?? 'Unknown',
                                  movie.year ?? '',
                                  movie.imageUrl!,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _OutlinedButton(textButton: 'Log Out', onPressed: _logout),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _logout() async {
    final result = await _authController.logout();
    return result.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: Colors.red),
        );
      },
      (message) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          VisionRoutes.login,
          (route) => false,
        );
      },
    );
  }

  Widget _buildHistoryCard(String title, String year, String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),

      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image.asset(VisionAssets.showingMovie, fit: BoxFit.cover, width: 165),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black87, Colors.black54, Colors.black26],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$title - $year',
              style: TextStyle(
                fontSize: VisionSizes.mediumM12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profilePhotoWidget(UserModel? user) {
    return Row(
      children: [
        Container(
          height: 110,
          width: 110,
          decoration: BoxDecoration(
            color: user?.profilePhoto == null
                ? VisionColors.surface
                : Colors.white,
            shape: BoxShape.circle,
            image: user?.profilePhoto != null
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.network(
                      user!.profilePhoto!,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(VisionAssets.userImage);
                      },
                    ).image,
                  )
                : const DecorationImage(
                    image: AssetImage(VisionAssets.userImage),
                  ),
          ),
        ),
        SizedBox(width: VisionSizes.mediumM16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello,",
              style: TextStyle(
                color: VisionColors.onBackground,
                fontSize: VisionSizes.mediumM14,
              ),
            ),
            SizedBox(height: VisionSizes.mediumM14),
            Text(
              user?.name ?? 'User',
              style: TextStyle(
                color: VisionColors.onBackground,
                fontSize: VisionSizes.mediumM24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _optionCards({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: VisionSizes.mediumM16),
        height: 60,
        decoration: BoxDecoration(
          color: VisionColors.secondary,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(VisionSizes.mediumM16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              title == 'Change Password' ? Icons.shield_outlined : Icons.delete,
              color: VisionColors.onBackground,
              size: VisionSizes.mediumM18,
            ),
            SizedBox(width: VisionSizes.smallS10),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: VisionSizes.mediumM16,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: VisionColors.onBackground,
              size: VisionSizes.mediumM14,
            ),
          ],
        ),
      ),
    );
  }

  _cardSubscription({required String title, required String subtitle}) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, VisionRoutes.detailPlan);
      },
      child: Container(
        padding: const EdgeInsets.all(VisionSizes.mediumM12),
        decoration: BoxDecoration(
          color: VisionColors.secondary,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(VisionSizes.mediumM16),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: VisionColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "STREAM Premium",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: VisionSizes.smallS8),
                  Text(
                    "Jan 22, 2023",
                    style: TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                ],
              ),
            ),
            Text(
              "Coming soon",
              style: TextStyle(color: VisionColors.onPrimary),
            ),
          ],
        ),
      ),
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
                          'Are you sure you want to delete your account?',
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
                          'Are you sure you want to delete your account? This action is irreversible and all of your data will be permanently deleted. If you\'re having any issues with our app, we\'d love to help you resolve them.',
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
                            isLoading: _controller.isLoading,
                            textButton: 'Delete Account',
                            onPressed: _deleteAccount,
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

  Future<void> _deleteAccount() async {
    final result = await _controller.deleteAccount();
    result.fold(
      (error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error)));
      },
      (success) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(success)));
        Navigator.pushNamedAndRemoveUntil(
          context,
          VisionRoutes.registerUser,
          (route) => false,
        );
      },
    );
  }
}

class _OutlinedButton extends StatelessWidget {
  final String textButton;
  final VoidCallback onPressed;

  const _OutlinedButton({required this.textButton, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: VisionColors.primary,
          width: VisionSizes.smallS2,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: onPressed,
      child: Text(
        textButton,
        style: TextStyle(
          color: VisionColors.onPrimary,
          fontSize: VisionSizes.mediumM14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
