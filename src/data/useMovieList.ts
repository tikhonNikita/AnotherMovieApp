import {useQuery, UseQueryResult} from '@tanstack/react-query';
import {Movie} from './types';
import {fetchTrendingMovies} from '../api/fetchTrendingMovies';

type Status = 'success' | 'loading' | 'error';

const pendingToLoading = (status: 'success' | 'error' | 'pending'): Status => {
  if (status === 'pending') {
    return 'loading';
  }
  return status;
};

type MovieQueryResult = Omit<UseQueryResult<Movie[]>, 'status'> & {
  status: Status;
};

export const useMovies = (): MovieQueryResult => {
  const queryResult = useQuery<Movie[], Error>({
    queryKey: ['movies'],
    queryFn: fetchTrendingMovies,
  });
  const status = pendingToLoading(queryResult.status);

  return {...queryResult, status};
};
