//
//  MoviesViewModel.swift
//  react-native-movie-list
//
//  Created by Nikita Tikhonov on 06.07.2024.
//

import Foundation
import SwiftUI


@objc public enum MovieListStatus: Int {
    case loading
    case error
    case success
}


@objc public class MovieViewModel: NSObject, ObservableObject {
    @Published @objc public var movies: [Movie] = []
    @Published @objc public var movieListStatus: MovieListStatus
    
    @objc public override init() {
        self.movies = []
        self.movieListStatus = .loading
        super.init()
    }
    
    @objc public init(movies: [Movie]) {
        if(movies.isEmpty) {
            self.movieListStatus = .loading
        } else {
            self.movieListStatus = .success
        }
        super.init()
        self.movies = movies
    }
    
    @objc public func updateMovies(newMovies: [Movie]) {
        self.movies = newMovies
    }
    
    @objc public func updateStatus(status: MovieListStatus) {
        self.movieListStatus = status
    }
}

