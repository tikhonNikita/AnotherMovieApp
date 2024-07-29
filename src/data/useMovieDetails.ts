import {useQuery, UseQueryResult} from '@tanstack/react-query';
import {MovieDetails} from './types';
import {fetchMovieDetails} from '../api/fetchMovieDetails';

type Status = 'success' | 'loading' | 'error';

const pendingToLoading = (status: 'success' | 'error' | 'pending'): Status => {
  if (status === 'pending') {
    return 'loading';
  }
  return status;
};

type MovieDetailsQueryResult = Omit<UseQueryResult<MovieDetails>, 'status'> & {
  status: Status;
};

export const useMovieDetails = (
  movieId: number | null,
): MovieDetailsQueryResult => {
  const queryResult = useQuery<MovieDetails, Error>({
    queryKey: ['movieDetails', movieId],
    queryFn: () => {
      if (movieId === null) {
        throw new Error('movieId is null');
      }
      return fetchMovieDetails(movieId);
    },
    enabled: movieId !== null,
  });

  const status = pendingToLoading(queryResult.status);

  return {...queryResult, status};
};
