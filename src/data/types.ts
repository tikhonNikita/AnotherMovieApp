export interface Movie {
  id: number;
  url: string;
  title: string;
  movieDescription: string;
  rating: number;
}

interface Genre {
  id: number;
  name: string;
}

export interface MovieDetails {
  readonly id: number;
  readonly title: string;
  readonly posterURL: string;
  readonly overview: string;
  readonly genres: Genre[];
  readonly rating: number;
}
