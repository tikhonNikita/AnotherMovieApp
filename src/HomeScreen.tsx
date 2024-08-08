import React from 'react';
import {SafeAreaView, StyleSheet} from 'react-native';
import {MovieListView} from 'react-native-movie-list';
import {useMovies} from './data/useMovieList';
import {useMovieDetails} from './data/useMovieDetails';
import {MovieDetails} from './data/types';

const populateMovieWithFavorites = (
  movie: MovieDetails | undefined,
  favorites: number[],
): MovieDetails | undefined => {
  if (movie === undefined) {
    return movie;
  }
  return {
    ...movie,
    isFavourite: favorites.includes(movie.id),
  };
};

export const HomeScreen = () => {
  const [selectedMovieId, setSelectedMovieId] = React.useState<number | null>(
    null,
  );
  const {data, status} = useMovies();
  const [favorites, setFavorites] = React.useState<number[]>([]);
  const {data: selectedMovieDetails, status: movieDetailsStatus} =
    useMovieDetails(selectedMovieId);

  const finalMovieDetails = populateMovieWithFavorites(
    selectedMovieDetails,
    favorites,
  );

  return (
    <SafeAreaView style={styles.container}>
      <MovieListView
        onMovieRemovedFromFavorites={({nativeEvent: {movieID}}) => {
          const movieIDNum = Number(movieID);
          setFavorites(favorites.filter(id => id !== movieIDNum));
        }}
        onMoviePress={({nativeEvent: {movieID}}) => {
          setSelectedMovieId(Number(movieID));
        }}
        movieDetailsStatus={movieDetailsStatus}
        movieDetails={finalMovieDetails}
        movies={data || []}
        style={StyleSheet.absoluteFill}
        movieListStatus={status}
        onMovieAddedToFavorites={({nativeEvent: {movieID}}) => {
          const movieIDNum = Number(movieID);
          setFavorites([...favorites, movieIDNum]);
        }}
      />
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'green',
  },
});
