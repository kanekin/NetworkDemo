//
//  MovieCard.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 11/03/2022.
//

import SwiftUI

struct MovieListCell: View {
    var movie: DataModel.Movie
    
    var body: some View {
        HStack(spacing: 12.0) {
            CachedAsyncImage(
                url: movie.smallPosterUrl
            ) { phase in
                switch phase {
                    case .empty:
                        let _ = print("loading \(movie.title) \(movie.posterPath)")
                        ProgressView()
                            .frame(maxWidth: 100, maxHeight: 100)
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 100)
                    case .failure(let error):
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                }
            }
            .cornerRadius(8.0)
            
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
        .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
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