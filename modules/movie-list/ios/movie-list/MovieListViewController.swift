//
//  MovieListViewController.swift
//  react-native-movie-list
//
//  Created by Nikita Tikhonov on 06.07.2024.
//

import Foundation
import SwiftUI


import SwiftUI

@objc public class MovieListViewController: UIViewController {
    private var viewModel: MovieViewModel
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupHostingController()
    }

    @objc public static func createViewController(onMoviePress: @escaping (String) -> Void) -> MovieListViewController {
        let viewModel = MovieViewModel(movies: [])
        viewModel.setOnPressHandler(onMoviePress: onMoviePress)
        return MovieListViewController(viewModel: viewModel)
    }
    
    @objc public func updateMovies(movies: [Movie]) -> Void {
        self.viewModel.updateMovies(newMovies: movies)
    }
    
    @objc public func updateStatus(status: NetworkStatus) -> Void {
        self.viewModel.updateStatus(status: status)
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
