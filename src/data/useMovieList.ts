import {useQuery, UseQueryResult} from '@tanstack/react-query';
import {Movie} from './types';
import {API_KEY} from '@env';

const TRENDING_MOVIES_URL = 'https://api.themoviedb.org/3/trending/movie/week';

interface ApiMovie {
  id: number;
  title: string;
  overview: string;
  vote_average: number;
  poster_path: string;
}

interface MoviesResponse {
  results: ApiMovie[];
  page: number;
  total_pages: number;
  total_results: number;
}

type Status = 'success' | 'loading' | 'error';

const pendingToLoading = (status: 'success' | 'error' | 'pending'): Status => {
  if (status === 'pending') {
    return 'loading';
  }
  return status;
};

const fetchMovies = async (): Promise<Movie[]> => {
  const urlParams = new URLSearchParams({api_key: API_KEY});
  const response = await fetch(
    `${TRENDING_MOVIES_URL}?${urlParams.toString()}`,
  );

  if (!response.ok) {
    const errorData = await response.json();
    throw new Error(
      `Error ${response.status}: ${response.statusText} - ${errorData.status_message}`,
    );
  }

  const data: MoviesResponse = await response.json();

  return data.results.map(movie => ({
    id: movie.id,
    url: `https://image.tmdb.org/t/p/w500${movie.poster_path}`,
    title: movie.title,
    movieDescription: movie.overview,
    rating: movie.vote_average,
  }));
};

type MovieQueryResult = Omit<UseQueryResult<Movie[]>, 'status'> & {
  status: Status;
};

export const useMovies = (): MovieQueryResult => {
  const queryResult = useQuery<Movie[], Error>({
    queryKey: ['movies'],
    queryFn: fetchMovies,
  });
  const status = pendingToLoading(queryResult.status);

  return {...queryResult, status};
};
