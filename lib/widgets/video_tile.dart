import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:youtube_favorites/api.dart';
import 'package:youtube_favorites/blocs/favoriet_bloc.dart';
import 'package:youtube_favorites/models/video.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoriteBloc>();

    return GestureDetector(
      onTap: () {
        FlutterYoutube.playYoutubeVideoById(
            apiKey: API_KEY, videoId: video.id, appBarColor: Colors.black87, fullScreen: true);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16.0 / 9.0,
              child: Image.network(
                video.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(
                          video.title,
                          maxLines: 2,
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          video.channel,
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<Map<String, Video>>(
                  initialData: {},
                  stream: bloc.outFav,
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return IconButton(
                        icon: Icon(snapshot.data.containsKey(video.id)
                            ? Icons.star
                            : Icons.star_border),
                        color: Colors.white,
                        iconSize: 30.0,
                        onPressed: () {
                          bloc.toggleFavorite(video);
                        },
                      );
                    else
                      return CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.red));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
