import 'package:elbahaa/core/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:pod_player/pod_player.dart';

class PlayVideoFromVimeo extends StatefulWidget {
  final String vimeoVideoUrl;
  const PlayVideoFromVimeo({Key? key, required this.vimeoVideoUrl}) : super(key: key);

  @override
  State<PlayVideoFromVimeo> createState() => _PlayVideoFromVimeoState();
}

class _PlayVideoFromVimeoState extends State<PlayVideoFromVimeo> {
  late final PodPlayerController controller;

  @override
  void initState() {
    String videoId = widget.vimeoVideoUrl;
    String token = Constants.vimeoToken;
    final Map<String, String> headers = <String, String>{
      // 'content-type': 'application/json;charset=utf-8',
      // 'charset': 'utf-8',
      // "authorization" : "bearer $token"
    };
    headers['Authorization'] = 'Bearer $token';

    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.vimeoPrivateVideos(
          videoId,
          httpHeaders: headers
      ),
      podPlayerConfig: const PodPlayerConfig(
          autoPlay: true,
          isLooping: false,
          videoQualityPriority: [720, 360]
      ),
    )..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PodVideoPlayer(controller: controller);
  }
}