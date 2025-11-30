import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/model/song_model.dart';
import 'package:music_player/widgets/song_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  bool isPlaying = false;
  int currentSongIndex = 0;
  List<SongModel> songList = [
    SongModel(
      songName: "3-second synth melody",
      artist: "artist 1",
      songUrl: "https://samplelib.com/lib/preview/mp3/sample-3s.mp3",
      thumbnail:
          "https://d3jmn01ri1fzgl.cloudfront.net/photoadking/webp_thumbnail/white-music-youtube-thumbnail-template-9bpbt9b8cd486b.webp",
      duration: Duration(seconds: 3),
    ),
    SongModel(
      songName: "6-second synth melody",
      artist: "artist 2",
      songUrl: "https://samplelib.com/lib/preview/mp3/sample-6s.mp3",
      thumbnail:
          "https://static.vecteezy.com/system/resources/thumbnails/024/295/482/small/colorful-music-background-illustration-ai-generative-free-photo.jpg",
      duration: Duration(seconds: 6),
    ),
    SongModel(
      songName: "9-second melody using background drums",
      artist: "artist 3",
      songUrl: "https://samplelib.com/lib/preview/mp3/sample-9s.mp3",
      thumbnail:
          "https://www.shutterstock.com/image-illustration/music-themed-thumbnail-260nw-1125825584.jpg",
      duration: Duration(seconds: 9),
    ),
    SongModel(
      songName: "12-second melody using flute and whole drum ensemble",
      artist: "artist 4",
      songUrl: "https://samplelib.com/lib/preview/mp3/sample-12s.mp3",
      thumbnail:
          "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/music-party-youtube-thumbnail-design-template-2bb96f44eede7efdb7df008bfd9d6611_screen.jpg",
      duration: Duration(seconds: 12),
    ),
    SongModel(
      songName: "19 seconds of awesome music without using drums",
      artist: "artist 5",
      songUrl: "https://samplelib.com/lib/preview/mp3/sample-15s.mp3",
      thumbnail:
          "https://d3jmn01ri1fzgl.cloudfront.net/photoadking/webp_thumbnail/santa-fe-and-matrix-music-youtube-thumbnail-template-n25zqac19f9e2a.webp",
      duration: Duration(seconds: 19),
    ),
  ];
  final AudioPlayer player = AudioPlayer();

  Duration currentPosition = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorScheme.of(context).secondary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 310,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(300),
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              songList[currentSongIndex].thumbnail,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(color: Colors.black54),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 16),
                                Text(
                                  songList[currentSongIndex].songName,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  songList[currentSongIndex].artist,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(color: Colors.white70),
                                ),
                              ],
                            ),

                            // Progress Section
                            Column(
                              children: [
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 4,
                                    thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 8,
                                      disabledThumbRadius: 6,
                                    ),
                                    overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 16,
                                    ),
                                    activeTrackColor: ColorScheme.of(
                                      context,
                                    ).primary,
                                    inactiveTrackColor: Colors.white.withAlpha(
                                      300,
                                    ),
                                    thumbColor: Colors.white,
                                  ),
                                  child: Slider(
                                    value: currentPosition.inSeconds
                                        .clamp(0, songList[currentSongIndex].duration.inSeconds)
                                        .toDouble(),
                                    min: 0,
                                    max: songList[currentSongIndex]
                                        .duration
                                        .inSeconds
                                        .toDouble(),
                                    onChanged: (value) {
                                      final position = Duration(
                                        seconds: value.toInt(),
                                      );
                                      player.seek(position);
                                    },
                                  ),
                                ),
                                SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _durationFormatter(currentPosition),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.white70),
                                      ),
                                      Text(
                                        _durationFormatter(
                                          songList[currentSongIndex].duration,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Previous Button
                                  IconButton(
                                    onPressed: _playPrevSong,
                                    icon: Icon(Icons.skip_previous_rounded),
                                    iconSize: 32,
                                    color: Colors.white,
                                    style: IconButton.styleFrom(
                                      backgroundColor: Colors.white.withAlpha(
                                        100,
                                      ),
                                      padding: EdgeInsets.all(12),
                                    ),
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorScheme.of(
                                            context,
                                          ).primary.withAlpha(200),
                                          blurRadius: 12,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: isLoading
                                        ? Container(
                                            width: 60,
                                            height: 60,
                                            padding: EdgeInsets.all(16),
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    Colors.white,
                                                  ),
                                            ),
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              isPlaying
                                                  ? _pauseSong()
                                                  : _playSong(
                                                      songList[currentSongIndex],
                                                    );
                                            },
                                            icon: Icon(
                                              isPlaying
                                                  ? Icons.pause_rounded
                                                  : Icons.play_arrow_rounded,
                                            ),
                                            iconSize: 32,
                                            color: Colors.white,
                                            style: IconButton.styleFrom(
                                              backgroundColor: ColorScheme.of(
                                                context,
                                              ).primary,
                                              padding: EdgeInsets.all(16),
                                            ),
                                          ),
                                  ),


                                  IconButton(
                                    onPressed: _playNextSong,
                                    icon: Icon(Icons.skip_next_rounded),
                                    iconSize: 32,
                                    color: Colors.white,
                                    style: IconButton.styleFrom(
                                      backgroundColor: Colors.white.withAlpha(
                                        100,
                                      ),
                                      padding: EdgeInsets.all(12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Song List",
                  style: TextTheme.of(context).titleLarge,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                flex: 2,
                child: ListView.separated(
                  itemCount: songList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 5),
                  itemBuilder: (context, index) {
                    final songModel = songList[index];
                    return SongTile(
                      songIndex: index,
                      songModel: songModel,
                      onPlay: () {
                        currentSongIndex = index;
                        _playSong(songList[index]);
                      },
                      currentSongIndex: currentSongIndex,
                      isPlaying: isPlaying,
                      onPause: _pauseSong,
                      onTileTap: () {
                        setState(() {
                          currentSongIndex = index;
                        });
                      },
                    );
                  },
                  padding: EdgeInsets.all(5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _playSong(SongModel song) async {
    setState(() {
      setState(() {
        currentPosition = Duration.zero;
      });
      isLoading = true;
      isPlaying = true;
    });
    await player.play(UrlSource(song.songUrl));
    setState(() {
      isLoading = false;
    });
    player.onPositionChanged.listen(
      (event) => setState(() {
        currentPosition = event;
      }),
    );
    player.onPlayerComplete.listen((event) => _playNextSong());
  }

  Future<void> _pauseSong() async {
    setState(() {
      isPlaying = false;
    });
    await player.pause();
  }

  Future<void> _playNextSong() async {
    setState((){
      currentPosition = Duration(seconds : 0);
    });
    currentSongIndex = (currentSongIndex + 1) % songList.length;
    _playSong(songList[currentSongIndex]);
  }

  Future<void> _playPrevSong() async {
    setState((){
      currentPosition = Duration(seconds : 0);
    });

    currentSongIndex =
        (currentSongIndex - 1 + songList.length) % songList.length;
    _playSong(songList[currentSongIndex]);
  }

  String _durationFormatter(Duration duration) {
    final mnt = duration.inMinutes;
    final int sec = duration.inSeconds.remainder(60);

    return "$mnt:$sec";
  }
}
