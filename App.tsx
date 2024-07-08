/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React from 'react';
import {SafeAreaView, StyleSheet} from 'react-native';
import {MovieListView} from 'react-native-movie-list';

const App = () => {
  return (
    <SafeAreaView style={styles.container}>
      <MovieListView
        movies={[]}
        style={{
          width: '100%',
          height: '100%',
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
    backgroundColor: '#F5FCFF',
  },
});

export default App;
