import React from 'react';
import {SafeAreaView, StyleSheet} from 'react-native';
import {MovieListView} from 'react-native-movie-list';
import {useMovies} from './data/useMovieList';
import {useMovieDetails} from './data/useMovieDetails';

export const HomeScreen = () => {
  const [selectedMovieId, setSelectedMovieId] = React.useState<number | null>(
    null,
  );
  const {data, status} = useMovies();
  const {data: selectedMovieDetails, status: movieDetailsStatus} =
    useMovieDetails(selectedMovieId);

  console.log('Details Data', selectedMovieDetails);
  console.log('Status Data', movieDetailsStatus);

  return (
    <SafeAreaView style={styles.container}>
      <MovieListView
        onMoviePress={({nativeEvent: {movieID}}) => {
          setSelectedMovieId(Number(movieID));
        }}
        movieDetailsStatus={movieDetailsStatus}
        movieDetails={selectedMovieDetails}
        movies={data || []}
        style={StyleSheet.absoluteFill}
        movieListStatus={status}
        onMovieAddedToFavorites={({nativeEvent: {movieID}}) => {
          console.log('Movie added to favorites:', movieID);
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
