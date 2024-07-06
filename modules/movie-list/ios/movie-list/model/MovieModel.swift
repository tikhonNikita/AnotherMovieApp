//
//  MovieModel.swift
//  react-native-movie-list
//
//  Created by Nikita Tikhonov on 05.07.2024.
//

import Foundation

@objc public class Movie: NSObject, Identifiable {
    @objc public let id: Int
    @objc public let url: String
    @objc public let title: String
    @objc public let movieDescription: String
    @objc public let rating: Double
    
    @objc init(id: Int, url: String, title: String, movieDescription: String, rating: Double) {
        self.id = id
        self.url = url
        self.title = title
        self.movieDescription = movieDescription
        self.rating = rating
    }
}
