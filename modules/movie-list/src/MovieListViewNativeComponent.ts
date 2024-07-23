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

type OnMoviePressEventData = {
  readonly movieID: string;
};

interface NativeProps extends ViewProps {
  readonly movies: Movie[];
  readonly onMoviePress: DirectEventHandler<OnMoviePressEventData>;
  readonly movieListStatus?: WithDefault<
    'loading' | 'success' | 'error',
    'loading'
  >;
}

export default codegenNativeComponent<NativeProps>('MovieListView');
