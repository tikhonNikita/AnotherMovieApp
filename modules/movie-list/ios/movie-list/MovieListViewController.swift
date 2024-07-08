//
//  MovieListViewController.swift
//  react-native-movie-list
//
//  Created by Nikita Tikhonov on 06.07.2024.
//

import Foundation
import SwiftUI


import SwiftUI

let movies = [
    Movie(id: 1, url: "https://hws.dev/paul.jpg", title: "Sverh kino", movieDescription: "Sverh interesnoe kino", rating: 3),
    Movie(id: 2, url: "https://hws.dev/sarah.jpg", title: "Epicheskaya saga", movieDescription: "Epicheskaya istoriya polna syuzhetov", rating: 4.5),
    Movie(id: 3, url: "https://hws.dev/tom.jpg", title: "Komediya vseh vremyon", movieDescription: "Smeytes' vslukh", rating: 4),
    Movie(id: 4, url: "https://hws.dev/anna.jpg", title: "Drama v vechnoi temnote", movieDescription: "Glubokaya i myslennaya drama", rating: 4.8),
    Movie(id: 5, url: "https://hws.dev/julia.jpg", title: "Priklyuchencheskiy boevik", movieDescription: "Adrenalin i opasnost' na kazhdom shagu", rating: 3.5),
    Movie(id: 6, url: "https://hws.dev/henry.jpg", title: "Misteriya s zamkom", movieDescription: "Raskroyte sekrety zamka", rating: 4.2),
    Movie(id: 7, url: "https://hws.dev/lara.jpg", title: "Romanticheskaya melodrama", movieDescription: "Istoriya lyubvi, kotoraya trepet", rating: 4.1),
    Movie(id: 8, url: "https://hws.dev/mike.jpg", title: "Fantasticheskiy mir", movieDescription: "Uletayte v drugoy mir", rating: 3.7),
    Movie(id: 9, url: "https://hws.dev/emma.jpg", title: "Klassicheskiy detektiv", movieDescription: "Raskryt' zhadnyy zagovor", rating: 4.3),
    Movie(id: 10, url: "https://hws.dev/leo.jpg", title: "Ekshn-treylor", movieDescription: "Nepreryvnyy ekshn i napryazhennost'", rating: 3.9)
]

@objc public class MovieListViewController: UIViewController {
    private var viewModel: MovieViewModel
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupHostingController()
    }

    @objc public static func createViewController() -> MovieListViewController {
        let viewModel = MovieViewModel(movies: movies)
        return MovieListViewController(viewModel: viewModel)
    }
    
    @objc public func updateMovies(movies: [Movie]) -> Void {
        self.viewModel.updateMovies(newMovies: movies)
    }


    private func setupHostingController() {
        let hostingController = UIHostingController(rootView: MovieList(viewModel: viewModel))
        self.addChild(hostingController)
        self.view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
