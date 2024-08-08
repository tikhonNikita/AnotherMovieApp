//
//  FavouriteMoviesManager.swift
//  react-native-movie-list
//
//  Created by Nikita Tikhonov on 05.08.2024.
//

import Foundation
import RealmSwift

@objc
public class FavouriteMoviesManager: NSObject {
    @objc public static let shared = FavouriteMoviesManager()

    private override init() {}

    @objc
    public func addFavouriteMovie(_ movie: IntermediateFavouriteMovie, onSuccess: @escaping ([IntermediateFavouriteMovie]) -> Void, onError: @escaping (Error) -> Void) {
        let realmMovie = RealmFavouriteMovie(favouriteMovie: movie)
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                realm.writeAsync({
                    realm.add(realmMovie, update: .modified)
                }, onComplete: { error in
                    if let error = error {
                        DispatchQueue.main.async {
                            onError(error)
                        }
                    } else {
                        let movies = realm.objects(RealmFavouriteMovie.self).map { IntermediateFavouriteMovie(realmMovie: $0) }
                        DispatchQueue.main.async {
                            onSuccess(Array(movies))
                        }
                    }
                })
            } catch {
                DispatchQueue.main.async {
                    onError(error)
                }
            }
        }
    }

    @objc
    public func removeFavouriteMovie(byID movieID: Int, onSuccess: @escaping ([IntermediateFavouriteMovie]) -> Void, onError: @escaping (Error) -> Void) {
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                realm.writeAsync({
                    if let movie = realm.object(ofType: RealmFavouriteMovie.self, forPrimaryKey: movieID) {
                        realm.delete(movie)
                    }
                }, onComplete: { error in
                    if let error = error {
                        DispatchQueue.main.async {
                            onError(error)
                        }
                    } else {
                        let movies = realm.objects(RealmFavouriteMovie.self).map { IntermediateFavouriteMovie(realmMovie: $0) }
                        DispatchQueue.main.async {
                            onSuccess(Array(movies))
                        }
                    }
                })
            } catch {
                DispatchQueue.main.async {
                    onError(error)
                }
            }
        }
    }

    @objc
    public func removeAllFavouriteMovies(onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let realm = try Realm()
                let allMovies = realm.objects(RealmFavouriteMovie.self)
                try realm.write {
                    realm.delete(allMovies)
                }
                DispatchQueue.main.async {
                    onSuccess()
                }
            } catch {
                DispatchQueue.main.async {
                    onError(error)
                }
            }
        }
    }

    @objc
    public func fetchAllFavouriteMoviesAsList() -> [IntermediateFavouriteMovie] {
        do {
            let realm = try Realm()
            let movies = realm.objects(RealmFavouriteMovie.self).map { IntermediateFavouriteMovie(realmMovie: $0) }
            return Array(movies)
        } catch {
            return []
        }
    }
}
