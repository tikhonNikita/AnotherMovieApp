//
//  MoviesViewModel.swift
//  react-native-movie-list
//
//  Created by Nikita Tikhonov on 06.07.2024.
//

import Foundation
import SwiftUI


@objc public enum NetworkStatus: Int {
    case loading
    case error
    case success
}

public class MovieViewModel: NSObject, ObservableObject {
    @Published @objc public var movies: [Movie] = []
    @Published @objc public var selectedMovieDetails: MovieDetails?
    @Published @objc public var seletedMovieDetailsStatus: NetworkStatus
    @Published @objc public var movieListStatus: NetworkStatus
    @Published var onMoviePress: ((String) -> Void)?
    @Published var onMovieAddedToFavorites: ((String) -> Void) = { _ in }
    @Published var onMovieRemovedToFavorites: ((String) -> Void) = {_ in }

    
    public override init() {
        self.movies = []
        self.movieListStatus = .loading
        self.seletedMovieDetailsStatus = .loading
        super.init()
    }
    
    public init(movies: [Movie]) {
        if(movies.isEmpty) {
            self.movieListStatus = .loading
        } else {
            self.movieListStatus = .success
        }
        self.seletedMovieDetailsStatus = .loading
        super.init()
        self.movies = movies
    }
    
    public func updateMovies(newMovies: [Movie]) {
        self.movies = newMovies
    }
    
    public func updateMovieListStatus(status: NetworkStatus) {
        self.movieListStatus = status
    }
    
    public func setOnPressHandler(onMoviePress: @escaping ((String) -> Void)) {
        self.onMoviePress = onMoviePress
    }
    
    public func setOnMovieAddedToFavorites(onMovieAddedToFavorites: @escaping ((String) -> Void)) {
        self.onMovieAddedToFavorites = onMovieAddedToFavorites
    }
    public func setOnMovieRemovedToFavorites(onMovieRemovedToFavorites: @escaping ((String) -> Void)) {
        self.onMovieRemovedToFavorites = onMovieRemovedToFavorites
    }
    
    public func updateMovieDetailsStatus(status: NetworkStatus) {
        self.seletedMovieDetailsStatus = status
    }
    
    public func updateSelectedMovieDetails(newSelectedMovie: MovieDetails) {
        self.selectedMovieDetails = newSelectedMovie
    }

}

