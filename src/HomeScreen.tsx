import React from 'react';
import {SafeAreaView, StyleSheet} from 'react-native';
import {MovieListView} from 'react-native-movie-list';

const movies = [
  {
    id: 1,
    url: 'https://hws.dev/paul.jpg',
    title: 'Sverh kina',
    movieDescription: 'Sverh interesnoe kino',
    rating: 3,
  },
  {
    id: 2,
    url: 'https://hws.dev/sarah.jpg',
    title: 'Epicheskaya saga',
    movieDescription: 'Epicheskaya istoriya polna syuzhetov',
    rating: 4.5,
  },
  {
    id: 3,
    url: 'https://hws.dev/tom.jpg',
    title: 'Komediya vseh vremyon',
    movieDescription: "Smeytes' vslukh",
    rating: 4,
  },
  {
    id: 4,
    url: 'https://hws.dev/anna.jpg',
    title: 'Drama v vechnoi temnote',
    movieDescription: 'Glubokaya i myslennaya drama',
    rating: 4.8,
  },
  {
    id: 5,
    url: 'https://hws.dev/julia.jpg',
    title: 'Priklyuchencheskiy boevik',
    movieDescription: "Adrenalin i opasnost' na kazhdom shagu",
    rating: 3.5,
  },
];

export const HomeScreen = () => {
  return (
    <SafeAreaView style={styles.container}>
      <MovieListView
        movies={movies}
        style={StyleSheet.absoluteFill}
        movieListStatus={'success'}
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
