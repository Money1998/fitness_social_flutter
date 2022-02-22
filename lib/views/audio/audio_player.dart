import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/constants/assets_images.dart';
import 'package:montage/constants/svg_images.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/customs/wave_slider.dart';
import 'package:montage/model/track_detail.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/utilites.dart';

class AudioPlayerList extends StatefulWidget {
  final TrackDetail trackDetail;

  AudioPlayerList(this.trackDetail);

  @override
  _AudioPlayerListState createState() => _AudioPlayerListState(trackDetail);
}

class _AudioPlayerListState extends State<AudioPlayerList> {
  TrackDetail trackDetails;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool play = false;
  AudioPlayer _player = AudioPlayer();
  CarouselController carouse = new CarouselController();
  GlobalKey<WaveSliderState> _myKey = GlobalKey();
  int _index = 0;
  AudioSource _playlist;

  _AudioPlayerListState(this.trackDetails);

  @override
  void initState() {
    _playlist = ConcatenatingAudioSource(children: [
      for (var i = 0; i < trackDetails.playlists.length; i++)
        AudioSource.uri(
            Uri.parse(
                RequestCode.apiEndPoint + trackDetails.playlists[i].audio),
            tag: AudioMetadata(
              album: trackDetails.playlists[i].title,
              title: trackDetails.playlists[i].description,
              artwork:
                  RequestCode.apiEndPoint + trackDetails.playlists[i].image,
            ))
    ]);

    for (var i = 0; i < trackDetails.playlists.length; i++) {
      debugPrint(RequestCode.apiEndPoint + trackDetails.playlists[i].audio);
    }
    _init();
    super.initState();
  }

