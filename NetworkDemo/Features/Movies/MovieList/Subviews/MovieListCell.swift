//
//  MovieCard.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 11/03/2022.
//

import SwiftUI

struct MovieListCell: View {
    private let imageHeight = 120.0
    private let verticalPadding = 8.0
    
    var movie: DataModel.Movie
    
    var body: some View {
        HStack(spacing: 12.0) {
            posterImage()
                .cornerRadius(8.0)
                .frame(maxWidth: 76.0, maxHeight: imageHeight)
            
            VStack(alignment: .leading, spacing: 8.0) {
                Text(movie.title)
                    .font(.title2)
                    .fontWeight(.bold)
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String.init(format: "%.1f", movie.voteAverage))
                        .fontWeight(.semibold)
                }
                Text(movie.releaseDate)
            }
            
        }
        .frame(maxWidth: .infinity, minHeight: imageHeight, alignment: .leading)
    }
    
    @ViewBuilder
    private func posterImage() -> some View {
        if let imageUrl = movie.smallPosterUrl {
            CachedAsyncImage(
                url: imageUrl
            ) { phase in
                switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure(let error):
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                }
            }
        } else {
            Image(systemName: "photo")
        }
    }
}

struct MovieListCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MovieListCell(
                movie: .init(
                    id: 1,
                    title: "Movie title",
                    releaseDate: "12 Mar, 2022",
                    originalLanguage: "Spanish",
                    voteAverage: 8.6,
                    posterPath: "/74xTEgt7R36Fpooo50r9T25onhq.jpg"
                )
            )
        }
        .previewLayout(.sizeThatFits)
    }
}
