import {FavouriteMovie} from './NativeFavouriteMoviesStorage';

export {default as MovieListView} from './MovieListViewNativeComponent';
export * from './MovieListViewNativeComponent';
const FavouriteMoviesStorage =
  require('./NativeFavouriteMoviesStorage').default;

export function getFavouriteMovies(): FavouriteMovie[] {
  return FavouriteMoviesStorage.getFavouriteMovies();
}

export function addFavouriteMovie(
  movie: FavouriteMovie,
): Promise<FavouriteMovie[]> {
  return FavouriteMoviesStorage.addFavouriteMovie(movie);
}

export function removeAllFavouriteMovies(): Promise<void> {
  return FavouriteMoviesStorage.removeAllFavouriteMovies();
}

export function removeFavouriteMovie(id: number): Promise<FavouriteMovie[]> {
  return FavouriteMoviesStorage.removeFavouriteMovie(id);
}
