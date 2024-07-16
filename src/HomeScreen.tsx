/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React from 'react';
import {SafeAreaView, StyleSheet, View} from 'react-native';
import {MovieListView} from 'react-native-movie-list';

const movies = [
  {
    id: 1,
    url: 'https://hws.dev/paul.jpg',
    title: 'Sverh kino',
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
      <View
        style={{
          width: 150,
          height: 500,
          backgroundColor: 'blue',
        }}>
        <MovieListView movies={movies} />
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
});
