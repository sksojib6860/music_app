import 'package:flutter/material.dart';
import 'package:music_player/model/song_model.dart';

class SongTile extends StatelessWidget {
  final int currentSongIndex;
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final int songIndex;
  final SongModel songModel;
  final bool isPlaying;
  final VoidCallback onTileTap;

  const SongTile({
    super.key,
    required this.songModel,
    required this.songIndex,
    required this.onPlay,
    required this.onPause,
    required this.currentSongIndex,
    required this.isPlaying,
    required this.onTileTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCurrentSong = currentSongIndex == songIndex;
    final bool isCurrentlyPlaying = isPlaying && isCurrentSong;

    return Container(
      clipBehavior : Clip.hardEdge,
       margin: const EdgeInsets.symmetric(vertical: 4,),
      decoration : BoxDecoration(
        borderRadius : BorderRadius.circular(12),
      ),
      child: Material(

        color: Colors.white,
        child: InkWell(
          onTap: onTileTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isCurrentSong
                  ? Theme.of(context).colorScheme.primary.withAlpha(150)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isCurrentSong
                  ? Border.all(
                color: Theme.of(context).colorScheme.primary.withAlpha(300)
              )
                  : null,
            ),
            child: Row(
              children: [

                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isCurrentSong
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.withAlpha(200),
                    shape: BoxShape.circle,
                  ),
                  child: isCurrentlyPlaying
                      ? Icon(
                    Icons.equalizer_rounded,
                    color: Colors.white,
                    size: 20,
                  )
                      : Text(
                    "${songIndex + 1}",
                    style: TextStyle(
                      color: isCurrentSong ? Colors.white : Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        songModel.songName,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: isCurrentSong
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurface,
                          fontWeight: isCurrentSong ? FontWeight.w600 : FontWeight.normal,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        songModel.artist,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isCurrentSong
                              ? Theme.of(context).colorScheme.primary.withAlpha(185)
                              : Colors.grey,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isCurrentSong
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.withAlpha(100),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      isCurrentlyPlaying ? onPause() : onPlay();
                    },
                    icon: Icon(
                      isCurrentlyPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                      color: isCurrentSong ? Colors.white : Theme.of(context).colorScheme.onSurface,
                      size: 20,
                    ),
                    padding: EdgeInsets.zero,
                    style: IconButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}