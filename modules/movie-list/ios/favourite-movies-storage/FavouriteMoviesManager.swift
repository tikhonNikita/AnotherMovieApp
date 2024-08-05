//
//  FavouriteMoviesManager.swift
//  react-native-movie-list
//
//  Created by Nikita Tikhonov on 05.08.2024.
//

import Foundation
import RealmSwift

class FavouriteMoviesManager {
    static let shared = FavouriteMoviesManager()
    private var realm: Realm

    private init() {
        realm = try! Realm()
    }

    func addFavouriteMovie(_ movie: FavouriteMovie, onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        do {
            let realm = try Realm()
            realm.writeAsync({
                realm.add(movie)
            }, onComplete: { error in
                if let error = error {
                    onError(error)
                } else {
                    onSuccess()
                }
            })
        } catch {
            onError(error)
        }
    }

    func removeFavouriteMovie(byID movieID: Int, onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        do {
            let realm = try Realm()
            let movie = realm.object(ofType: FavouriteMovie.self, forPrimaryKey: movieID)
            realm.writeAsync({
                if let movie = movie {
                    realm.delete(movie)
                }
            }, onComplete: { error in
                if let error = error {
                    onError(error)
                } else {
                    if movie != nil {
                        onSuccess()
                    } else {
                        onError(NSError(domain: "FavouriteMovieManager", code: 404, userInfo: [NSLocalizedDescriptionKey: "Movie not found"]))
                    }
                }
            })
        } catch {
            onError(error)
        }
    }

    func fetchAllFavouriteMovies() -> Results<FavouriteMovie> {
        return realm.objects(FavouriteMovie.self)
    }
}