  Future<void> _init() async {
    try {
      await _player.setAudioSource(_playlist);
      _player.play();
    } catch (e) {
      // catch load errors: 404, invalid url ...
      print("An error occurred $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("ID " + widget.trackDetail.playlists.length.toString());

    return ResponsiveWidget(
        // scaffoldKey: ,
        builder: (context, constraints) {
      return SafeArea(
        child: Container(
          decoration: BoxDecoration(gradient: lightgradientBG),
          child: Column(
            children: [
              appBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Utilities.commonSizedBox(paddingLarge),
                      sliderView(),
                      Utilities.commonSizedBox(paddingMedium * 2),
                      _slider()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  sliderView() {
    return Column(
      children: [
        CarouselSlider(
          carouselController: carouse,
          items: widget.trackDetail.playlists.map((value) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: CachedNetworkImageProvider(
                    "${RequestCode.apiEndPoint}${value.image}"),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                // color: Color.fromRGBO(255, 255, 255, 0.6),
                colorBlendMode: BlendMode.modulate,
              ),
            );
          }).toList(),
          options: CarouselOptions(
              onPageChanged: (index, res) async {
                if (_index < index) {
                  _player.seekToNext();
                } else {
                  _player.seekToPrevious();
                }
                _index = index;
              },
              enlargeCenterPage: true,
              height: MediaQuery.of(context).size.height / 3),
          // carouselController: _controller,
        ),
        Utilities.commonSizedBox(paddingMedium * 2),
        StreamBuilder<SequenceState>(
          stream: _player.sequenceStateStream,
          builder: (context, snapshot) {
            final state = snapshot.data;
            if (state?.sequence?.isEmpty ?? true) return SizedBox();
            final metadata = state.currentSource?.tag as AudioMetadata;
            return Padding(
              padding: EdgeInsets.only(
                left: commonPadding * 3,
                right: commonPadding * 3,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    metadata.album,
                    style: primaryMedium(fontSize: textXLarge),
                    textAlign: TextAlign.center,
                  ),
                  Utilities.commonSizedBox(paddingMedium),
                  Html(data: metadata.title)
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _slider() {
    return StreamBuilder<Duration>(
      stream: _player.durationStream,
      builder: (context, snapshot) {
        final duration = snapshot.data ?? Duration.zero;
        return StreamBuilder<Duration>(
          stream: _player.positionStream,
          builder: (context, snapshot) {
            var position = snapshot.data ?? Duration.zero;
            if (position > duration) {
              position = duration;
            }
            var _value = 0.0;
            var width = MediaQuery.of(context).size.width - 230;
            var barWidth = 2.0;

            var _max = 0.0;
            if (position != null) {
              _value = position.inMilliseconds.toDouble();
            }
            if (duration != null) {
              _max = duration.inMilliseconds.toDouble();
            }
            _myKey.currentState?.updatePostion(_value, _max);
            return Padding(
              padding: EdgeInsets.only(
                left: commonPadding * 3,
                right: commonPadding * 3,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WaveSlider(
                        key: _myKey,
                        initialBarPosition: 0,
                        barWidth: barWidth,
                        maxBarHight: 40,
                        width: width,
                      )
                    ],
                  ),
                  Utilities.commonSizedBox(paddingMedium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width * 0.1,
                                  margin: EdgeInsets.only(top: 20),
                                  child: Text(
                                      position != null
                                          ? Utilities.durationFormat(position)
                                          : "00:00",
                                      style: primarySemiBold())),
                              IconButton(
                                icon: Icon(
                                  Icons.replay_10,
                                  size: iconSize * 2,
                                  color: colorPrimary,
                                ),
                                onPressed: () => {
                                  _player.seek(Duration(
                                      milliseconds: _value.toInt() - 10000))
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.forward_10_sharp,
                              size: iconSize * 2,
                              color: colorPrimary,
                            ),
                            onPressed: () => {
                              _player.seek(Duration(
                                  milliseconds: _value.toInt() + 10000))
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              duration != null
                                  ? Utilities.durationFormat(duration)
                                  : "00:00",
                              style: primarySemiBold(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Utilities.commonSizedBox(paddingMedium + 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StreamBuilder<bool>(
                        stream: _player.shuffleModeEnabledStream,
                        builder: (context, snapshot) {
                          final shuffleModeEnabled = snapshot.data ?? false;
                          return IconButton(
                            icon: shuffleModeEnabled
                                ? Icon(Icons.shuffle, color: Colors.orange)
                                : Image.asset(
                                    AssetsImage.shuffel,
                                    height: iconSize,
                                    width: iconSize,
                                  ),
                            onPressed: () async {
                              final enable = !shuffleModeEnabled;
                              if (enable) {
                                await _player.shuffle();
                              }
                              await _player.setShuffleModeEnabled(enable);
                            },
                          );
                        },
                      ),
                      StreamBuilder<SequenceState>(
                        stream: _player.sequenceStateStream,
                        builder: (context, snapshot) => IconButton(
                          icon: Image.asset(
                            AssetsImage.previousIc,
                            height: iconSize,
                            width: iconSize,
                          ),
                          onPressed: !_player.hasPrevious
                              ? null
                              : () {
                                  carouse.jumpToPage(
                                      _player.sequenceState.currentIndex - 1);
                                  _player.seekToPrevious();
                                },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (_player.playing) {
                            _player.pause();
                          } else {
                            _player.play();
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            height: 60,
                            width: 60,
                            color: colorTheme,
                            child: Center(
                              child: Icon(
                                _player.playing
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
                      StreamBuilder<SequenceState>(
                        stream: _player.sequenceStateStream,
                        builder: (context, snapshot) => IconButton(
                            icon: Image.asset(
                              AssetsImage.nextIc,
                              height: iconSize,
                              width: iconSize,
                            ),
                            onPressed: !_player.hasNext
                                ? null
                                : () {
                                    // ignore: unnecessary_statements
                                    carouse.jumpToPage(
                                        _player.sequenceState.currentIndex + 1);
                                    _player.seekToNext();
                                  }),
                      ),
                      StreamBuilder<LoopMode>(
                        stream: _player.loopModeStream,
                        builder: (context, snapshot) {
                          final loopMode = snapshot.data ?? LoopMode.off;

                          var icons = [
                            Image.asset(
                              AssetsImage.loopIc,
                              height: iconSize,
                              width: iconSize,
                            ),
                            Icon(Icons.repeat, color: Colors.orange),
                            Icon(Icons.repeat_one, color: Colors.orange),
                          ];
                          const cycleModes = [
                            LoopMode.off,
                            LoopMode.all,
                            LoopMode.one,
                          ];
                          final index = cycleModes.indexOf(loopMode);
                          return IconButton(
                            icon: icons[index],
                            onPressed: () {
                              _player.setLoopMode(cycleModes[
                                  (cycleModes.indexOf(loopMode) + 1) %
                                      cycleModes.length]);
                            },
                          );
                        },
                      ),
                      // Image.asset(
                      //   AssetsImage.loopIc,
                      //   height: iconSize,
                      //   width: iconSize,
                      // ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  appBar() {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(
        top: paddingSmall + 4,
        bottom: paddingSmall + 4,
        left: commonPadding,
        right: commonPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              SvgImages.subPageBackArrowIc,
              height: iconSize - 4,
              width: iconSize - 4,
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.79,
                      child: Marquee(
                        animationDuration: Duration(seconds: 2),
                        backDuration: Duration(seconds: 2),
                        pauseDuration: Duration(milliseconds: 1000),
                        directionMarguee: DirectionMarguee.TwoDirection,
                        autoRepeat: true,
                        child: Text(
                          widget.trackDetail.title,
                          style: themeFontMedium(fontSize: textSmall + 2),
                        ),
                      ),
                    ),

                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AudioMetadata {
  final String album;
  final String title;
  final String artwork;

  AudioMetadata(
      {@required this.album, @required this.title, @required this.artwork});
}
