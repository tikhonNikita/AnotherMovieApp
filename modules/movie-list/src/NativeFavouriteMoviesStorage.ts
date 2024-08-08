import type {TurboModule} from 'react-native';
import {TurboModuleRegistry} from 'react-native';
import {Int32} from 'react-native/Libraries/Types/CodegenTypes';

export interface FavouriteMovie {
  id: Int32;
  url: string;
  status: string;
  title: string;
  rating: string;
}

export interface Spec extends TurboModule {
  getFavouriteMovies(): FavouriteMovie[];
  addFavouriteMovie(movie: FavouriteMovie): Promise<FavouriteMovie[]>;
  removeFavouriteMovie(movieId: number): Promise<FavouriteMovie[]>;
  removeAllFavouriteMovies(): Promise<void>;
}

export default TurboModuleRegistry.getEnforcing<Spec>('FavouriteMoviesStorage');
