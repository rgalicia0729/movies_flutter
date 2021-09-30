import 'package:flutter/material.dart';

import 'package:peliculas/models/models.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem({
    Key? key,
    required this.movie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: 'search-${movie.id}',
        child: FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'), 
          image: NetworkImage(movie.fullPosterPath),
          width: 50.0,
          fit: BoxFit.contain
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        movie.heroId = 'search-${movie.id}';
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}