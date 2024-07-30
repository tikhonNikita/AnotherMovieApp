//
//  MovieDetailsView.swift
//  react-native-movie-list
//
//  Created by Nikita Tikhonov on 30.07.2024.
//
import SwiftUI

//TODO: add close button
//TODO: add ratings(see example in the notes)
//TODO: add add to favorites button
//TODO: improve description text styling. Maybe use another field


public struct RoundedBadge: View {
    public let text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        HStack {
            Text(text.capitalized)
                .foregroundStyle(.white)
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.leading, 10)
                .padding([.top, .bottom], 5)
                .padding(.trailing, 10)
        }
        .background(
            ZStack {
                Color.black
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(.ultraThinMaterial)
            }
        )
        .cornerRadius(8)
        .padding(.bottom, 4)
    }
}


struct MovieDetailsView: View {
    let movieDetails: MovieDetails
    var body: some View {
        ScrollView {
            VStack(
                alignment: .leading,
                spacing: 8.0
            ) {
                AsyncImage(url: URL(string: movieDetails.posterURL)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray.opacity(0.6)
                }
                .frame(height: 400)
                VStack(alignment: .leading) {
                    Text(movieDetails.title.uppercased())
                        .foregroundStyle(.blue)
                        .font(.system(size: 26, weight: .bold, design: .default))
                    HStack {
                        ForEach(movieDetails.genres) { genre in
                            RoundedBadge(text: genre.name)
                        }
                    }
                    Text(movieDetails.overview)
                }.padding()
            }
        }.ignoresSafeArea()
        
    }
}
