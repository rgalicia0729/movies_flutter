import 'package:flutter/material.dart';

import 'package:peliculas/models/models.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _CustomeAppBar(title: movie.title, backdropPath: movie.fullBackdropPath),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(
                heroId: movie.heroId!,
                title: movie.title,
                originalTitle: movie.originalTitle,
                voteAverage: movie.voteAverage,
                posterPath: movie.fullPosterPath,
              ),
              _Overview(overview: movie.overview),
              CastingList(movieId: movie.id)
            ])
          )
        ],
      )
    );
  }
}

class _CustomeAppBar extends StatelessWidget {
  final String title;
  final String backdropPath;

  _CustomeAppBar({
    required this.title,
    required this.backdropPath
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: size.height * 0.2,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: size.width,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: EdgeInsets.only(bottom: 10.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          )
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'), 
          image: NetworkImage(backdropPath),
          fit: BoxFit.cover
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final String heroId;
  final String title;
  final String originalTitle;
  final double voteAverage;
  final String posterPath;

  _PosterAndTitle({
    required this.heroId,
    required this.title,
    required this.originalTitle,
    required this.voteAverage,
    required this.posterPath
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: heroId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(posterPath),
                height: 150.0,
              ),
            ),
          ),

          SizedBox(width: 20.0),

          Container(
            width: size.width * 0.61,
            height: size.height * 0.13,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2),
                Text(originalTitle, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis),

                Row(
                  children: <Widget>[
                    Icon(Icons.star_outline, color: Colors.grey),
                    SizedBox(width: 5.0),
                    Text('$voteAverage', style: textTheme.caption)
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

class _Overview extends StatelessWidget {
  final String overview;

  _Overview({
    required this.overview
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Text(
        overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}