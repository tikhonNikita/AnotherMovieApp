import codegenNativeComponent from 'react-native/Libraries/Utilities/codegenNativeComponent';
import type {ViewProps} from 'react-native';
import {
  Double,
  Int32,
  WithDefault,
  DirectEventHandler,
} from 'react-native/Libraries/Types/CodegenTypes';

type Movie = {
  readonly id: Int32;
  readonly title: string;
  readonly url: string;
  readonly movieDescription: string;
  readonly rating: Double;
};

type Genre = {
  id: Int32;
  name: string;
};

type MovieDetails = {
  readonly id: Int32;
  readonly title: string;
  readonly posterURL: string;
  readonly overview: string;
  readonly genres: Genre[];
  readonly rating: Double;
};

type OnMoviePressEventData = {
  readonly movieID: string;
};

type OnMovieAddedToFavorites = {
  readonly movieID: string;
};

type NetworkStatus = WithDefault<'loading' | 'success' | 'error', 'loading'>;

interface NativeProps extends ViewProps {
  readonly movies: Movie[];
  readonly onMoviePress: DirectEventHandler<OnMoviePressEventData>;
  readonly onMovieAddedToFavorites: DirectEventHandler<OnMovieAddedToFavorites>;
  readonly movieListStatus?: NetworkStatus;
  readonly movieDetailsStatus?: NetworkStatus;
  readonly movieDetails?: MovieDetails;
}

export default codegenNativeComponent<NativeProps>('MovieListView');
