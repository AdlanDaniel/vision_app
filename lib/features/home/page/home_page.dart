import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:vision_app/core/injection/injection.dart';
import 'package:vision_app/core/ui/theme/vision_colors.dart';
import 'package:vision_app/core/ui/widgets/vision_button.dart';
import 'package:vision_app/core/ui/widgets/vision_shimmer.dart';
import 'package:vision_app/core/utils/constants/assets.dart';
import 'package:vision_app/core/utils/constants/routes/vision_routes.dart';
import 'package:vision_app/core/utils/constants/sizes/sizes.dart';
import 'package:vision_app/features/home/controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = InjectionManager.i.get<HomeController>();
  String? imageUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // _controller.fetchUtilsHome();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7C7C7C),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff7C7C7C),
              Color.fromARGB(255, 43, 41, 41),
              Color.fromARGB(255, 43, 41, 41),
              Color.fromARGB(255, 43, 41, 41),
              Color.fromARGB(255, 26, 25, 25),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Spacer(flex: 2),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            VisionAssets.logo,
                            width: 35,
                            height: 35,
                          ),
                          _profilePhotoWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Now Showing",

                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontSize: VisionSizes.mediumM18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                        ),
                      ),
                      const SizedBox(height: VisionSizes.mediumM12),
                      Observer(
                        builder: (context) {
                          return _controller.isLoading
                              ? const _HomeShimmerPage()
                              : Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),

                                    boxShadow: [
                                      BoxShadow(
                                        color: VisionColors.primary.withValues(
                                          alpha: 1,
                                        ),
                                        offset: const Offset(0, -20),
                                        blurRadius: 100,
                                      ),
                                      BoxShadow(
                                        color: Colors.white60,
                                        offset: const Offset(0, -20),
                                        blurRadius: 50,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        // Image.asset(
                                        //   _controller.movie?.imageMovie ??
                                        //       VisionAssets.showingMovie,
                                        //   height:
                                        //       MediaQuery.of(
                                        //         context,
                                        //       ).size.height *
                                        //       0.75,
                                        //   width: double.infinity,
                                        //   fit: BoxFit.cover,
                                        // ),
                                        _buildImageMovie(),

                                        Container(
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              0.75,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Colors.black87,
                                                Colors.black54,
                                                Colors.black26,
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(
                                            VisionSizes.mediumM18,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _controller.movie?.type ??
                                                    'Genre Unavailable',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      letterSpacing:
                                                          VisionSizes
                                                              .mediumM14 *
                                                          0.05,
                                                    ),
                                              ),
                                              SizedBox(
                                                height: VisionSizes.smallS8,
                                              ),
                                              Text(
                                                _controller.movie?.name ??
                                                    'Name Unavailable',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      letterSpacing:
                                                          VisionSizes.largeL32 *
                                                          0.015,
                                                    ),
                                              ),
                                              SizedBox(
                                                height: VisionSizes.mediumM12,
                                              ),
                                              Text(
                                                _controller.movie?.sinopse ??
                                                    'Sinopse Unavailable',
                                                maxLines: 5,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      color: Color(0xffD9DADE),
                                                      letterSpacing:
                                                          VisionSizes
                                                              .mediumM14 *
                                                          0.045,
                                                      height: 1.64,
                                                    ),
                                              ),
                                              const SizedBox(
                                                height: VisionSizes.mediumM12,
                                              ),

                                              _cardComments(),
                                              SizedBox(
                                                height: VisionSizes.mediumM18,
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: VisionButton(
                                                  textButton: 'Watch',
                                                  onPressed: () {},
                                                ),
                                              ),
                                              SizedBox(
                                                height: VisionSizes.mediumM14,
                                              ),
                                              _divider(),
                                              SizedBox(
                                                height: VisionSizes.mediumM14,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Observer(
                                                    builder: (context) {
                                                      return _actionIcon(
                                                        icon:
                                                            _controller
                                                                    .movie
                                                                    ?.idLike ==
                                                                null
                                                            ? Icons
                                                                  .favorite_border
                                                            : Icons.favorite,
                                                        title:
                                                            _controller
                                                                    .quantityMovieLikes !=
                                                                null
                                                            ? _controller
                                                                  .quantityMovieLikes
                                                                  .toString()
                                                            : '0',
                                                        onTap: () {
                                                          if (_controller
                                                              .isMovieLiked) {
                                                            _controller
                                                                .unlikeMovie();
                                                          } else {
                                                            _controller
                                                                .likeMovie();
                                                          }
                                                        },
                                                      );
                                                    },
                                                  ),
                                                  _actionIcon(
                                                    icon: Icons.share,
                                                    title: 'Gift to Someone?',
                                                    onTap: () {},
                                                  ),
                                                  _availableData(),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageMovie() {
    if (_controller.movie?.imageMovie == null ||
        _controller.movie?.imageMovie == '') {
      return VisionShimmer(
        height: MediaQuery.of(context).size.height * 0.75,
        width: double.infinity,
      );
    }
    return Image.network(
      _controller.movie!.imageMovie!,
      height: MediaQuery.of(context).size.height * 0.75,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return VisionShimmer(
          height: MediaQuery.of(context).size.height * 0.75,
          width: double.infinity,
        );
      },
    );
  }

  Widget _profilePhotoWidget() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, VisionRoutes.detailProfile);
      },
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: imageUser == null ? VisionColors.surface : Colors.white,
          shape: BoxShape.circle,
          image: imageUser != null
              ? DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.network(
                    imageUser!,
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
    );
  }

  Widget _cardComments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _controller.movie?.comments == null
              ? "Comments Unavailable"
              : "Comments ${_controller.movie!.comments!.length} ",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white,
            letterSpacing: VisionSizes.mediumM12 * 0.005,
            height: VisionSizes.smallS1,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: VisionSizes.smallS6),
        Row(
          children: [
            Row(
              children: [
                Visibility(
                  visible:
                      _controller.movie?.comments == null ||
                          _controller.movie!.comments!.isEmpty
                      ? false
                      : true,
                  child: Container(
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.lightBlue,
                    ),
                    child: Text(
                      _controller.movie?.comments == null ||
                              _controller.movie!.comments!.isEmpty
                          ? ''
                          : _controller.movie!.comments!.first.characters.first
                                .toUpperCase(),

                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: VisionSizes.mediumM14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: VisionSizes.smallS4),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    _controller.movie?.comments == null ||
                            _controller.movie!.comments!.isEmpty
                        ? 'No comments available'
                        : _controller.movie!.comments!.first,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: VisionSizes.smallS10 * 1.1,
                      fontWeight: FontWeight.w400,
                      height: VisionSizes.smallS2,
                      letterSpacing: VisionSizes.smallS10 * 1.1 * 0.045,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              ],
            ),
            const Spacer(flex: 2),
          ],
        ),
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

  Widget _actionIcon({
    required IconData icon,
    required String title,
    required Function onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: () => onTap(),
          child: Icon(icon, color: Colors.white, size: VisionSizes.mediumM20),
        ),
        SizedBox(height: VisionSizes.smallS6),
        Text(
          title,
          style: TextStyle(
            color: Colors.white70,
            fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
          ),
        ),
      ],
    );
  }

  Widget _availableData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Available until",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white70,
            fontSize: VisionSizes.mediumM12,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          _controller.movie?.availableDate != null
              ? DateFormat(
                  'dd/MM/yyyy',
                ).format(_controller.movie!.availableDate!)
              : 'Unavailable Data',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _HomeShimmerPage extends StatelessWidget {
  const _HomeShimmerPage();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Poster
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black87, Colors.black54, Colors.black26],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(VisionSizes.mediumM18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VisionShimmer(
                  height: VisionSizes.mediumM16,
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                const SizedBox(height: VisionSizes.smallS8),
                VisionShimmer(
                  height: VisionSizes.largeL30,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                const SizedBox(height: VisionSizes.mediumM12),
                VisionShimmer(
                  height: VisionSizes.mediumM16,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
                const SizedBox(height: VisionSizes.smallS4),
                VisionShimmer(
                  height: VisionSizes.mediumM14,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
                const SizedBox(height: VisionSizes.smallS4),
                VisionShimmer(
                  height: VisionSizes.mediumM14,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
                const SizedBox(height: VisionSizes.smallS4),
                VisionShimmer(
                  height: VisionSizes.mediumM14,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
                const SizedBox(height: VisionSizes.smallS4),
                VisionShimmer(
                  height: VisionSizes.mediumM14,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
                const SizedBox(height: VisionSizes.mediumM24),
                VisionShimmer(
                  height: VisionSizes.mediumM12,
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
                const SizedBox(height: VisionSizes.smallS4),
                VisionShimmer(
                  height: VisionSizes.mediumM12,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),

                const SizedBox(height: VisionSizes.largeL36),
                Align(
                  alignment: Alignment.center,
                  child: VisionShimmer(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
                const SizedBox(height: VisionSizes.mediumM14),
                _divider(),
                const SizedBox(height: VisionSizes.mediumM14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        VisionShimmer(
                          height: VisionSizes.mediumM20,
                          width: VisionSizes.mediumM20,
                        ),
                        const SizedBox(height: VisionSizes.smallS2),
                        VisionShimmer(
                          height: VisionSizes.smallS6,
                          width: VisionSizes.mediumM20,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        VisionShimmer(
                          height: VisionSizes.mediumM20,
                          width: VisionSizes.mediumM20,
                        ),
                        const SizedBox(height: VisionSizes.smallS2),
                        VisionShimmer(
                          height: VisionSizes.smallS6,
                          width: VisionSizes.mediumM20,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        VisionShimmer(
                          height: VisionSizes.smallS10,
                          width: MediaQuery.of(context).size.width * 0.25,
                        ),
                        const SizedBox(height: VisionSizes.smallS6),
                        VisionShimmer(
                          height: VisionSizes.smallS10,
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Divider _divider() {
    return Divider(
      color: Colors.white.withValues(alpha: 0.2),
      thickness: VisionSizes.smallS1,
      height: VisionSizes.mediumM18,
    );
  }
}
