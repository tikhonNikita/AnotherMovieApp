//
//  MoviesViewModel.swift
//  react-native-movie-list
//
//  Created by Nikita Tikhonov on 06.07.2024.
//

import Foundation
import SwiftUI

@objc public class MovieViewModel: NSObject, ObservableObject {
    @Published @objc public var movies: [Movie] = []
    
    @objc public override init() {
        super.init()
        self.movies = []
    }
    
    @objc public init(movies: [Movie]) {
        super.init()
        self.movies = movies
    }
    
    @objc public func updateMovies(newMovies: [Movie]) {
        self.movies = newMovies
    }
}
