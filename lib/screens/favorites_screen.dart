import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:youtube_favorites/api.dart';
import 'package:youtube_favorites/blocs/favoriet_bloc.dart';
import 'package:youtube_favorites/models/video.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoriteBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favoritos',
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        initialData: {},
        builder: (BuildContext context, snapshot) {
          return ListView(
              children: snapshot.data.values.map((v) {
            return InkWell(
              onTap: () {
                FlutterYoutube.playYoutubeVideoById(apiKey: API_KEY, videoId: v.id);
              },
              onLongPress: () {
                bloc.toggleFavorite(v);
              },
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100.0,
                    height: 50.0,
                    child: Image.network(v.thumbnail),
                  ),
                  Expanded(
                    child: Text(
                      v.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            );
          }).toList());
        },
        stream: bloc.outFav,
      ),
    );
  }
}
