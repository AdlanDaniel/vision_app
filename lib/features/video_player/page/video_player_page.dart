import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage>
    with WidgetsBindingObserver {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isFullScreen = false;
  bool _isTransitioning = false;
  NativeDeviceOrientation? _orientation = NativeDeviceOrientation.unknown;
  StreamSubscription<NativeDeviceOrientation>? _orientationSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeVideo();
    _listenToOrientationChanges();
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      ),
    );

    await _controller.initialize();
    setState(() {});
  }

  void _listenToOrientationChanges() {
    _orientationSubscription = NativeDeviceOrientationCommunicator()
        .onOrientationChanged(useSensor: true)
        .listen((orientation) async {
          if (orientation == _orientation || _isTransitioning) return;
          _orientation = orientation;


          if (orientation == NativeDeviceOrientation.landscapeLeft ||
              orientation == NativeDeviceOrientation.landscapeRight) {
            if (!_isFullScreen) await _enterFullScreen();
          } else if (orientation == NativeDeviceOrientation.portraitUp ||
              orientation == NativeDeviceOrientation.portraitDown) {
            if (_isFullScreen) await _exitFullScreen();
          }
        });
  }

  @override
  void dispose() {
    _orientationSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    _exitFullScreen();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  Future<void> _enterFullScreen() async {
    if (_isTransitioning) return;
    _isTransitioning = true;

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    setState(() => _isFullScreen = true);
    _isTransitioning = false;
  }

  Future<void> _exitFullScreen() async {
    if (_isTransitioning) return;
    _isTransitioning = true;

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    setState(() => _isFullScreen = false);
    _isTransitioning = false;
  }

  void _toggleFullScreen() async {
    if (_isFullScreen) {
      await _exitFullScreen();
    } else {
      await _enterFullScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isFullScreen
          ? null
          : AppBar(title: const Text("Player de Vídeo")),
      body: Center(
        child: _controller.value.isInitialized
            ? Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  _buildControls(context),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildControls(BuildContext context) {
    return Container(
      color: Colors.black45,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
            colors: const VideoProgressColors(
              playedColor: Colors.red,
              bufferedColor: Colors.white54,
              backgroundColor: Colors.black26,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  _isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_fill,
                  color: Colors.white,
                  size: 36,
                ),
                onPressed: _togglePlay,
              ),
              IconButton(
                icon: Icon(
                  _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: _toggleFullScreen,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerPage extends StatefulWidget {
//   const VideoPlayerPage({super.key});

//   @override
//   State<VideoPlayerPage> createState() => _VideoPlayerPageState();
// }

// class _VideoPlayerPageState extends State<VideoPlayerPage>
//     with WidgetsBindingObserver {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;
//   bool _isFullScreen = false;
//   bool _ignoreAutoRotation = false; // evita conflito entre rotação e botão

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);

//     _controller =
//         VideoPlayerController.networkUrl(
//             Uri.parse(
//               "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
//             ),
//           )
//           ..initialize().then((_) {
//             if (!mounted) return;
//             setState(() {});
//           });
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _controller.dispose();
//     _exitFullScreen();
//     super.dispose();
//   }

//   Future<void> _enterFullScreen({bool auto = false}) async {
//     if (!auto) _ignoreAutoRotation = true;

//     await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//     await SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);

//     setState(() => _isFullScreen = true);

//     if (!auto) {
//       await Future.delayed(const Duration(milliseconds: 700));
//       _ignoreAutoRotation = false;
//     }
//   }

//   Future<void> _exitFullScreen({bool auto = false}) async {
//     if (!auto) _ignoreAutoRotation = true;

//     await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     await SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);

//     setState(() => _isFullScreen = false);

//     if (!auto) {
//       await Future.delayed(const Duration(milliseconds: 700));
//       _ignoreAutoRotation = false;
//     }
//   }

//   void _togglePlay() {
//     if (!_controller.value.isInitialized) return;
//     setState(() {
//       if (_controller.value.isPlaying) {
//         _controller.pause();
//         _isPlaying = false;
//       } else {
//         _controller.play();
//         _isPlaying = true;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return OrientationBuilder(
//       builder: (context, orientation) {
//         if (!_ignoreAutoRotation) {
//           // entra/sai automaticamente ao girar o aparelho
//           if (orientation == Orientation.landscape && !_isFullScreen) {
//             _enterFullScreen(auto: true);
//           } else if (orientation == Orientation.portrait && _isFullScreen) {
//             _exitFullScreen(auto: true);
//           }
//         }

//         return WillPopScope(
//           onWillPop: () async {
//             if (_isFullScreen) {
//               await _exitFullScreen();
//               return false;
//             }
//             return true;
//           },
//           child: Scaffold(
//             appBar: _isFullScreen
//                 ? null
//                 : AppBar(title: const Text("Player de Vídeo")),
//             backgroundColor: Colors.black,
//             body: Center(
//               child: _controller.value.isInitialized
//                   ? Stack(
//                       alignment: Alignment.bottomCenter,
//                       children: [
//                         AspectRatio(
//                           aspectRatio: _controller.value.aspectRatio,
//                           child: VideoPlayer(_controller),
//                         ),
//                         _buildControls(context),
//                       ],
//                     )
//                   : const CircularProgressIndicator(),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildControls(BuildContext context) {
//     return Container(
//       color: Colors.black45,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           VideoProgressIndicator(
//             _controller,
//             allowScrubbing: true,
//             colors: const VideoProgressColors(
//               playedColor: Colors.red,
//               bufferedColor: Colors.white54,
//               backgroundColor: Colors.black26,
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 icon: Icon(
//                   _isPlaying
//                       ? Icons.pause_circle_filled
//                       : Icons.play_circle_fill,
//                   color: Colors.white,
//                   size: 36,
//                 ),
//                 onPressed: _togglePlay,
//               ),
//               IconButton(
//                 icon: Icon(
//                   _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//                 onPressed: () async {
//                   if (_isFullScreen) {
//                     await _exitFullScreen();
//                   } else {
//                     await _enterFullScreen();
//                   }
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
