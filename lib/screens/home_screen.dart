import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:peliculas/search/search_delegate.dart';
 
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Películas en cine'),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search_outlined),
              onPressed: () => showSearch(
                context: context, 
                delegate: MovieSearchDelegate()
              )
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Swiper cards principales
              CardSwiper(movies: moviesProvider.onDisplayMovies),

              // Slider cards de peliculas
              MovieSlider(
                onNextPage: () => moviesProvider.getPopularMovie(),
                movies: moviesProvider.popularMovies, 
                title: 'Populares'
              )
            ],
          ),
        )
      ),
    );
  }
}