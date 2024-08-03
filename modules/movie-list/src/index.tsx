export {default as MovieListView} from './MovieListViewNativeComponent';
export * from './MovieListViewNativeComponent';
const FavouriteMoviesStorage =
  require('./NativeFavouriteMoviesStorage').default;

export function multiply(a: number, b: number): number {
  return FavouriteMoviesStorage.multiply(a, b);
}
