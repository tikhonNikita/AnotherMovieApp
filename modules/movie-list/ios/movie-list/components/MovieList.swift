//
//  MovieList.swift
//  react-native-movie-list
//
//  Created by Nikita Tikhonov on 06.07.2024.
//

import SwiftUI

struct MovieList: View {
    @ObservedObject var viewModel: MovieViewModel
    @State private var isOpen: Bool = false

    var body: some View {
        VStack {
            if(viewModel.movieListStatus != .loading) {
                List(viewModel.movies) { movie in
                    MovieItem(movie: movie)
                        .padding(.vertical, 4)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            isOpen = true;
                            if let onMoviePress = viewModel.onMoviePress {
                                onMoviePress(String(movie.id))
                            }
                        }
                }
                .listStyle(PlainListStyle())
                .padding(8)
            } else {
                ProgressView()
            }
        }
        .sheet(isPresented: $isOpen) {
            if(viewModel.seletedMovieDetailsStatus == .loading) {
                ProgressView()
            } else {
                Text(viewModel.selectedMovieDetails?.title ?? "Empty")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
            }
        }
    }
}
