//
//  MovieList.swift
//  react-native-movie-list
//
//  Created by Nikita Tikhonov on 06.07.2024.
//

import SwiftUI

struct MovieList: View {
    @ObservedObject var viewModel: MovieViewModel
    var body: some View {
        List(viewModel.movies) { movie in
                    MovieItem(movie: movie)
                        .padding(.vertical, 4)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
        
                }
                .listStyle(PlainListStyle())
                .padding(8)
    }
}
