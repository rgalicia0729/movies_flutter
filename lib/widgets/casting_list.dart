import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/models/models.dart';

class CastingList extends StatelessWidget {
  final int movieId;

  const CastingList({
    Key? key, 
    required this.movieId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return FutureBuilder(
      future: moviesProvider.getMovieCredits(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: 180.0,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Cast> casts = snapshot.data!;

        return Container(
          width: size.width,
          height: 180.0,
          margin: EdgeInsets.only(bottom: 20.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: ( _ , int index) => _CastingCard(
              profilePath: casts[index].fullProfilePath, 
              name: casts[index].name
            )
          ),
        );
      }
    );
  }
}

class _CastingCard extends StatelessWidget {
  final String profilePath;
  final String name;

  const _CastingCard({
    Key? key, 
    required this.profilePath, 
    required this.name
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.0,
      width: 100.0,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'), 
              image: NetworkImage(profilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}