import 'package:flutter/material.dart';

import 'package:peliculas/models/models.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({
    Key? key,
    required this.movies,
    required this.onNextPage,
    this.title
  }) : super(key: key);

  @override
  _MovieSliderState createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {    
    super.initState();
    scrollController.addListener((){
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 300) {
        widget.onNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          (widget.title != null)
            ? Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Text(widget.title!, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              )
            : Container(),

          SizedBox(height: 5.0),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: ( _ , int index) {
                final movie = widget.movies[index];
                return _MoviePoster(movie: movie);
              }
            )
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  final Movie movie;

  _MoviePoster({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.0,
      height: 190.0,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              movie.heroId = 'slider-${movie.id}';
              Navigator.pushNamed(context, 'details', arguments: movie);
            },
            child: Hero(
              tag: 'slider-${movie.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(movie.fullPosterPath)
                ),
              ),
            ),
          ),

          SizedBox(height: 5.0),

          Text(
            '${movie.title}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}