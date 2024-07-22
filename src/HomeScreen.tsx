import React from 'react';
import {SafeAreaView, StyleSheet} from 'react-native';
import {MovieListView} from 'react-native-movie-list';
import {useMovies} from './data/useMovieList';

export const HomeScreen = () => {
  const {data, status} = useMovies();

  return (
    <SafeAreaView style={styles.container}>
      <MovieListView
        movies={data || []}
        style={StyleSheet.absoluteFill}
        movieListStatus={status}
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
