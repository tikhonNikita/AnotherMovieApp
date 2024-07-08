import codegenNativeComponent from 'react-native/Libraries/Utilities/codegenNativeComponent';
import type {ViewProps} from 'react-native';
import {Double, Int32} from 'react-native/Libraries/Types/CodegenTypes';

type Movie = {
  id: Int32;
  title: string;
  url: string;
  movieDescription: string;
  rating: Double;
};
interface NativeProps extends ViewProps {
  movies: Movie[];
}

export default codegenNativeComponent<NativeProps>('MovieListView');
