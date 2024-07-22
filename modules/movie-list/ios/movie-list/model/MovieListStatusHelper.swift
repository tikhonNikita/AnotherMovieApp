//
//  MovieListStatusHelper.swift
//  react-native-movie-list
//
//  Created by Nikita Tikhonov on 22.07.2024.
//

import Foundation

@objc public class MovieListStatusHelper: NSObject {
    @objc public static func createSuccess() -> MovieListStatus {
        return .success
    }
    @objc public static func createError() -> MovieListStatus {
        return .error
    }
    @objc public static func createLoading() -> MovieListStatus {
        return .loading
    }
}
